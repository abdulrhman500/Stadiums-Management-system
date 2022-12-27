using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Drawing;

namespace Stadiums_Management_System
{
    public partial class Purshase : System.Web.UI.Page
    {
        String host ;
        String guest;
        DateTime date ;
        String stadium;
       public static bool PurshaseDone = false;
        protected void Page_Load(object sender, EventArgs e)
        {

                Response.Write("Page load " + PurshaseDone + " ");
                Control div = Page.FindControl("IdConfirm");
                if (Session["host"] != null && !PurshaseDone)
                {

                    host = Session["host"].ToString();
                    guest = Session["guest"].ToString();
                    date = DateTime.Parse(Session["date"].ToString());
                    stadium = Session["stadium"].ToString();

                    AddConfirmationDiv(host, guest, date, stadium);
                }
            }
        





        private void AddConfirmationDiv(String host, String guest, DateTime date, String stadium)
        {

            HtmlGenericControl div = new HtmlGenericControl("div");

            div.ID = "IdConfirm";

            div.Attributes.Add("class", "myClass");

            Label title = new Label();

            title.ID = "Title";

            title.Text = "Confirm Purshasing a Ticket for " + host + " VS " + guest + " at " + date + " at " + stadium;
            title.ForeColor = Color.Black;
            title.Font.Bold = true;

            div.Controls.Add(title);
            div.Controls.Add(br());

            Label lb = new Label();
            lb.Text = "National Id : ";
            div.Controls.Add(lb);

            // div.Controls.Add(br());
            TextBox textBox = new TextBox();
            textBox.ID = "nationalID";
            div.Controls.Add(textBox);
            div.Controls.Add(br());

            Button button = new Button();
            button.ID = "purchase_btn";
            button.Click += purchase_btn_click;
            button.Text = "Purchase";
            div.Controls.Add(button);

            form1.Controls.Add(div);



        }
        protected void purchase_btn_click(object sender, EventArgs e)
        {
            
            PurshaseDone = false;

           
            Response.Write("The button was clicked!");

            if (PurshaseDone)
            {
                Control div = Page.FindControl("IdConfirm");
                form1.Controls.Remove(div);
            }
        }


        private void purchase(String NationalID, String HostClubName, String GuestClubName, DateTime dt)
        {
            //String cmd = "";
            SqlCommand sqlCmd = new SqlCommand("purchaseTicket", null);
            sqlCmd.CommandType = CommandType.StoredProcedure;

            sqlCmd.Parameters.Add("@nationalID", SqlDbType.VarChar).Value = NationalID;
            sqlCmd.Parameters.Add("@@h_clubName", SqlDbType.VarChar).Value = HostClubName;
            sqlCmd.Parameters.Add("@g_clubName", SqlDbType.VarChar).Value = GuestClubName;
            sqlCmd.Parameters.Add("@startTime", SqlDbType.DateTime).Value = dt;


            Login.SqlInsert(Login.connetionString, sqlCmd);


        }


        private HtmlGenericControl br()
        {

            HtmlGenericControl br = new HtmlGenericControl("br");
            return br;
        }


    }
}