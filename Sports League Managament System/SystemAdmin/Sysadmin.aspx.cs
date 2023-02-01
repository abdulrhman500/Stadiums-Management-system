using System;

namespace Sports_League_Managament_System.SystemAdmin
{
    public partial class Sysadmin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Utils.isLogged(Request, Session, "System_Admin"))
                Response.Redirect("/Login/Login.aspx");

        }

        protected void btn_club_Click(object sender, EventArgs e)
        {
            String clubName = clubn.Text;
            String clubLocation = location.Text;

            String procedureName = "addClub";
            string[] parameters = { "@cname", "@clocation" };
            Object[] values = { clubName, clubLocation };

            bool isSuccess = Utils.execProcedure(procedureName, parameters, values);

            if (isSuccess)
                Response.Write("Success");
            else
                Response.Write("Failed");
        }

        protected void btn_deleteclub_Click(object sender, EventArgs e)
        {
            String clubName = delete_club.Text;

            String procedureName = "deleteClub";
            string[] parameters = { "@cname" };
            Object[] values = { clubName };

            bool isSuccess = Utils.execProcedure(procedureName, parameters, values);

            if (isSuccess)
                Response.Write("Success");
            else
                Response.Write("Failed");

        }

        protected void add_std_Click(object sender, EventArgs e)
        {

            String stadiumName = sname.Text;
            String stadiumLocation = slocation.Text;
            String capacity = cap.Value;

            String procedureName = "addStadium";
            string[] parameters = { "@sname", "@slocation", "@capacity" };
            Object[] values = { stadiumName, stadiumLocation, capacity };

            bool isSuccess = Utils.execProcedure(procedureName, parameters, values);

            if (isSuccess)
                Response.Write("Success");
            else
                Response.Write("Failed");

        }

        protected void btn_delete_std_Click(object sender, EventArgs e)
        {
            String stadiumName = std_name.Text;

            String procedureName = "deleteStadium";
            string[] parameters = { "@sname" };
            Object[] values = { stadiumName };

            bool isSuccess = Utils.execProcedure(procedureName, parameters, values);

            if (isSuccess)
                Response.Write("Success");
            else
                Response.Write("Failed");

        }


        protected void btn_block_Click(object sender, EventArgs e)
        {
            String id = TextBox1.Value;

            String procedureName = "blockFan";
            string[] parameters = { "@id" };
            Object[] values = { id };

            bool isSuccess = Utils.execProcedure(procedureName, parameters, values);

            if (isSuccess)
                Response.Write("Success");
            else
                Response.Write("Failed");

        }


    }
}