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
    public partial class SubjectViewer : System.Web.UI.Page
    {
        protected string subject_uuid;
        protected Dictionary<string, object> subject;
        protected List<Dictionary<string, object>> topics = new List<Dictionary<string, object>>();

        protected void Page_Load(object sender, EventArgs e)
        {
            subject_uuid = Request.QueryString["subject_uuid"];

            string query = $"SELECT * FROM subjects_tbl WHERE subject_uuid='{subject_uuid}'";
            var connection = Helpers.Database.Connect();
            var cmd = new MySqlCommand(query, connection);
            var reader = cmd.ExecuteReader();
            if (reader.HasRows != true) return;
            while (reader.Read())
            {
                subject = new Dictionary<string, object>();
                for (int lp = 0; lp < reader.FieldCount; lp++)
                {
                    subject.Add(reader.GetName(lp), reader.GetValue(lp));
                }
            }
            connection.Close();

            if (!IsPostBack)
            {
                title.Text = subject["title"].ToString();
                SubjectDescription.Text = subject["description"].ToString();
            }

            string topicsQuery = $"SELECT * FROM topics_tbl WHERE subject_uuid='{subject_uuid}'";
            var topicsConnection = Helpers.Database.Connect();
            var topicsCmd = new MySqlCommand(topicsQuery, topicsConnection);
            var topicsReader = topicsCmd.ExecuteReader();
            if (topicsReader.HasRows != true) return;
            while (topicsReader.Read())
            {
                var topic = new Dictionary<string, object>();
                for (int lp = 0; lp < topicsReader.FieldCount; lp++)
                {
                    topic.Add(topicsReader.GetName(lp), topicsReader.GetValue(lp));
                }
                topics.Add(topic);
            }

            
        }

        protected void EditSubjectBtn_Click(object sender, EventArgs e)
        {
            string query = $"UPDATE subjects_tbl SET title = '{title.Text}', description = '{MySqlHelper.EscapeString(SubjectDescription.Text)}' WHERE subject_uuid='{subject_uuid}' ";
            var connection = Helpers.Database.Connect();
            var cmd = new MySqlCommand(query, connection);
            cmd.ExecuteNonQuery();

            Response.Redirect(Request.Url.PathAndQuery, true);
        }

        protected void ChangeImageBtn_Click(object sender, EventArgs e)
        {
            string absoluteFolder = Server.MapPath("~/Uploads/");
            string fileName = "subject-" + new Random().Next(0,100000) + '-' + Path.GetFileName(image.PostedFile.FileName);

            if (image.HasFile)
            {
                image.PostedFile.SaveAs(absoluteFolder + fileName);

                MySqlConnection connection = Helpers.Database.Connect();
                string query = "UPDATE subjects_tbl SET logo_src='/Uploads/" + fileName.Replace(@"\", @"\\") + "' WHERE subject_uuid='" + subject_uuid + "'";
                MySqlCommand cmd = new MySqlCommand(query, connection);
                cmd.ExecuteNonQuery();
                Response.Redirect(Request.Url.PathAndQuery, true);
            }
        }

        protected void AddTopicBtn_Click(object sender, EventArgs e)
        {
            string absoluteFolder = Server.MapPath("~/Uploads/");
            string fileName = "topic-" + new Random().Next(0, 100000) + '-' + Path.GetFileName(TopicImageUpl.PostedFile.FileName);

            if (TopicImageUpl.HasFile)
            {
                TopicImageUpl.PostedFile.SaveAs(absoluteFolder + fileName);
                var safeFileName = ("\\Uploads\\" + fileName).Replace(@"\", @"\\");

                MySqlConnection connection = Helpers.Database.Connect();
                string query = $"INSERT INTO topics_tbl (" +
                    $"title, " +
                    $"description, " +
                    $"logo_src, " +
                    $"subject_uuid" +
                    $") VALUES (" +
                    $"'{TopicTitleTbx.Text}'," +
                    $"'{MySqlHelper.EscapeString(TopicDescriptionTbx.Text)}'," +
                    $"'{safeFileName}'," +
                    $"'{subject_uuid}'" +
                    $")";
                MySqlCommand cmd = new MySqlCommand(query, connection);
                cmd.ExecuteNonQuery();
                Response.Redirect(Request.Url.PathAndQuery, true);
            }
        }

        protected void DeleteBtn_Click(object sender, EventArgs e)
        {
            MySqlConnection connection = Helpers.Database.Connect();
            string query = $"DELETE FROM subjects_tbl WHERE subject_uuid='{subject_uuid}'";
            MySqlCommand cmd = new MySqlCommand(query, connection);
            cmd.ExecuteNonQuery();
            Response.Redirect("/Admin/Subjects", true);
        }
    }
}