using System;
using System.Data;

namespace Sports_League_Managament_System.SportsAssociationManager
{
    public partial class sam : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!Utils.isLogged(Request, Session, "Sports_ASsociation_Manager"))
                Response.Redirect("/Login/Login.aspx");

        }

        protected void Addnewmatch_Click(object sender, EventArgs e)
        {
            string host = new_match_hclub.Text;
            string guest = new_match_gclub.Text;
            DateTime startDate = DateTime.Parse(new_match_start.Value);
            string startDT = startDate.ToString("yyyy-MM-dd HH:mm:ss");
            DateTime endDate = DateTime.Parse(edate.Value);
            string endDT = endDate.ToString("yyyy-MM-dd HH:mm:ss");

            String procedureName = "addNewMatch";

            string[] parameters = { "@host_club", "@guest_club", "@start_time", "@end_time" };
            Object[] values = { host, guest, startDT, endDT };
            bool isSuccess = Utils.execProcedure(procedureName, parameters, values);

            if (isSuccess)
                message.Text = "Suceessfuly added new match";
            else
                message.Text = "No Data available";

        }


        protected void deletmatchbtn_Click(object sender, EventArgs e)
        {

            string host = delete_hc.Text;
            string guest = delet_gc.Text;

            String procedureName = "deleteMatch";
            string[] parameters = { "@host_club", "@guest_club" };
            Object[] values = { host, guest };

            bool isSuccess = Utils.execProcedure(procedureName, parameters, values);

            if (isSuccess)
                message.Text = "Suceessfuly deleted match";
            else
                message.Text = "No Data available";
        }


        protected void view_upcomming_matches_Click(object sender, EventArgs e)
        {

            DateTime dt = DateTime.Now;

            String cmd = "select * from availableMatchesToAttend(@date)";
            string[] parameters = { "@date" };
            Object[] values = { dt };

            DataTable table = Utils.SqlTable(cmd, parameters, values);

            if (table.Rows.Count == 0)
                message.Text = "No Data available";

            vew_upcommingmatches.DataSource = table;
            vew_upcommingmatches.DataBind();
        }

        protected void btn_Already_Played_Click(object sender, EventArgs ie)
        {

            String cmd = "SELECT * from matchesRankedByAttendance()";
            string[] parameters = { };
            Object[] values = { };

            DataTable table = Utils.SqlTable(cmd, parameters, values);

            if (table.Rows.Count == 0)
                message.Text = "No Data available";

            view_pair.DataSource = table;
            view_pair.DataBind();

        }

        protected void btn_pair_Click(object sender, EventArgs e)
        {

            String cmd = "select * from clubsNeverMatched";
            string[] parameters = { };
            Object[] values = { };

            DataTable table = Utils.SqlTable(cmd, parameters, values);

            if (table.Rows.Count == 0)
                message.Text = "No Data available";

            view_pair.DataSource = table;
            view_pair.DataBind();

        }
    }
}