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
	public partial class Sysadmin : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
            if (!isLogedin())
                Response.Redirect("Login.aspx");

        }

        private bool isLogedin()
        {


            return Session.SessionID != null && Request.Cookies["userid"] != null && Session["role"] != null
                && Request.Cookies["userid"].Value.ToString().Equals(Session.SessionID.ToString());

        }
        protected void btn_club_Click(object sender, EventArgs e)
        {
            String name = clubn.Text;
            String location1 = location.Text;

       


        String cmd = "addClub";
            SqlCommand scmd = new SqlCommand(cmd, null);
            scmd.CommandType = CommandType.StoredProcedure;


            scmd.Parameters.AddWithValue("@cname", name);
            scmd.Parameters.AddWithValue("@clocation", location1);


            String feedback = Login.SqlInsert(Login.connetionString, scmd);
            if (feedback.Contains("-1"))
                Response.Write(feedback);
            Response.Write(feedback);
        }

        protected void btn_deleteclub_Click(object sender, EventArgs e)
        {
            String name = sname.Text;
           

            String cmd = "deleteClub";
            SqlCommand scmd = new SqlCommand(cmd, null);
            scmd.CommandType = CommandType.StoredProcedure;

          
            scmd.Parameters.AddWithValue("@cname", name);
     


            String feedback = Login.SqlInsert(Login.connetionString, scmd);
            if (feedback.Contains("-1"))
                Response.Write(feedback);

          
        }

        protected void add_std_Click(object sender, EventArgs e)
        {
            //@sname VARCHAR(20), @slocation VARCHAR(20), @capacity INT AS

            String name = sname.Text;
            String location= slocation.Text;
            String capp = cap.Text;

            String cmd = "deleteStadium";
            SqlCommand scmd = new SqlCommand(cmd, null);
            scmd.CommandType = CommandType.StoredProcedure;

            if (!isNum(capp)) {
                Response.Write("capacity should be a number ");
                return;
            }
         
            scmd.Parameters.AddWithValue("@sname",name);
            scmd.Parameters.AddWithValue("@slocation", location);
            scmd.Parameters.AddWithValue("@capacity", int.Parse(capp));




            String feedback = Login.SqlInsert(Login.connetionString, scmd);
            if (feedback.Contains("-1"))
                Response.Write(feedback);

        }

        protected void btn_delete_std_Click(object sender, EventArgs e)
        {
            String id = std_name.Text;
            if (!isNum(id))
            {
                Response.Write("id must be numbers ");
            }
            String cmd = "deleteStadium";

            SqlCommand scmd = new SqlCommand(cmd, null);
            scmd.CommandType = CommandType.StoredProcedure;


            scmd.Parameters.Add("@sname", SqlDbType.VarChar).Value = id;



            String feedback = Login.SqlInsert(Login.connetionString, scmd);
            if (feedback.Contains("-1"))
                Response.Write("unsuccssfull");


        }


        protected void btn_block_Click(object sender, EventArgs e)
        {


            String id = TextBox1.Text;
            if (!isNum(id)) {
                Response.Write("id must be numbers ");
            }
            String cmd = "blockFan";
          
            SqlCommand scmd = new SqlCommand(cmd, null);
            scmd.CommandType = CommandType.StoredProcedure;


            scmd.Parameters.Add("@id", SqlDbType.VarChar).Value = id;



            String feedback = Login.SqlInsert(Login.connetionString, scmd);
            if (feedback.Contains("-1"))
                Response.Write("unsuccssfull");
           
            
        }

        private bool isNum(string id)
        {
            for (int i = 0; i < id.Length; i++) { 
            if(!char.IsDigit(id[i]))return false;
            }
            return true;

        }
    }
}