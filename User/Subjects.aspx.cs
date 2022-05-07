using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MySql.Data.MySqlClient;

namespace LearningApplication.User
{
    public partial class Subjects : System.Web.UI.Page
    {
        protected List<Dictionary<string, object>> subjects = new List<Dictionary<string, object>>();

        protected void Page_Load(object sender, EventArgs e)
        {
            string query = "SELECT * FROM subjects_tbl";
            var connection = Helpers.Database.Connect();
            var cmd = new MySqlCommand(query, connection);
            var reader = cmd.ExecuteReader();

            while(reader.Read())
            {
                var dict = new Dictionary<string, object>();
                for (int lp = 0; lp < reader.FieldCount; lp++)
                {
                    dict.Add(reader.GetName(lp), reader.GetValue(lp));
                }
                subjects.Add(dict);
            }
        }
    }
}