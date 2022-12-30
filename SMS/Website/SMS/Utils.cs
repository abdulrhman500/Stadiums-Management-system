using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.SessionState;
using static System.Collections.Specialized.BitVector32;
using System.Web.UI.WebControls;
using System.Data.SqlTypes;
using System.IO;
using System.Text;
using System.Web.UI;

namespace SMS
{
    public class Utils
    {
        public static bool isLogged(HttpRequest Request, HttpSessionState Session)
        {

            return Session.SessionID != null && Request.Cookies["userid"] != null && Session["role"] != null
                && Request.Cookies["userid"].Value.ToString().Equals(Session.SessionID.ToString());

        }

        public static DataTable SqlTable(String connetionString, SqlCommand sqlCmd)
        {

            DataTable table = null;
            SqlConnection cnn = null;
            try
            {
                cnn = new SqlConnection(connetionString);
                sqlCmd.Connection = cnn;
                cnn.Open();
                SqlDataAdapter adapter = new SqlDataAdapter(sqlCmd);
                table = new DataTable();
                adapter.Fill(table);
            }

            catch (Exception e)
            {
                sqlCmd.Connection = null;
            }
            finally
            {
                if (cnn != null)
                    cnn.Close();
            }

            return table;

        }
    }
}