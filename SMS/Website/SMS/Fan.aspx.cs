using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Stadiums_Management_System;
using System.Drawing;
using System.Web.UI.HtmlControls;

namespace Stadiums_Management_System
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
            container.Controls.Add(button);

        }
    }
    public partial class Fan : System.Web.UI.Page
    {
        int C = 0;
        private  DataTable table = null;
        protected void Page_Load(object sender, EventArgs e)
        {

            table = loadTable();

            if (table != null)
            {
                //TicketTable.AutoGenerateColumns = true;
                //TicketTable.AutoGenerateSelectButton = true;
                //TicketTable.EnablePersistedSelection = true;
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

            


            if (e.CommandName.Equals("btn_clicked"))
            {
                int row = int.Parse(e.CommandArgument.ToString());

                if (table != null)
                {


                    String host = table.Rows[row][0].ToString();
                    String guest = table.Rows[row][1].ToString();
                    DateTime date = DateTime.Now;
                    String stadium = table.Rows[row][3].ToString();


                    //    purchase();
                    Session["host"] = host;
                    Session["guest"] = guest;
                    Session["date"] = date.ToString();
                    Session["stadium"] = stadium;
                    Purshase.PurshaseDone = false;
                    Response.Redirect("Purshase.aspx");

                   // AddConfirmationDiv(host, guest, date, stadium);


                }



            }




           
        }
      

      
        private DataTable loadTable() {

            String cmd = "select * from availableMatchesToAttend (@date)";
            //string cmd = "select * from club";
 
           SqlCommand scmd = new SqlCommand(cmd, null);
           scmd.CommandType = CommandType.Text;
           DateTime dt = DateTime.Now;
           scmd.Parameters.Add("@date", SqlDbType.DateTime).Value = dt;
            return Login.SqlTable(Login.connetionString, scmd);
        }
        private void pr(String x)
        {

           
            Response.Write(x);
            Response.Write("<br>");


        }


    }
}