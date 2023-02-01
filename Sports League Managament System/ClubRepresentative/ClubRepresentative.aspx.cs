using System;
using System.Data;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Sports_League_Managament_System.ClubRepresentative
{
    public partial class Club_Representative : System.Web.UI.Page
    {
        private string UserName;
        private string club_name;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Utils.isLogged(Request, Session, "Club_Representative"))
                Response.Redirect("/Login/Login.aspx");

            UserName = Session["username"].ToString();
            UserH.InnerText = "Welcome " + UserName;

            viewClubDetails();

            viewUpcomingMatches();

            viewStadiums();

            displayUnassignedMatches();

        }

        private void viewClubDetails()
        {
            string sqlCmd = "SELECT C.* FROM Club_Representative CR, Club C " +
                "           Where CR.username = @username AND CR.club_id = C.id";
            string[] parameters = { "@username" };
            Object[] values = { UserName };

            DataTable table = Utils.SqlTable(sqlCmd, parameters, values);

            if (table.Rows.Count == 0)
                ClubDiv.InnerText = "You are not assigned to any club";
            else
                addDetailsDiv(table);
        }

        private void addDetailsDiv(DataTable table)
        {
            Object[] rowValues = table.Rows[0].ItemArray;

            HtmlGenericControl clubId = new HtmlGenericControl("p");
            HtmlGenericControl clubName = new HtmlGenericControl("p");
            HtmlGenericControl clubLocation = new HtmlGenericControl("p");

            clubId.InnerText = "Your Club ID = " + rowValues[0].ToString();
            club_name = rowValues[1].ToString();
            clubName.InnerText = "Your Club Name is " + club_name;
            clubLocation.InnerText = "Your Club Location is " + rowValues[2].ToString();

            ClubDiv.Controls.Add(clubId);
            ClubDiv.Controls.Add(clubName);
            ClubDiv.Controls.Add(clubLocation);
        }

        private void viewUpcomingMatches()
        {
            string sql = "SELECT * FROM upcomingMatchesOfClub(@clubname)";
            string[] parameters = { "@clubname" };
            Object[] values = { club_name };

            DataTable table = Utils.SqlTable(sql, parameters, values);

            upcomingMatches.DataSource = table;
            upcomingMatches.DataBind();
        }

        protected void viewAvailableStadiums(object sender, EventArgs e)
        {
            DateTime date = Datetime1.Value != "" ? DateTime.Parse(Datetime1.Value) : DateTime.Now;
            string dt = date.ToString("yyyy-MM-dd HH:mm:ss");

            string sql = "SELECT * FROM viewAvailableStadiumsOn(@datetime)";
            string[] parameters = { "@datetime" };
            Object[] values = { dt };

            DataTable table = Utils.SqlTable(sql, parameters, values);

            availableStadiums.DataSource = table;
            availableStadiums.DataBind();
        }

        private void viewStadiums()
        {
            string sqlCmd = "SELECT name FROM Stadium;";
            string[] parameters = { };
            Object[] values = { };

            DataTable table = Utils.SqlTable(sqlCmd, parameters, values);

            if (table.Rows.Count == 0)
                ClubDiv.InnerText = "There are no stadium in the database";
            else
            {
                StadiumRequest.InnerHtml = "<select class=\"nav-item dropdown\" name=\"selectedStadium\" id=\"selectedStadium\">\r\n ";
                foreach (DataRow row in table.Rows)
                    StadiumRequest.InnerHtml += "<option class=\"nav-item\" value=\"" + row[0] + "\">" + row[0] + "</option>\r\n";
                StadiumRequest.InnerHtml += "</select>";
            }
        }

        private DataTable displayUnassignedMatches()
        {
            string sql = "SELECT * FROM allUnASsignedMatches(@cname)";
            string[] parameters = { "@cname" };
            Object[] values = { club_name };

            DataTable table = Utils.SqlTable(sql, parameters, values);

            UnassignedMatches.DataSource = table;
            UnassignedMatches.DataBind();

            return table;
        }


        protected void makeHostRequest(object sender, EventArgs e)
        {
            String selectedStadium = Request.Form["selectedStadium"];

            if (String.IsNullOrEmpty(selectedStadium))
            {
                Label1.Text = "You must choose a match.";
                return;
            }

            int selectedMatchIndex = Int32.Parse(Request.Form["matchSelected"]);
            string selectedMatchDate = displayUnassignedMatches().Rows[selectedMatchIndex].ItemArray[1].ToString();
            DateTime date = DateTime.Parse(selectedMatchDate);
            string dt = date.ToString("yyyy-MM-dd HH:mm:ss");

            string procedureName = "addHostRequest";

            string[] parameters = { "@club_name", "@stad_name", "@date" };
            Object[] values = { club_name, selectedStadium, dt };
            bool isSuccess = Utils.execProcedure(procedureName, parameters, values);

            if (isSuccess)
                Label1.Text = "Completed Successfully for " + selectedStadium;
            else
                Label1.Text = "Failed, there is no match with this date " + dt;

        }


    }
}