using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SMS;
using System.Drawing;
using System.Web.UI.HtmlControls;
using System.Web.Configuration;

namespace SMS
{
    public class GridViewButtonTemplate : ITemplate
    {
        private string buttonID;
        public static int count = 0;

        public GridViewButtonTemplate(string buttonID)
        {
            this.buttonID = buttonID;
        }

        public void InstantiateIn(Control container)
        {
            Button button = new Button();
            button.ID = buttonID;
            button.Text = "Purchase Ticket";
            button.CommandName = "btn_clicked";
            button.CommandArgument = (count++)+"";
            button.BorderColor = Color.Red;
            //button.Click += show_Match_Click;
            container.Controls.Add(button);

        }

       
    }
    public partial class Fan : System.Web.UI.Page
    {
       // int C = 0;
        private  DataTable table = null;
        static bool visible = false;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!isLogedin())
                Response.Redirect("Login.aspx");

            Response.Write(sender.ToString()+" <br> "+e.GetType().FullName);

            table = loadTable();

            if (table != null)
            {

                GridViewButtonTemplate.count = 0;
                TemplateField templateField = new TemplateField();

                templateField.ItemTemplate = new GridViewButtonTemplate("Button");
                TicketTable.Columns.Add(templateField);


                TicketTable.DataSource = table;
                TicketTable.DataBind();



            }

        }

  
        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {

            Response.Write("djjjjjjjjjjjjjjjjjjjjjjjjj");
//            Response.Redirect("Login.aspx");

            if (e.CommandName.Equals("btn_clicked"))
            {
                int row = int.Parse(e.CommandArgument.ToString());
                Response.Write("<br>djjjjjjjjjjjjjjjj22222222222222222222222222222222222222222222222222222222222");


                if (table != null)
                {


                    String host = table.Rows[row][0].ToString();
                    String guest = table.Rows[row][1].ToString();
                    DateTime date = DateTime.Now;
                    String stadium = table.Rows[row][3].ToString();


                    Session["host"] = host;
                    Session["guest"] = guest;
                    Session["date"] = date.ToString();
                    Session["stadium"] = stadium;
                    Purchase.PurchaseDone = false;
                    Response.Redirect("Purchase.aspx");

                   


                }



            }




           
        }



        private DataTable loadTable()
        {

            String cmd = "select * from availableMatchesToAttend (@date)";
            
            SqlCommand scmd = new SqlCommand(cmd, null);
            scmd.CommandType = CommandType.Text;
            DateTime dt = DateTime.Now;
            if (matchDate.Text != "")
                dt = DateTime.Parse(matchDate.Text);
            scmd.Parameters.Add("@date", SqlDbType.DateTime).Value = dt;
            return Login.SqlTable(Login.connetionString, scmd);
        }
        private void pr(String x)
        {

           
            Response.Write(x);
            Response.Write("<br>");


        }
        

        private bool isLogedin()
        {
            

            return Session.SessionID != null && Request.Cookies["userid"] != null && Session["role"] != null
                && Request.Cookies["userid"].Value.ToString().Equals(Session.SessionID.ToString());

        }

        public void show_Match_Click(object sender, EventArgs e)
        {


            table = loadTable();

            if (table != null)
            {

                //GridViewButtonTemplate.count = 0;
                //TemplateField templateField = new TemplateField();

                //templateField.ItemTemplate = new GridViewButtonTemplate("Button");
                //TicketTable.Columns.Add(templateField);


                TicketTable.DataSource = table;
                TicketTable.DataBind();



            }

        }
    }
}