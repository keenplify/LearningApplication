using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.IO;

namespace LearningApplication.User
{
    public partial class TopicViewer : System.Web.UI.Page
    {
        protected string topic_uuid;
        protected Dictionary<string, object> topic;
        protected List<Dictionary<string, object>> quizzes = new List<Dictionary<string, object>>();
        protected Dictionary<string, object> user;

        protected void Page_Load(object sender, EventArgs e)
        {
            user = Helpers.User.AutomaticLoginUserLogic(false, true);

            if (user == null)
            {
                Response.Redirect("~/");
            }

            topic_uuid = Request.QueryString["topic_uuid"];

            string query = $"SELECT * FROM topics_tbl " +
                $"LEFT JOIN (" +
                $"SELECT subjects_tbl.subject_uuid, subjects_tbl.title AS s_title FROM subjects_tbl" +
                $") subjects_tbl " +
                $"ON subjects_tbl.subject_uuid=topics_tbl.subject_uuid " +
                $"WHERE topic_uuid='{topic_uuid}'";
            var connection = Helpers.Database.Connect();
            var cmd = new MySqlCommand(query, connection);
            var reader = cmd.ExecuteReader();
            if (reader.HasRows != true) return;
            while (reader.Read())
            {
                topic = new Dictionary<string, object>();
                for (int lp = 0; lp < reader.FieldCount; lp++)
                {
                    if (topic.ContainsKey(reader.GetName(lp)) == false) {
                        topic.Add(reader.GetName(lp), reader.GetValue(lp));
                    }
                }
            }
            connection.Close();

            string quizzesQuery = $"SELECT * FROM quizzes_tbl " +
                $"LEFT JOIN quiz_results_tbl " +
                $"ON quizzes_tbl.quiz_uuid = quiz_results_tbl.quiz_uuid " +
                $"AND quiz_results_tbl.user_uuid = '{user["user_uuid"]}' " +
                $"WHERE topic_uuid='{topic_uuid}'";
            var quizzesConnection = Helpers.Database.Connect();
            var quizzesCmd = new MySqlCommand(quizzesQuery, quizzesConnection);
            var quizzesReader = quizzesCmd.ExecuteReader();
            if (quizzesReader.HasRows != true) return;
            while (quizzesReader.Read())
            {
                var quiz = new Dictionary<string, object>();
                for (int lp = 0; lp < quizzesReader.FieldCount; lp++)
                {
                    if (quiz.ContainsKey(quizzesReader.GetName(lp)) == false)
                    {
                        quiz.Add(quizzesReader.GetName(lp), quizzesReader.GetValue(lp));
                    }
                }
                quizzes.Add(quiz);
            }
        }
    }
}