using System;
using System.Data;
using System.Data.SqlClient;
using System.Runtime.CompilerServices;
using System.Web;
using System.Web.Configuration;
using System.Web.SessionState;

namespace Sports_League_Managament_System
{
    public static class Utils
    {
        public static readonly string connectionString = WebConfigurationManager.ConnectionStrings["CS"].ToString();
        public static String requestMessage { get; set; }

        public static bool isLogged(HttpRequest Request, HttpSessionState Session, String role)
        {
            return Session.SessionID != null && Request.Cookies["userid"] != null && Session["role"] != null
                   && Request.Cookies["userid"].Value.ToString().Equals(Session.SessionID.ToString())
                   && (string) Session["role"] == role;
        }

        public static DataTable SqlTable(string sql, string[] parameters, Object[] values)
        {
            DataTable dataTable = new DataTable();
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                using (SqlCommand sqlCommand = new SqlCommand(sql, connection))
                {
                    for (int i = 0; i < parameters.Length; i++)
                        sqlCommand.Parameters.AddWithValue(parameters[i], values[i]);

                    using (SqlDataReader reader = sqlCommand.ExecuteReader())
                        dataTable.Load(reader);
                }
            }

            return dataTable;
        }

        public static bool execProcedure(string procedureName, string[] parameters, Object[] values)
        {
            int numOfRowsAffected;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                SqlCommand sqlCommand = new SqlCommand();
                sqlCommand.CommandType = CommandType.StoredProcedure;
                sqlCommand.CommandText = procedureName;
                sqlCommand.Connection = connection;

                for (int i = 0; i < parameters.Length; i++)
                    sqlCommand.Parameters.AddWithValue(parameters[i], values[i]);

                numOfRowsAffected = sqlCommand.ExecuteNonQuery();
            }

            return numOfRowsAffected > 0;
        }

        public static void Redirect(HttpResponse Response, string role)
        {
            String page = WebConfigurationManager.AppSettings[role];
            Response.Redirect(page);
        }

    }

}