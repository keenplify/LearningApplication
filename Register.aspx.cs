using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LearningApplication
{
    public partial class Register : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void RegisterSubmitBtn_Click(object sender, EventArgs e)
        {
            try
            {
                Helpers.User.Register(
                    fullname.Text, 
                    username.Text, 
                    email.Text, 
                    password.Text);
            }
            catch (Exception err)
            {
                ErrorLbl.Text = err.Message;
            }
        }
    }
}