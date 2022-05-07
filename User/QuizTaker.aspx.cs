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
    public partial class QuizTaker : System.Web.UI.Page
    {
        protected string quiz_uuid;
        protected Dictionary<string, object> quiz;
        protected List<Dictionary<string, object>> questions = new List<Dictionary<string, object>>();
        protected Dictionary<string, object> user;
        protected void Page_Load(object sender, EventArgs e)
        {
            user = Helpers.User.AutomaticLoginUserLogic(false, true);

            if (user == null)
            {
                Response.Redirect("~/");
            }

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

            // Query quiz questions
            string questionsQuery = $"SELECT * FROM quiz_questions_tbl WHERE quiz_uuid='{quiz_uuid}'";
            var questionsConnection = Helpers.Database.Connect();
            var questionsCmd = new MySqlCommand(questionsQuery, questionsConnection);
            var questionsReader = questionsCmd.ExecuteReader();
            if (questionsReader.HasRows != true) return;
            while (questionsReader.Read())
            {
                var question = new Dictionary<string, object>();
                for (int lp = 0; lp < questionsReader.FieldCount; lp++)
                {
                    question.Add(questionsReader.GetName(lp), questionsReader.GetValue(lp));
                }

                questions.Add(question);
            }
            questionsConnection.Close();

            // Get choices for each quiz questions
            foreach (var item in questions.Select((value, i) => new { i, value }))
            {
                var question = item.value;
                var index = item.i;

                string choicesQuery = $"SELECT * FROM quiz_choices_tbl WHERE quiz_question_uuid='{question["quiz_question_uuid"]}'";
                var choicesConnection = Helpers.Database.Connect();
                var choicesCmd = new MySqlCommand(choicesQuery, choicesConnection);
                var choicesReader = choicesCmd.ExecuteReader();
                if (choicesReader.HasRows != true) return;
                var choices = new List<Dictionary<string, object>>();
                while (choicesReader.Read())
                {
                    var choice = new Dictionary<string, object>();
                    for (int lp = 0; lp < choicesReader.FieldCount; lp++)
                    {
                        choice.Add(choicesReader.GetName(lp), choicesReader.GetValue(lp));
                    }
                    choice["choiceLetter"] = Helpers.Strings.GetColumnName(choices.Count);
                    choices.Add(choice);
                }
                questions[index]["choices"] = choices;
                questionsConnection.Close();
            }

        }

        protected void SubmitBtn_Click(object sender, EventArgs e)
        {
            var totalScore = 0;

            foreach(var question in questions)
            {
                var choice_uuid = Request.Form[(string)question["quiz_question_uuid"]];
                if (question != null)
                {
                    var choices = (List<Dictionary<string, object>>)question["choices"];
                 
                    foreach (var choice in choices)
                    {
                        if ((string)choice["quiz_choices_uuid"] == choice_uuid)
                        {
                            if ((bool)choice["is_right"])
                            {
                                totalScore++;
                            }
                        }
                    }
                }
            }

            var query = "INSERT INTO quiz_results_tbl " +
                "(" +
                "total_score," +
                "max_score," +
                "user_uuid," +
                "quiz_uuid" +
                ") VALUES (" +
                $"'{totalScore}'," +
                $"'{questions.Count()}'," +
                $"'{user["user_uuid"]}'," +
                $"'{quiz_uuid}'" +
                ")";
            var connection = Helpers.Database.Connect();
            var cmd = new MySqlCommand(query, connection);
            cmd.ExecuteNonQuery();
            connection.Close();

            Response.Redirect("/User/TopicViewer?topic_id=" + quiz["topic_uuid"], true);
        }
    }
}