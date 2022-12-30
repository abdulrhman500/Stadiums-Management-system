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

namespace SMS
{
    public partial class Purchase : System.Web.UI.Page
    {
        String host ;
        String guest;
        DateTime date ;
        String stadium;
       public static bool PurchaseDone = false;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!isLogedin() || Session.IsNewSession)
                Response.Redirect("Login.aspx");

            if (PurchaseDone) {
                Session.Remove("host");
                Response.Redirect("Fan.aspx");

            }

            ba.Visible = false;
            Done.Visible = false;
            
            if (Session["host"] != null && !PurchaseDone)
            {

                host = Session["host"].ToString();
                guest = Session["guest"].ToString();
                date = DateTime.Parse(Session["date"].ToString());
                stadium = Session["stadium"].ToString();

                AddConfirmationDiv(host, guest, date, stadium);


            }
           else if(Session["host"] == null)
            {
            
                ba.Visible = true;
                Done.Visible=true; 

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

         
            if (!PurchaseDone)
            {

                TextBox id = (TextBox)Page.FindControl("nationalID");

                String nationalID = id.Text;
                String rowsCount = purchase(nationalID, host, guest, date);
                status.ForeColor = Color.Red; status.Font.Bold = true;
                if (rowsCount.Contains("-1"))
                    status.Text = "Internal Error "+rowsCount;
                else PurchaseDone = true;
            }
            if (PurchaseDone)
            {
                Control div = Page.FindControl("IdConfirm");
                form1.Controls.Remove(div);


                Session.Remove("host");
                ba.Visible = true;
                Done.Text = "Purchase done Successfully";
                Done.Visible = true;
              



            }

        }
        protected void back_click(object sender, EventArgs e)
        {

            Response.Redirect("Fan.aspx");



        }


            private String purchase(String NationalID, String HostClubName, String GuestClubName, DateTime dt)
        {
            //String cmd = "";
            SqlCommand sqlCmd = new SqlCommand("purchaseTicket", null);
            sqlCmd.CommandType = CommandType.StoredProcedure;

            sqlCmd.Parameters.Add("@nationalID", SqlDbType.VarChar).Value = NationalID;
            sqlCmd.Parameters.Add("@h_clubName", SqlDbType.VarChar).Value = HostClubName;
            sqlCmd.Parameters.Add("@g_clubName", SqlDbType.VarChar).Value = GuestClubName;
            sqlCmd.Parameters.Add("@startTime", SqlDbType.DateTime).Value = dt;


           return  Login.SqlInsert(Login.connetionString, sqlCmd);


        }


        private HtmlGenericControl br()
        {

            HtmlGenericControl br = new HtmlGenericControl("br");
            return br;
        }

        private bool isLogedin()
        {


            return Session.SessionID != null && Request.Cookies["userid"] != null && Session["role"] != null
                && Request.Cookies["userid"].Value.ToString().Equals(Session.SessionID.ToString());

        }
    }
   
}