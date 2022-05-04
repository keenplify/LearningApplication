using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MySql.Data.MySqlClient;

namespace LearningApplication.Helpers
{
    public class User
    {
        public static void LogoutLogic(bool redirect = false)
        {
            Cookie.RemoveCookie("user", "email", null);
            Cookie.RemoveCookie("user", "password", null);
            if (redirect) HttpContext.Current.Response.Redirect("~/");
        }
        public static MySqlDataReader LoginLogic(string username, string password, bool redirect = false, bool isAdmin = false)
        {
            var Connection = Database.Connect();
            string query = "SELECT * FROM users_tbl WHERE username='" + username + "'";
            if (isAdmin) query += " AND is_admin=1";

            MySqlCommand cmd = new MySqlCommand(query, Connection);

            MySqlDataReader reader = cmd.ExecuteReader();
            System.Diagnostics.Debug.WriteLine(reader.HasRows);

            if (reader.HasRows != true) throw new InvalidOperationException("No user found!");

            reader.Read();
            string _pwd = reader.GetString("password");

            if (BCrypt.Net.BCrypt.Verify(password, _pwd))
            {
                Dictionary<string, string> userdata = new Dictionary<string, string>
                {
                    { "username", username },
                    { "password", password }
                };

                Cookie.StoreInCookieDictionary("user", null, userdata, null);
                if (redirect)
                {
                    if (reader.GetString(reader.GetOrdinal("is_admin")) == "1") HttpContext.Current.Response.Redirect("~/AdminDashboard");
                    else HttpContext.Current.Response.Redirect("~/UserDashboard");
                }
                return reader;
            }
            else
            {
                throw new InvalidOperationException("Invalid password!");
            }
        }

        public static void Register(string fullName, string username, string email, string password, string isAdmin = "0")
        {
            try
            {
                string passwordHash = BCrypt.Net.BCrypt.HashPassword(password, 10);
                string query =
                    "INSERT INTO users_tbl (" +
                    "full_name," +
                    "is_admin," +
                    "username," +
                    "email," +
                    "password) VALUES (" +
                    "'" + fullName + "'," +
                    "'" + isAdmin + "'," +
                    "'" + username + "'," +
                    "'" + email + "'," +
                    "'" + passwordHash + "'" +
                    ");";
                System.Diagnostics.Debug.WriteLine(query);
                MySqlConnection Connection = Database.Connect();
                MySqlCommand cmd = new MySqlCommand(query, Connection);

                cmd.ExecuteNonQuery();
                HttpContext.Current.Response.Redirect("~/UserLoginForm");
            }
            catch
            {
                System.Diagnostics.Debug.WriteLine("Something went wrong while trying to add a user.");
            }
        }
        public static Dictionary<string, object> AutomaticLoginUserLogic(string _type = "", bool redirect = false, bool returnReader = false)
        {
            if (Cookie.CookieExist("user", "email") && Cookie.CookieExist("user", "password"))
            {
                try
                {
                    MySqlDataReader reader = LoginLogic(Cookie.GetFromCookie("user", "username"), Cookie.GetFromCookie("user", "password"));

                    if (reader == null) return null;

                    string type = reader.GetString(reader.GetOrdinal("is_admin"));
                    if (type == "") return null;

                    if (_type != "" && type != _type)
                    {
                        throw new InvalidOperationException();
                    }


                    if (returnReader)
                    {
                        Dictionary<string, object> dict = new Dictionary<string, object>();
                        for (int lp = 0; lp < reader.FieldCount; lp++)
                        {
                            dict.Add(reader.GetName(lp), reader.GetValue(lp));
                        }

                        return dict;
                    }

                    if (redirect)
                    {
                        if (type == "1") HttpContext.Current.Response.Redirect("~/AdminDashboard");
                        else HttpContext.Current.Response.Redirect("~/UserDashboard");
                    }
                }
                catch (InvalidOperationException)
                {
                    if (redirect) LogoutLogic(false);
                    return null;
                }
            }
            return null;
        }
    }
}