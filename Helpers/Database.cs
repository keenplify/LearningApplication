using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.Data.Sql;
using Microsoft.Data.SqlClient;

namespace LearningApplication.Helpers
{
    public class Database
    {
        public static SqlConnection Connect()
        {
            try
            {
                SqlConnection Connection = new SqlConnection
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
            catch (SqlException ex)
            {
                throw ex;
            }
        }
    }
}