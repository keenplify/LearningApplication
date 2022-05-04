using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearningApplication
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void LoginSubmitBtn_Click(object sender, EventArgs e)
        {
            try
            {
                var reader = Helpers.User.LoginLogic(username.Text, password.Text, true);

            }
            catch (Exception err)
            {
                ErrorLbl.Text = err.Message;
            }
        }
    }
}