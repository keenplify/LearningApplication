using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using MySql.Data.MySqlClient;

namespace LearningApplication.Helpers
{
    public class Database
    {
        public static MySqlConnection Connect()
        {
            try
            {
                MySqlConnection Connection = new MySqlConnection
                {
                    ConnectionString =
                    "server=" + Helpers.Connection.HOSTNAME +
                    ";uid=" + Helpers.Connection.USERNAME +
                    ";pwd=" + Helpers.Connection.PASSWORD +
                    ";database=" + Helpers.Connection.DATABASE
                };
                Connection.Open();

                return Connection;
            }
            catch (MySqlException ex)
            {
                throw ex;
            }
        }
    }
}