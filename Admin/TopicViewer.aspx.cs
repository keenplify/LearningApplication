using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;
using System.IO;

namespace LearningApplication.Admin
{
    public partial class TopicViewer : System.Web.UI.Page
    {
        protected string topic_uuid;
        protected Dictionary<string, object> topic;
        protected List<Dictionary<string, object>> quizzes = new List<Dictionary<string, object>>();

        protected void Page_Load(object sender, EventArgs e)
        {
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

            string quizzesQuery = $"SELECT * FROM quizzes_tbl WHERE topic_uuid='{topic_uuid}'";
            var quizzesConnection = Helpers.Database.Connect();
            var quizzesCmd = new MySqlCommand(quizzesQuery, quizzesConnection);
            var quizzesReader = quizzesCmd.ExecuteReader();
            if (quizzesReader.HasRows != true) return;
            while (quizzesReader.Read())
            {
                var quiz = new Dictionary<string, object>();
                for (int lp = 0; lp < quizzesReader.FieldCount; lp++)
                {
                    quiz.Add(quizzesReader.GetName(lp), quizzesReader.GetValue(lp));
                }
                quizzes.Add(quiz);
            }

            if (!IsPostBack)
            {
                title.Text = topic["title"].ToString();
                TopicDescription.Text = topic["description"].ToString();
            }
        }

        protected void EditTopicBtn_Click(object sender, EventArgs e)
        {
            string query = $"UPDATE topics_tbl SET title = '{title.Text}', description = '{MySqlHelper.EscapeString(TopicDescription.Text)}' WHERE topic_uuid='{topic_uuid}' ";
            var connection = Helpers.Database.Connect();
            var cmd = new MySqlCommand(query, connection);
            cmd.ExecuteNonQuery();

            Response.Redirect(Request.Url.PathAndQuery, true);
        }

        protected void ChangeImageBtn_Click(object sender, EventArgs e)
        {
            string absoluteFolder = Server.MapPath("~/Uploads/");
            string fileName = "topic-" + new Random().Next(0, 100000) + '-' + Path.GetFileName(image.PostedFile.FileName);

            if (image.HasFile)
            {
                image.PostedFile.SaveAs(absoluteFolder + fileName);

                MySqlConnection connection = Helpers.Database.Connect();
                string query = "UPDATE topic_tbl SET logo_src='\\Uploads" + fileName.Replace(@"\", @"\\") + "' WHERE subject_uuid='" + topic_uuid + "'";
                MySqlCommand cmd = new MySqlCommand(query, connection);
                cmd.ExecuteNonQuery();
                Response.Redirect(Request.Url.PathAndQuery, true);
            }
        }

        protected void AddQuizBtn_Click(object sender, EventArgs e)
        {
            MySqlConnection connection = Helpers.Database.Connect();
            string query = $"INSERT INTO quizzes_tbl (" +
                $"title, " +
                $"topic_uuid" +
                $") VALUES (" +
                $"'{TopicTitleTbx.Text}'," +
                $"'{topic_uuid}'" +
                $")";
            MySqlCommand cmd = new MySqlCommand(query, connection);
            cmd.ExecuteNonQuery();
            Response.Redirect(Request.Url.PathAndQuery, true);
        }
    }
}