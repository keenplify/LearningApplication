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

            if (!IsPostBack)
            {
                title.Text = subject["title"].ToString();
                SubjectDescription.Text = subject["description"].ToString();
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
            string folder = Server.MapPath("Uploads/");
        }
    }
}