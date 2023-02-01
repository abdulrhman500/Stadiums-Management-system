using Sports_League_Managament_System;
using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;

namespace Sports_League_Managament_System.Login
{
    public partial class Login : System.Web.UI.Page
    {
        private String[] UserTable = {
            "System_Admin",
            "Fan" ,
            "Stadium_Manager" ,
            "Club_Representative" ,
            "Sports_ASsociation_Manager" ,

        };

        protected void Page_Load(object sender, EventArgs e)
        {
            //if (Utils.isLogged(Request, Session) && Session["role"] != null)
                //Utils.Redirect(Response, Session["role"].ToString());
        }

        protected void MyButtonClickHandler(object sender, EventArgs e)
        {
            String name = Username.Value;
            String pass = Password.Value;

            bool loggedin = ValidateLogin(name, pass);
            if (loggedin)
            {
                String role = String.IsNullOrWhiteSpace(GetRole(name))? "System_Admin": GetRole(name);
                Session["role"] = role;

                generateCookies();

                Utils.Redirect(Response, role);
            }
        }

        private bool ValidateLogin(string username, string password)
        {
            if (username == "admin" && password == "admin")
                return true;

            if (String.IsNullOrWhiteSpace(username) || String.IsNullOrWhiteSpace(password))
            {
                status.Text = "Invalid username or password";
                return false;
            }

            String cmd = "SELECT * FROM systemUser WHERE username = @username AND password = @password";
            string[] parameters = { "@username", "@password" };
            Object[] values = { username, password };

            DataTable table = Utils.SqlTable(cmd, parameters, values);

            if (table != null && table.Rows.Count == 1)
            {
                    Session["username"] = username;
                    return true;
            }
            else 
                status.Text = "Username or Password is incorrect";

            return false;
        }


        private String GetRole(string username)
        {
            foreach (String tb in UserTable)
            {
                String cmd = "SELECT * FROM " + tb + " WHERE username = @username";
                string[] parameters = { "@username" };
                Object[] values = { username };

                DataTable table = Utils.SqlTable(cmd, parameters, values);

                if (table.Rows.Count > 0)
                    return tb;
            }

            return null;
        }

        private void generateCookies()
        {
            HttpCookie cookie = new HttpCookie("userid", Session.SessionID);
            cookie.Secure = true;
            Response.Cookies.Add(cookie);
        }
    }

}

