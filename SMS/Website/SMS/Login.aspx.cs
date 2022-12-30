using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Cryptography;
using System.Text;
using System.Data;

namespace SMS
{
    public partial class Login : System.Web.UI.Page
    {
        public static string connetionString = WebConfigurationManager.ConnectionStrings["CS_Abdo"].ToString();
        private String[] UserTable = { 
            "System_Admin",
            "Fan" ,
            "Stadium_Manager" , 
            "Club_Representative" ,
            "Sports_ASsociation_Manager" , 
            
        };




        protected void Page_Load(object sender, EventArgs e)
        {
            //Response.Redirect("Fan.aspx");
            if (isLogedin()) {
                if(Session["role"] !=null)
                   
                Redirect(Session["role"].ToString());
            
            
            }


    


        }

        private void genrateCookie()
        {
          
           
           
            HttpCookie cookie = new HttpCookie("userid", Session.SessionID);
            cookie.Secure = true;
            Response.Cookies.Add(cookie);


           
        }


        private  bool isLogedin()
        {

            return Session.SessionID != null && Request.Cookies["userid"] != null && Session["role"] != null
                && Request.Cookies["userid"].Value.ToString().Equals(Session.SessionID.ToString());

        }

        protected void MyButtonClickHandler(object sender, EventArgs e)
        {
            String name = Username.Value;
            String pass = Password.Value;
           
            bool logedin = Login_check(connetionString, name, pass);
            if (logedin)
            {

                String role = GetRole(name);
                if (role != null)
                {
                    genrateCookie();
                    Session["role"] = role;
                    
                    Redirect(role);
                    
                }
            }
            

        }



       

        private bool isValid(String x)
        {

            if (x == null || x.Length == 0 || x[0] == '\'' || x.Contains("--") || x.Contains("/*") || x.Contains("*/")) return false;
            return true;
        }
        private bool Login_check(string connetionString, string username, string password)
        {
            //defensive againist SQL injection 
            if (!(isValid(username) && isValid(password)))
            {
                status.Text = "Invalid username or password";
                return false;

            }
            String tb = "systemUser";
            String cmd
            = "select * from " + tb + " where username = @username  and password = @password";
            SqlCommand sqlCommand = new SqlCommand(cmd, null);
            sqlCommand.Parameters.Add("@username", SqlDbType.VarChar).Value = username;
            sqlCommand.Parameters.Add("@password", SqlDbType.VarChar).Value = password;


            DataTable table = SqlTable(connetionString, sqlCommand);
            if (table != null && table.Rows.Count == 1)
            {

                String Sname = table.Rows[0][1].ToString();
                String Spass = table.Rows[0][2].ToString();

                if (Sname.Equals(username) && Spass.Equals(password))
                {
                    Session["username"] = username;
                    return true;
                }
                status.Text = "Username or Password is incorrect";
               
            }
           else if (sqlCommand.Connection == null)      
                status.Text = "Unexepected error happened, Please try again! ";
            else status.Text = "Username or Password is incorrect";

            return false;
        }



        public static DataTable SqlTable(String connetionString , SqlCommand sqlCmd) {

            DataTable table = null;
            SqlConnection cnn = null;
            try {
                
                cnn = new SqlConnection(connetionString);
                sqlCmd.Connection = cnn;
                cnn.Open();
                SqlDataAdapter adapter = new SqlDataAdapter(sqlCmd);
                table= new DataTable();
                adapter.Fill(table);    
             
            }

            catch (Exception e){
//                Response.Write("<br>llll "+e.Message);
                sqlCmd.Connection = null;
            }
            finally {
                if (cnn != null)
                    cnn.Close();
              
                
            }

            return table;

    }



        public static String SqlInsert(String connetionString, SqlCommand sqlCmd)
        {
            String H = "Done successfully";
            
            int rowsAffected = -1;
            SqlConnection cnn = null;
            try
            {

                cnn = new SqlConnection(connetionString);
                sqlCmd.Connection = cnn;
                cnn.Open();

                
                rowsAffected = sqlCmd.ExecuteNonQuery();


            }

            catch (Exception e)
            {
            
                H=("Error : <br> " + e.Message);
                sqlCmd.Connection = null;
            }
            finally
            {
                if (cnn != null)
                    cnn.Close();


            }
            

            return H+" Nunber of rows affected :  "+rowsAffected+" ";

        }


        private String GetRole(string username)
        {


            foreach (String tb in UserTable)
            {

                String cmd = "select * from "+tb+" where username =@username";
                SqlCommand sqlcmd = new SqlCommand(cmd, null);
                sqlcmd.Parameters.Add("@username", SqlDbType.VarChar).Value = username;
                DataTable table = SqlTable(connetionString, sqlcmd);
                if (table.Rows.Count > 0)
                {
                    return
                         tb;
                    
                }

            }

            return null;


        }
        private void Redirect(String role) {
            String page = WebConfigurationManager.AppSettings[role];
           Response.Redirect(page);
           // Server.Transfer(page);
        }

        private void print(String x)
        {

            Response.Write("<br>");
            Response.Write(x);
            Response.Write("<br>");


        }



    }


}

