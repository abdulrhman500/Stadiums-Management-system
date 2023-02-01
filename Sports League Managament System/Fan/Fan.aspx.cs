using System;
using System.Data;
using System.Web.UI.WebControls;

namespace Sports_League_Managament_System.Fan
{
    public partial class Fan : System.Web.UI.Page
    {
        static string UserName;
        static string nationalID;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Utils.isLogged(Request, Session, "Fan"))
                Response.Redirect("/Login/Login.aspx");

            UserName = Session["username"].ToString();
            getNationalId();

            displayPurchasedTickets();
        }

        private void getNationalId()
        {
            string sql = "SELECT national_id FROM allFans WHERE username = @username";
            string[] parameters = { "@username" };
            Object[] values = { UserName };

            DataTable table = Utils.SqlTable(sql, parameters, values);

            nationalID = table.Rows[0].ItemArray[0].ToString();
        }

        protected void purchaseTicket(object sender, EventArgs e)
        {
            // Get the button that raised the event
            Button button = sender as Button;

            // Get the row that contains the button
            GridViewRow row = button.NamingContainer as GridViewRow;

            string host = row.Cells[1].Text;
            string guest = row.Cells[2].Text;
            DateTime date = DateTime.Parse(row.Cells[3].Text);

            String procedureName = "purchaseTicket";
            string[] parameters = { "@nationalID", "@h_clubName", "@g_clubName", "startTime" };
            Object[] values = { nationalID, host, guest, date };

            bool isSuccess = Utils.execProcedure(procedureName, parameters, values);

            if (isSuccess) Label.Text = "Success";
            else Label.Text = "Failed";


        }


        protected void show_Match_Click(object sender, EventArgs e)
        {

            DateTime dt = DateTime.Now;
            if (matchDate1.Value != "")
                dt = DateTime.Parse(matchDate1.Value);
            string date = dt.ToString("yyyy-MM-dd HH:mm:ss");

            string sql = "SELECT * FROM availableMatchesToAttend(@date)";
            string[] parameters = { "@date" };
            Object[] values = { date };

            DataTable table = Utils.SqlTable(sql, parameters, values);

            MatchesTable.DataSource = table;
            MatchesTable.DataBind();

            if (table.Rows.Count == 0)
                Label.Text = "There are no matches";

        }

        private void displayPurchasedTickets()
        {
            string sql = "SELECT * FROM PurchasedTicketsMatches(@username)";
            string[] parameters = { "@username" };
            Object[] values = { UserName };

            DataTable table = Utils.SqlTable(sql, parameters, values);

            TicketTable.DataSource = table;
            TicketTable.DataBind();

            if (table.Rows.Count == 0)
                Label1.Text = "You didn't purchase any tickets";
        }
    }
}