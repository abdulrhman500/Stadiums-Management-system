using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplication1
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }
        protected void btn1_click(object sender, EventArgs e) {

            String name = username.Value;
            String pass = password.Value;

            String ConnectionString= WebConfigurationManager.ConnectionStrings["SMS"].ToString();
            SqlConnection cnn = new SqlConnection(ConnectionString);
            cnn.Open();

            String command =
 "select * from systemUser  where username = '" + name + "' and password = '" + pass + "'  ";
            SqlCommand sCommand = new SqlCommand(command, cnn);
            SqlDataReader rdr = sCommand.ExecuteReader();
            if (rdr.HasRows) { 
            
            }




            cnn.Close();

        }
       

    }
}