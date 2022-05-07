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
    public partial class AddQuizQuestion : System.Web.UI.Page
    {
        protected string quiz_uuid;
        protected Dictionary<string, object> quiz;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            quiz_uuid = Request.QueryString["quiz_uuid"];
            // Query quiz data
            string query = $"SELECT * FROM quizzes_tbl " +
                $"LEFT JOIN (" +
                $"SELECT topics_tbl.topic_uuid, topics_tbl.title AS t_title, subjects_tbl.subject_uuid, s_title " +
                $"FROM topics_tbl " +
                $"LEFT JOIN (" +
                $"SELECT subjects_tbl.subject_uuid, subjects_tbl.title AS s_title " +
                $" FROM subjects_tbl" +
                $") subjects_tbl " +
                $"ON subjects_tbl.subject_uuid=topics_tbl.subject_uuid " +
                $") topics_tbl " +
                $"ON topics_tbl.topic_uuid=quizzes_tbl.topic_uuid " +
                $"WHERE quizzes_tbl.quiz_uuid='{quiz_uuid}'";
            var connection = Helpers.Database.Connect();
            var cmd = new MySqlCommand(query, connection);
            var reader = cmd.ExecuteReader();
            if (reader.HasRows != true) return;
            while (reader.Read())
            {
                quiz = new Dictionary<string, object>();
                for (int lp = 0; lp < reader.FieldCount; lp++)
                {
                    if (quiz.ContainsKey(reader.GetName(lp)) == false)
                    {
                        quiz.Add(reader.GetName(lp), reader.GetValue(lp));
                    }
                }
            }
            connection.Close();

        }

        protected void AddChoiceBtn_Click(object sender, EventArgs e)
        {
            ChoicesRadios.Items.Add(new ListItem() {
                Text = AddChoiceTbx.Text,
                Value = AddChoiceTbx.Text,
                Selected = (ChoicesRadios.Items.Count == 0)
            });
        }

        protected void ResetChoicesBtn_Click(object sender, EventArgs e)
        {
            ChoicesRadios.Items.Clear();
        }

        protected void SubmitBtn_Click(object sender, EventArgs e)
        {
            var question_uuid = Guid.NewGuid();
            string query = $"INSERT INTO quiz_questions_tbl (" +
                $"quiz_question_uuid, " +
                $"text, " +
                $"quiz_uuid" +
                $") VALUES (" +
                $"'{question_uuid}'," +
                $"'{MySqlHelper.EscapeString(QuestionTextTbx.Text)}', " +
                $"'{quiz_uuid}'" +
                $") ";
            var connection = Helpers.Database.Connect();
            var cmd = new MySqlCommand(query, connection);
            cmd.ExecuteNonQuery();
            connection.Close();

            foreach (ListItem choice in ChoicesRadios.Items)
            {
                string choiceQuery = $"INSERT INTO quiz_choices_tbl (" +
                $"text, " +
                $"quiz_question_uuid, " +
                $"is_right" +
                $") VALUES (" +
                $"'{choice.Value}', " +
                $"'{question_uuid}', " +
                $"'{(choice.Selected ? '1' : '0')}'" +
                $") ";
                var choiceConnection = Helpers.Database.Connect();
                var choiceCmd = new MySqlCommand(choiceQuery, choiceConnection);
                choiceCmd.ExecuteNonQuery();
                choiceConnection.Close();
            }

            Response.Redirect("/Admin/QuizViewer?quiz_uuid=" + quiz_uuid, true);
        }
    }
}