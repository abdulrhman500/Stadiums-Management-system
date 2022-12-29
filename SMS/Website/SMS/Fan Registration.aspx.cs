using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMS
{
    public partial class Fan_Registration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
         
        }


        
        protected void Register_Click(object sender, EventArgs e)
        {



            String name = Name_Text.Text;
            String username = Username_text.Text;
            //Response.Write("vlgl,blglb,      glmbl,       " + username);
            String password = Password_text.Text;
            String id = National_ID_text.Text;
            String phone = Phone_text.Text;
            String address = Address_text.Text;
            String date = BirthDate.Text;


            bool error=false;
            if (!isValid(name) ||  !isname(name))
            { name_status.Text= "* Name should  contain only letters and no more than 20 letter "; error = true; }
            if (!isValid(username) || !isUsername(username) ) 
            {
                
                Username_status.Text = "* Username should only contain letters , @ , numbers and no more than 20 letter "  ; error = true; }
            if (!isValid(password)) 
            { pass_status.Text = "* Password is not valid or it contains more than 20 letter"; error = true; }
            if (!isValid(id) || !isNum(id)) 
            { id_status.Text = "* National Id should only contain numbers and  no more than 20 letter" ; error = true; }
            if (!isValid(phone) ||  !isNum(phone)) 
            { phone_status.Text = "* Phone  should  only contain numbers and no more than 20 letter" ; error = true; }
            if (!isValid(address)) 
            { address_status.Text= "* Address is not valid or it contains more than 20 letter" ; error = true; }
            if (date == "" || DateTime.Parse(date) >= DateTime.Now)
            {
                bith_status.Text = "* Bith date is not valid";
                error = true;
            }
            if (!error)
            {
                


                String cmd = "addFan";
                SqlCommand sqlcmd = new SqlCommand(cmd, null);

                sqlcmd.CommandType = CommandType.StoredProcedure;

                sqlcmd.Parameters.AddWithValue("@name", name);
                sqlcmd.Parameters.AddWithValue("@username", username);
                sqlcmd.Parameters.AddWithValue("@pASsword", password);
                sqlcmd.Parameters.AddWithValue("@national_id", id);
                sqlcmd.Parameters.Add("@birth_dath", SqlDbType.DateTime).Value = DateTime.Parse(date);
                sqlcmd.Parameters.AddWithValue("@address", address);
                sqlcmd.Parameters.Add("@phone", SqlDbType.Int).Value = int.Parse(phone);
                SMS.Login.SqlInsert(Login.connetionString, sqlcmd);
           
            
            
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
        private bool isname(string username)
        {

            for (int i = 0; i < username.Length; i++)
                if (!char.IsLetter(username[i])) return false;
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
           

            if (x == null || x.Length == 0 || x[0] == '\'' || x.Contains("--") || x.Contains("/*") || x.Contains("*/")) return false;
            return true;
        }
    }
}