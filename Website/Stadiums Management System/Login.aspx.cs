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

namespace Stadiums_Management_System
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {


            if (isLogedin())
            {
                // User has a session, display their user id
                if (Session["expiryDate"] != null && (DateTime)Session["expiryDate"] < DateTime.Now)
                {
                    //redirect based on Session["role"]
                    Server.Transfer("Register.aspx");
                    Response.Write("Welcome, user with id: " + Session["UserId"]);
                }
                else genrateCookie();

            }
            else
            {

                genrateCookie();

                Response.Write("Welcome, new user with id: " + Session["UserId"]);
            }


        }

        private void genrateCookie()
        {
            Guid userId = Guid.NewGuid();
            HttpCookie cookie = new HttpCookie("UserId", userId.ToString());
            cookie.Expires = DateTime.Now.AddMinutes(15);
            Session["expiryDate"] = DateTime.Now.AddMinutes(15);
            Session["UserId"] = userId.ToString();
            Session["role"] = null;
            cookie.Secure = true;
            Response.Cookies.Add(cookie);

        }


        private bool isLogedin()
        {

            return Session["UserId"] != null && Request.Cookies["UserId"] != null
                && Request.Cookies["UserId"].Equals(Session["UserId"]);

        }

        protected void MyButtonClickHandler(object sender, EventArgs e)
        {
            String name = Username.Value;
            String pass = Password.Value;
            string connetionString;
            connetionString = WebConfigurationManager.ConnectionStrings["SMS"].ToString();
            bool logedin = Login_check(connetionString, name, pass);
            if (logedin)
            {
                HttpSessionState session = HttpContext.Current.Session;
                string sessionID = session.SessionID;
                Response.Write(session.SessionID + "<br/>");


                Server.Transfer("Register.aspx");


                //HttpCookie sessionIdCookie = Request.Cookies["ASP.NET_SessionId"];
                //string csessionId = sessionIdCookie.Value;
                //Response.Write(csessionId);
                //if (csessionId != sessionID) { 
                //}



            }

        }



        private bool isValid(String x)
        {

            if (x == null || x.Length == 0 || x[0] == '\'' || x.Contains("--") || x.Contains("/*") || x.Contains("*/")) return false;
            return true;
        }
        private bool Login_check(string connetionString, string username, string password)
        {
            //defensive programming 
            if (!(isValid(username) && isValid(password)))
            {
                status.Text = "Invalid username or password";
                return false;

            }
            SqlConnection cnn = null;
            SqlDataReader reader = null;
            try
            {


                cnn = new SqlConnection(connetionString);
                cnn.Open();

                String command =
                "select * from systemUser  where username = '" + username + "' and password = '" + password + "'";
                SqlCommand sCommand = new SqlCommand(command, cnn);
                reader = sCommand.ExecuteReader();
                if (reader.HasRows && reader.Read() && reader.GetValue(1).ToString().Equals(username)
                    && reader.GetValue(2).ToString().Equals(password))
                {
                    //                    print("" + VerifyMd5Hash(password, reader.GetValue(2).ToString()));
                    //      status.Text = "Good";
                    reader.Close();
                    cnn.Close();
                    return true;
                }
                else
                {
                    status.Text = "Username or Password are incorrect";
                    reader.Close();
                    cnn.Close();
                    return false;


                }



            }
            catch (Exception ex)
            {
                status.Text = "Error Happened ! Please try again ";
                //  Response.Write("select * from systemUser  where username = '" + username + "' and pASsword = '" + password + "'");
                //Response.Write("<br>"+ex.Message);
                Console.WriteLine(ex.Message);
                if (cnn != null)
                    cnn.Close();
                if (reader != null) reader.Close();
                return false;
            }

        }
        private void print(String x)
        {

            Response.Write("<br>");
            Response.Write(x);
            Response.Write("<br>");


        }









    }


}

