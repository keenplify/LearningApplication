using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace LearningApplication
{
    public partial class AccountSettings : Page
    {
        Dictionary<string, object> user;
        protected void Page_Load(object sender, EventArgs e)
        {
            user = Helpers.User.AutomaticLoginUserLogic(false, true);

            if (!IsPostBack)
            {
                fullName.Text = user["full_name"].ToString();
                email.Text = user["email"].ToString();
                username.Text = user["username"].ToString();
            }
        }

        protected void btnEditUser_Click(object sender, EventArgs e)
        {
            var connection = Helpers.Database.Connect();

            string query = $"UPDATE users_tbl SET " +
                $"full_name='{fullName.Text}', " +
                $"email='{email.Text}' " +
                $"WHERE user_uuid='{user["user_uuid"]}'";

            MySqlCommand cmd = new MySqlCommand(query, connection);
            cmd.ExecuteNonQuery();

            Response.Redirect("/AccountSettings", true);
        }

        protected void btnEditUsername_Click(object sender, EventArgs e)
        {
            try
            {
                MySqlConnection connection = Helpers.Database.Connect();

                string query = $"UPDATE users_tbl SET " +
                    $"username='{username.Text}' " +
                    $"WHERE user_uuid='{user["user_uuid"]}'";
                System.Diagnostics.Debug.WriteLine(query);
                MySqlCommand cmd = new MySqlCommand(query, connection);
                cmd.ExecuteNonQuery();

                Helpers.User.LogoutLogic();
                Response.Redirect("~/Login");
            }
            catch (Exception)
            {
                lblUsernameError.Text = "Unable to change username.";
                return;
            }
        }

        protected void btnEditPassword_Click(object sender, EventArgs e)
        {
            if (newPassword.Text != newPasswordRetype.Text)
            {
                lblPasswordError.Text = "Your password retype is not the same with your new password. Please try again.";
                return;
            }

            try
            {
                var connection = Helpers.Database.Connect();

                var hash = BCrypt.Net.BCrypt.HashPassword(newPassword.Text, 10);

                string query = $"UPDATE users_tbl SET " +
                    $"PASSWORD='{hash}' " +
                    $"WHERE user_uuid='{user["user_uuid"]}'";

                MySqlCommand cmd = new MySqlCommand(query, connection);
                cmd.ExecuteNonQuery();

                Helpers.User.LogoutLogic();
                Response.Redirect("~/Login");
            }
            catch (Exception ex)
            {
                lblPasswordError.Text = ex.Message;
            }
        }
    }
}