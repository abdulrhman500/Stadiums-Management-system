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
    public partial class sam : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!isLogedin())
                Response.Redirect("Login.aspx");



            status1.Text = "";
            status2.Text = "";
            status3.Text = "";
            status_3.Text = "";
            status_2.Text = "";

        }
        private bool isLogedin()
        {


            return Session.SessionID != null && Request.Cookies["userid"] != null && Session["role"] != null
                && Request.Cookies["userid"].Value.ToString().Equals(Session.SessionID.ToString());

        }

        protected void Addnewmatch_Click(object sender, EventArgs e)
        {


            string hc = new_match_hclub.Text;
            string gc = new_match_gclub.Text;

            String sdate = new_match_start.Text;
            String edate1 = edate.Text;
            String sho = shours.Text;
            String eho = ehours.Text;

            if (!ishourOk(sho) || !ishourOk(eho) || sdate == "" || edate1 =="")
            {
                status_2.Text = "Date not Valid";
                return;
            }
            


            String full_time = sdate + " " + sho + ":00:00";
            //Response.Write(full_time + "<br>");

            DateTime sdateTime = DateTime.Parse(full_time);
            full_time= edate1 + " " + eho + ":00:00";
            DateTime edateTime = DateTime.Parse(full_time);
            String cmd = "addNewMatch";
           // Response.Write(full_time+"<br>");
            SqlCommand scmd = new SqlCommand(cmd, null);
            scmd.CommandType = CommandType.StoredProcedure;


            scmd.Parameters.Add("@host_club", SqlDbType.VarChar).Value = hc;
            scmd.Parameters.Add("@guest_club ", SqlDbType.VarChar).Value = gc;
            scmd.Parameters.Add("@start_time ", SqlDbType.DateTime).Value = sdateTime;
            scmd.Parameters.Add("@end_time ", SqlDbType.DateTime).Value = edateTime;


            String feedback = Login.SqlInsert(Login.connetionString, scmd);
            if (feedback.Contains("-1"))
                status1.Text = "No Data available";

        }



        protected void deletmatchbtn_Click(object sender, EventArgs e)
        {

            /// error

            string hc = delete_hc.Text;
            string gc = delet_gc.Text;

            String sdate = delete_date.Text;
            String edate1 = TextBox1.Text;
            String sho = delete_hour.Text;
            String eho = TextBox2.Text;

            if (!ishourOk(sho) || !ishourOk(eho) || sdate == "" || edate1 == "")
            {
                status_2.Text = "Date not Valid";
                return;
            }



            String full_time = sdate + " " + sho + ":00:00";
            //Response.Write(full_time + "<br>");

            DateTime sdateTime = DateTime.Parse(full_time);
            full_time = edate1 + " " + eho + ":00:00";
            DateTime edateTime = DateTime.Parse(full_time);
            String cmd = "deleteMatch";
            // Response.Write(full_time+"<br>");
            SqlCommand scmd = new SqlCommand(cmd, null);
            scmd.CommandType = CommandType.StoredProcedure;


            scmd.Parameters.Add("@host_club", SqlDbType.VarChar).Value = hc;
            scmd.Parameters.Add("@guest_club ", SqlDbType.VarChar).Value = gc;
            


            String feedback = Login.SqlInsert(Login.connetionString, scmd);
            if (feedback.Contains("-1"))
                status1.Text = "No Data available";

        }

        private bool ishourOk(string ho)
        {
            if (ho.Length > 2 ) return false;
            for (int i = 0; i < ho.Length; i++) { 
            if(!char.IsDigit(ho[i])) return false;   
            }
            int v = int.Parse(ho);
            if (v > 0 && v < 24) return true;
            else return false;

        }

        protected void view_upcomming_matches_Click(object sender, EventArgs e)
        {
            String cmd = "select * from availableMatchesToAttend (@date)";

            SqlCommand scmd = new SqlCommand(cmd, null);
            scmd.CommandType = CommandType.Text;
            DateTime dt = DateTime.Now;
           
            scmd.Parameters.Add("@date", SqlDbType.DateTime).Value = dt;
            DataTable table = Login.SqlTable(Login.connetionString, scmd);
            if (table.Rows.Count == 0)
                status1.Text = "No Data available";
            vew_upcommingmatches.DataSource = table;
            vew_upcommingmatches.DataBind();
        }

        protected void btn_Already_Played_Click(object sender, EventArgs ie)
        {

            status2.Text = "";
           String cmd = "select * from matchesRankedByAttendance()";


            SqlCommand sqlcmd = new SqlCommand(cmd, null);
            sqlcmd.CommandType = CommandType.Text;
            DataTable table = Login.SqlTable(Login.connetionString, sqlcmd);
            // Response.Write(table + "  fv,v,fll");
            if (table.Rows.Count == 0)
                status2.Text = "No Data available";
            view_pair.DataSource = table;
            view_pair.DataBind();





        }

        protected void btn_pair_Click(object sender, EventArgs e)
        {
            
            String cmd = "select * from clubsNeverMatched";
            
            SqlCommand sqlcmd = new SqlCommand(cmd, null);
            
           DataTable table = Login.SqlTable(Login.connetionString,sqlcmd);
            if (table.Rows.Count == 0)
                status3.Text = "No Data available";
            view_pair.DataSource  = table;
            view_pair.DataBind();


            
        }
    }
}