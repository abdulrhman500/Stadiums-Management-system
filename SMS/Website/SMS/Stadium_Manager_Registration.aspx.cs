using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMS
{
    public partial class Stadium_Manager_Registration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }


        protected void Register_Click(object sender, EventArgs e)
        {



            String name = Name_Text.Text;
            String username = Username_text.Text;

            String password = Password_text.Text;
            String st = stadium_text.Text;

            bool error = false;
            if (!isValid(name) || !isname(name))
            { name_status.Text = "* Name should  contain only letters and no more than 20 letter "; error = true; }
            else { name_status.Text = ""; }
            if (!isValid(username) || !isUsername(username))
            {

                Username_status.Text = "* Username should only contain letters , @ , numbers and no more than 20 letter "; error = true;
            }
            else
            {
                Username_status.Text = "";
            }
            if (!isValid(password))
            { pass_status.Text = "* Password is not valid or it contains more than 20 letter"; error = true; }
            else
            {
                pass_status.Text = "";
            }
            if (!isValid(st))
            { stadium_status.Text = "* Stadium name is not valid or it contains more than 20 letter"; error = true; }
            else
            {
                stadium_status.Text = "";
            }

            if (!error)
            {



                String cmd = "addStadiumManager";
                SqlCommand sqlcmd = new SqlCommand(cmd, null);

                sqlcmd.CommandType = CommandType.StoredProcedure;

                sqlcmd.Parameters.AddWithValue("@name", name);
                sqlcmd.Parameters.AddWithValue("@username", username);
                sqlcmd.Parameters.AddWithValue("@pASsword", password);
                sqlcmd.Parameters.AddWithValue("@stadium_name", st);

                String feedback = (SMS.Login.SqlInsert(Login.connetionString, sqlcmd));
                //Response.Write(feedback);
                if (feedback.Split(' ')[0] == "Error")
                {
                    status.Text = "Already exits or internal error happened ";
                }
                else
                {
                    Session.Abandon();
                    Response.Redirect("Login.aspx");
                }



            }


            return;






        }

        private bool isUsername(string username)
        {
            for (int i = 0; i < username.Length; i++)
            {
                char curr = username[i];
                if (curr == '@') continue;


                if (!char.IsDigit(curr) && !char.IsLetter(curr)) return false;

            }

            return true;
        }
        private bool isname(string name)
        {

            for (int i = 0; i < name.Length; i++)
            {
                if (name[i] == ' ') continue;
                if (!char.IsLetter(name[i])) return false;
            }
            return true;

        }
        private bool isNum(string id)
        {

            for (int i = 0; i < id.Length; i++)

                if (!char.IsDigit(id[i])) return false;

            return true;
        }

        private bool isValid(String x)
        {


            if (x == null || x.Length == 0 || x[0] == '\'' || x.Contains("--") || x.Contains("/*") || x.Contains("*/") || x.Length > 20) return false;
            return true;
        }


    }
}