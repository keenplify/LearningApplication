using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace LearningApplication
{
    public partial class SiteMaster : MasterPage
    {
        protected string homeHREF = "/";
        public Dictionary<string, object> user = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Helpers.Cookie.CookieExist("user", "username") && Helpers.Cookie.CookieExist("user", "password"))
            {
                try
                {
                    MySqlDataReader reader = Helpers.User.LoginLogic(Helpers.Cookie.GetFromCookie("user", "username"), Helpers.Cookie.GetFromCookie("user", "password"));

                    if (reader == null) return;
                    user = new Dictionary<string, object>();
                    for (int lp = 0; lp < reader.FieldCount; lp++)
                    {
                        user.Add(reader.GetName(lp), reader.GetValue(lp));
                    }

                    if (user == null) return;
                    UserFullName.Text = user["full_name"].ToString();
                }
                catch (Exception err)
                {
                    System.Diagnostics.Debug.WriteLine(err);
                }
            }
        }

        protected void Logout(object sender, EventArgs e)
        {
            Helpers.User.LogoutLogic();
            Response.Redirect("/");
        }
    }
}