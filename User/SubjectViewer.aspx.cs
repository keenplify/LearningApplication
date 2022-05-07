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
    }
}