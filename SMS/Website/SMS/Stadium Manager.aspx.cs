using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace SMS
{
    public partial class Stadium_Manager : System.Web.UI.Page
    {
        public static string connectionString = WebConfigurationManager.ConnectionStrings["CS_Abdo"].ToString();
        string UserName;
        string stadium_name;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                //if (!SMS.Utils.isLogged(Request, Session))
                //    Response.Redirect("Login.aspx");

                //UserName = Session["username"].ToString();
                //UserH.InnerText = "Welcome " + UserName;

                viewStadiumDetails();

                viewAllRequests();

                viewAllPendingRequests();
            }
        }

        private void viewStadiumDetails()
        {
            string sqlCmd = "SELECT S.* FROM Stadium_Manager  SM, Stadium S " +
                "           Where SM.username = @username AND SM.stadium_id = S.id";
            SqlCommand sqlCommand = new SqlCommand(sqlCmd, null);
            sqlCommand.Parameters.AddWithValue("@username", UserName);

            DataTable table = SMS.Utils.SqlTable(connectionString, sqlCommand);
            if (table.Rows.Count == 0)
                StadiumDiv.InnerText = "You are not assigned to any Stadium";
            else
            {
                Object[] rowValues = table.Rows[0].ItemArray;

                HtmlGenericControl stadiumId = new HtmlGenericControl("p");
                HtmlGenericControl stadiumName = new HtmlGenericControl("p");
                HtmlGenericControl stadiumLocation = new HtmlGenericControl("p");
                HtmlGenericControl capacity = new HtmlGenericControl("p");
                HtmlGenericControl is_available = new HtmlGenericControl("p");

                stadiumId.InnerText = "Your Stadium ID = " + rowValues[0].ToString();
                stadium_name = rowValues[1].ToString();
                stadiumName.InnerText = "Your Stadium Name is " + stadium_name;
                stadiumLocation.InnerText = "Your Stadium Location is " + rowValues[2].ToString();
                capacity.InnerText = "Your Stadium Capacity is " + rowValues[3].ToString();

                string isAvailable = "";
                if (rowValues[3].ToString() != null)
                    if (rowValues[3].ToString() == "1")
                        isAvailable = "It is Available";
                    else
                        isAvailable = "It is Not Available";
                else
                    isAvailable = "Pending";
                is_available.InnerText = "Your Stadium is " + isAvailable;

                StadiumDiv.Controls.Add(stadiumId);
                StadiumDiv.Controls.Add(stadiumName);
                StadiumDiv.Controls.Add(stadiumLocation);
                StadiumDiv.Controls.Add(capacity);
                StadiumDiv.Controls.Add(is_available);

            }
        }

        private void viewAllRequests()
        {
            string sql = "SELECT cr.username club_represenative, c2.name host_club, c.name guest_club, m.starting_time, m.end_time, re.is_approved status\r\n    FROM Request re\r\n\tJOIN Match m ON m.id = re.Match_id\r\n\tJOIN club c ON c.id = m.guest_club\r\n\tJOIN Club c2 ON c2.id = m.host_club\r\n\tJOIN Club_Representative cr ON cr.id = re.Club_Representative_id\r\n\tJOIN SystemUser su ON su.username = cr.username\r\n\tJOIN Stadium_Manager sm ON re.Stadium_Manager_id = sm.id\r\n\tWHERE sm.username = @username\r\n";
            SqlCommand command = new SqlCommand(sql, null);
            command.Parameters.AddWithValue("@username", UserName);

            DataTable data = SMS.Utils.SqlTable(connectionString, command);

            GridView1.DataSource = data;
            GridView1.DataBind();
        }

        private DataTable viewAllPendingRequests()
        {
            string sql = "SELECT * FROM allPendingRequests(@username)";
            SqlCommand command = new SqlCommand(sql, null);
            command.Parameters.AddWithValue("@username", UserName);

            DataTable pendingData = SMS.Utils.SqlTable(connectionString, command);
            GridView2.DataSource = pendingData;
            GridView2.DataBind();

            return pendingData;
        }


        protected void acceptRequset(object sender, EventArgs e)
        {
            // Get the button that raised the event
            Button button = sender as Button;

            // Get the row that contains the button
            GridViewRow row = button.NamingContainer as GridViewRow;

            String guest = row.Cells[2].Text;
            String host = row.Cells[1].Text;
            DateTime date = DateTime.Parse(row.Cells[3].Text);

            string sql = "SELECT m.id FROM Match m\r\nJOIN Club c1 ON m.guest_club = c1.id AND c1.name = @guest\r\nJOIN Club c2 ON m.host_club = c2.id AND c2.name = @host\r\nand m.starting_time = @date";
            SqlCommand command = new SqlCommand(sql, null);
            command.Parameters.AddWithValue("@guest", guest);
            command.Parameters.AddWithValue("@host", host);
            command.Parameters.AddWithValue("@guest", date);

            DataTable pendingData = SMS.Utils.SqlTable(connectionString, command);

            Object[] rowArr = pendingData.Rows[0].ItemArray;
            int matchID = Int32.Parse(rowArr[0].ToString());


            string sql1 = "SELECT * FROM Match WHERE id = @matchID";
            SqlCommand command1 = new SqlCommand(sql1, null);
           command1.Parameters.AddWithValue("@matchID", matchID);

            DataTable matchInfo = SMS.Utils.SqlTable(connectionString, command1);
            Object[] matchValues = matchInfo.Rows[0].ItemArray;
            string guest_club = matchValues[1].ToString();
            string host_club = matchValues[2].ToString();
            DateTime starting_time = DateTime.Parse(matchValues[3].ToString());

            string procedureName = "acceptRequest";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                SqlCommand sqlCommand = new SqlCommand();
                sqlCommand.CommandType = CommandType.StoredProcedure;
                sqlCommand.CommandText = procedureName;
                sqlCommand.Connection = connection;

                sqlCommand.Parameters.AddWithValue("@sm_username", UserName);
                sqlCommand.Parameters.AddWithValue("@host_club", host_club);
                sqlCommand.Parameters.AddWithValue("@guest_club", guest_club);
                sqlCommand.Parameters.AddWithValue("@date", starting_time);

                int numOfRowsAffected = sqlCommand.ExecuteNonQuery();
                if (numOfRowsAffected > 0) Label.Text = "Success";
                else Label.Text = "Failure";
            }


        }

        protected void rejectRequest(object sender, EventArgs e)
        {

            // Get the button that raised the event
            Button button = sender as Button;

            // Get the row that contains the button
            GridViewRow row = button.NamingContainer as GridViewRow;

            String guest = row.Cells[2].Text;
            String host = row.Cells[1].Text;
            DateTime date = DateTime.Parse("01/08/2017 08:00:00");

            string sql = "SELECT m.id FROM Match m\r\nJOIN Club c1 ON m.guest_club = c1.id AND c1.name = @guest\r\nJOIN Club c2 ON m.host_club = c2.id AND c2.name = @host\r\nand m.starting_time = @date";
            SqlCommand command = new SqlCommand(sql, null);
            command.Parameters.AddWithValue("@guest", guest);
            command.Parameters.AddWithValue("@host", host);
            command.Parameters.AddWithValue("@guest", date);

            DataTable pendingData = SMS.Utils.SqlTable(connectionString, command);

            Object[] rowArr = pendingData.Rows[0].ItemArray;
            int matchID = Int32.Parse(rowArr[0].ToString());


            string sql1 = "SELECT * FROM Match WHERE id = @matchID";
            SqlCommand command1 = new SqlCommand(sql1, null);
            command1.Parameters.AddWithValue("@matchID", matchID);

            DataTable matchInfo = SMS.Utils.SqlTable(connectionString, command1);
            Object[] matchValues = matchInfo.Rows[0].ItemArray;
            string guest_club = matchValues[1].ToString();
            string host_club = matchValues[2].ToString();
            DateTime starting_time = DateTime.Parse(matchValues[3].ToString());

            string procedureName = "rejectRequest";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                SqlCommand sqlCommand = new SqlCommand();
                sqlCommand.CommandType = CommandType.StoredProcedure;
                sqlCommand.CommandText = procedureName;
                sqlCommand.Connection = connection;

                sqlCommand.Parameters.AddWithValue("@sm_username", UserName);
                sqlCommand.Parameters.AddWithValue("@host_club", host_club);
                sqlCommand.Parameters.AddWithValue("@guest_club", guest_club);
                sqlCommand.Parameters.AddWithValue("@date", starting_time);

                int numOfRowsAffected = sqlCommand.ExecuteNonQuery();
                if (numOfRowsAffected > 0) Label.Text = "Success";
                else Label.Text = "Failure";
            }
        }

    }
}