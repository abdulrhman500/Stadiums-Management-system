using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using SMS;
using System.Web.UI.HtmlControls;
using System.Data.SqlTypes;

namespace SMS
{
    public partial class Club_Representative : System.Web.UI.Page
    {
        public static string connectionString = WebConfigurationManager.ConnectionStrings["CS_Omar"].ToString();
        string UserName;
        string club_name;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!SMS.Utils.isLogged(Request, Session))
                Response.Redirect("Login.aspx");

            UserName = Session["username"].ToString();
            UserH.InnerText = "Welcome " + UserName;

            viewClubDetails();

            viewUpcomingMatches();

            //viewAvailableStadiums();

            viewStadiums();
        }

        private void viewClubDetails()
        {
            string sqlCmd = "SELECT C.* FROM Club_Representative CR, Club C " +
                "           Where CR.username = @username AND CR.club_id = C.id";
            SqlCommand sqlCommand = new SqlCommand(sqlCmd, null);
            sqlCommand.Parameters.AddWithValue("@username", UserName);

            DataTable table = SMS.Utils.SqlTable(connectionString, sqlCommand);
            if (table.Rows.Count == 0)
                ClubDiv.InnerText = "You are not assigned to any club";
            else
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
        }

        private void viewUpcomingMatches()
        {
            string sql = "SELECT * FROM upcomingMatchesOfClub(@clubname)";
            SqlCommand command = new SqlCommand(sql, null);
            command.Parameters.AddWithValue("@clubname", club_name);

            DataTable data = SMS.Utils.SqlTable(connectionString, command);

            GridView1.DataSource = data;
            GridView1.DataBind();
        }

        protected void viewAvailableStadiums(object sender, EventArgs e)
        {
            string sql = "SELECT * FROM viewAvailableStadiumsOn(@datetime)";
            SqlCommand command = new SqlCommand(sql, null);
            DateTime dt = DateTime.Parse(HiddenField1.Value);
            command.Parameters.AddWithValue("@datetime", dt);

            DataTable data = SMS.Utils.SqlTable(connectionString, command);
            GridView2.DataSource = data;
            GridView2.DataBind();
        }

        private void viewStadiums()
        {
            string sqlCmd = "SELECT name FROM Stadium;";
            SqlCommand sqlCommand = new SqlCommand(sqlCmd, null);

            DataTable table = SMS.Utils.SqlTable(connectionString, sqlCommand);
            if (table.Rows.Count == 0)
                ClubDiv.InnerText = "There are no stadium in the database";
            else
            {
                StadiumRequest.InnerHtml = "";
                foreach (DataRow row in table.Rows)
                    StadiumRequest.InnerHtml += "<input type=\"radio\" name=\"radioButtonGroup\" value=\" " + row[0] + "\" checked/>" + row[0] + " <br>\n";

                //StadiumRequest.InnerHtml += "";

            }
        }

        protected void makeHostRequest(object sender, EventArgs e)
        {

            string selectedOption = Request.Form["radioButtonGroup"];
            string procedureName = "addHostRequest";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                SqlCommand sqlCommand = new SqlCommand();
                sqlCommand.CommandType = CommandType.StoredProcedure;
                sqlCommand.CommandText = procedureName;
                sqlCommand.Connection = connection;

                DateTime dt = DateTime.Parse(HiddenField1.Value);
                sqlCommand.Parameters.AddWithValue("@club_name", club_name);
                sqlCommand.Parameters.AddWithValue("@stad_name", selectedOption);
                sqlCommand.Parameters.AddWithValue("@date", dt);

                int numOfRowsAffected = sqlCommand.ExecuteNonQuery();
                if (numOfRowsAffected > 0)
                    Label1.Text = "Completed Successfully " + selectedOption;
                else
                    Label1.Text = "Failed" + selectedOption;

            }
            

        }
    }
}