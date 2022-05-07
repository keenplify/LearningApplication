using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace LearningApplication.Admin
{
    public partial class DeleteQuestion : System.Web.UI.Page
    {
        protected string quiz_uuid;
        protected string quiz_question_uuid;

        protected void Page_Load(object sender, EventArgs e)
        {
            quiz_uuid = Request.QueryString["quiz_uuid"];
            quiz_question_uuid = Request.QueryString["quiz_question_uuid"];

            if (quiz_question_uuid == null || quiz_uuid == null)
            {
                Response.Redirect("/");
            }

            // Delete quiz question
            string query = $"DELETE FROM quiz_questions_tbl WHERE quiz_question_uuid='{quiz_question_uuid}'";
            var connection = Helpers.Database.Connect();
            var cmd = new MySqlCommand(query, connection);
            cmd.ExecuteNonQuery();
            connection.Close();

            Response.Redirect("QuizViewer?quiz_uuid=" + quiz_uuid, true);
        }
    }
}