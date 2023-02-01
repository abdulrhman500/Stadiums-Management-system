using System;
using System.Data;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Sports_League_Managament_System.StadiumManager
{
    public partial class Stadium_Manager : System.Web.UI.Page
    {
        private string UserName;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Utils.isLogged(Request, Session, "Stadium_Manager"))
                Response.Redirect("/Login/Login.aspx");

            UserName = Session["username"].ToString();
            UserH.InnerText = "Welcome " + UserName;

            viewStadiumDetails();

            viewAllRequests();

            viewAllPendingRequests();

            if (!String.IsNullOrEmpty(Utils.requestMessage))
            {
                if (Utils.requestMessage == "1") Label.Text = "Success";
                else Label.Text = "Failure. Stadium is not available or is busy.";

                Utils.requestMessage = null;
            }

        }

        private void viewStadiumDetails()
        {
            string sqlCmd = "SELECT S.* FROM Stadium_Manager  SM, Stadium S " +
                "           Where SM.username = @username AND SM.stadium_id = S.id";
            string[] parameters = { "@username" };
            Object[] values = { UserName };

            DataTable table = Utils.SqlTable(sqlCmd, parameters, values);

            if (table.Rows.Count == 0)
                StadiumDiv.InnerText = "You are not assigned to any Stadium";
            else
                addDetailsDiv(table);
        }

        private void addDetailsDiv(DataTable table)
        {
            Object[] rowValues = table.Rows[0].ItemArray;

            HtmlGenericControl stadiumId = new HtmlGenericControl("p");
            HtmlGenericControl stadiumName = new HtmlGenericControl("p");
            HtmlGenericControl stadiumLocation = new HtmlGenericControl("p");
            HtmlGenericControl capacity = new HtmlGenericControl("p");
            HtmlGenericControl is_available = new HtmlGenericControl("p");

            stadiumId.InnerText = "Your Stadium ID = " + rowValues[0].ToString();
            stadiumName.InnerText = "Your Stadium Name is " + rowValues[1].ToString();
            stadiumLocation.InnerText = "Your Stadium Location is " + rowValues[2].ToString();
            capacity.InnerText = "Your Stadium Capacity is " + rowValues[3].ToString();
            is_available.InnerText = "Your Stadium is " + (rowValues[4].ToString() == "True" ? "Available" : "Not Available");

            StadiumDiv.Controls.Add(stadiumId);
            StadiumDiv.Controls.Add(stadiumName);
            StadiumDiv.Controls.Add(stadiumLocation);
            StadiumDiv.Controls.Add(capacity);
            StadiumDiv.Controls.Add(is_available);
        }

        private void viewAllRequests()
        {
            string sql = "SELECT Match_id, Club_Representative, is_approved FROM allRequests WHERE Stadium_Manager = @username";
            string[] parameters = { "@username" };
            Object[] values = { UserName };

            DataTable table = Utils.SqlTable(sql, parameters, values);

            GridView1.DataSource = table;
            GridView1.DataBind();
        }

        private DataTable viewAllPendingRequests()
        {
            string sql = "SELECT * FROM allPendingRequests(@username)";
            string[] parameters = { "@username" };
            Object[] values = { UserName };

            DataTable table = Utils.SqlTable(sql, parameters, values);
            GridView2.DataSource = table;
            GridView2.DataBind();

            return table;
        }


        protected void acceptRequset(object sender, EventArgs e)
        {
            // Get the button that raised the event
            Button button = sender as Button;

            // Get the row that contains the button
            GridViewRow row = button.NamingContainer as GridViewRow;

            string procedureName = "acceptRequest";
            handleRequest(row, procedureName);
        }

        protected void rejectRequest(object sender, EventArgs e)
        {
            // Get the button that raised the event
            Button button = sender as Button;

            // Get the row that contains the button
            GridViewRow row = button.NamingContainer as GridViewRow;

            string procedureName = "rejectRequest";
            handleRequest(row, procedureName);
        }

        private void handleRequest(GridViewRow row, string procedureName)
        {
            String representative = row.Cells[2].Text;
            String guest = row.Cells[3].Text;
            string host = getHost(representative);
            DateTime dt = DateTime.Parse(row.Cells[4].Text);
            string date = dt.ToString("yyyy-MM-dd HH:mm:ss");

            string[] parameters = { "@sm_username", "@host_club", "@guest_club", "@time" };
            Object[] values = { UserName, host, guest, date };
            bool isSuccess = Utils.execProcedure(procedureName, parameters, values);


            if (procedureName == "acceptRequest" && isSuccess)
                addTickets(host, guest, date);

            if (isSuccess)
            {
                Utils.requestMessage = "1";
                Page.Response.Redirect(Page.Request.Url.ToString(), false);
            }
            else 
                Utils.requestMessage = "0";

        }

        private string getHost(string representative)
        {
            string sql = "SELECT c.name FROM Club c JOIN Club_Representative cr ON cr.club_id = c.id AND cr.username = @representative";
            string[] parameters = { "@representative" };
            Object[] values = { representative };

            DataTable table = Utils.SqlTable(sql, parameters, values);

            if (table.Rows.Count == 0)
                return Label.Text = "No data";

            Object[] rowArr = table.Rows[0].ItemArray;
            string host = rowArr[0].ToString();

            return host;
        }
        private bool addTickets(string host, string guest, string date)
        {
            string procedureName = "addTicket";

            string[] parameters = { "@host_club", "@guest_club", "@time" };
            Object[] values = { host, guest, date };
            bool isSuccess = Utils.execProcedure(procedureName, parameters, values);

           return isSuccess;

        }

    }
}