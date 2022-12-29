using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMS
{
    public partial class Register : System.Web.UI.Page
    {
        public static int count = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
           

          
            String cmd = "dbo.purchaseTicket";
            
            SqlCommand sqlCmd = new SqlCommand(cmd, null);

            sqlCmd.Parameters.Add("@nationalID", SqlDbType.VarChar).Value = "11";
            sqlCmd.Parameters.Add("@h_clubName", SqlDbType.VarChar).Value = "Roma";
            sqlCmd.Parameters.Add("@g_clubName", SqlDbType.VarChar).Value = "Zamalek";
            sqlCmd.Parameters.Add("@startTime", SqlDbType.DateTime).Value = DateTime.Parse("8/1/2022 8:00:00 PM");


            sqlCmd.CommandType = System.Data.CommandType.StoredProcedure;

            String ret = Login.SqlInsert(Login.connetionString,sqlCmd);
            
        //    Response.Write(ret);
        
        }
        protected void usertype_SelectedIndexChanged(object sender, EventArgs e)
       
        {
            ListItem selectedItem = usertype.SelectedItem;

            string selectedValue = selectedItem.Value;

            switch (selectedValue)
            {
              
                case "1":
                    Sports_Association_Manager();
                    break;
                case "2":
                    Club_Reb();
                    break;
                case "3":
                    stadiumManager();
                    break;
                case "4":
                    fan();
                    break;





            }

        }

        private void fan()
        {


            Response.Redirect("Fan Registration.aspx");



        }

        private void stadiumManager()
        {

            Response.Redirect("Stadium Manager Registration.aspx");
        }

        private void Club_Reb()
        {
            Response.Redirect("Club Representative Registration.aspx");
        }

        private void Sports_Association_Manager()
        {

            Response.Redirect("Sports Association Manager Registration.aspx");

        }

        private void Sysadmin()
        {
            throw new NotImplementedException();
        }

        private bool isLogedin()
        {

            return Session.SessionID != null && Request.Cookies["userid"] != null && Session["role"] != null
                && Request.Cookies["userid"].Value.ToString().Equals(Session.SessionID.ToString());

        }


        private Label Createlabel(string id, String text)
        {
            Label label = new Label();
            label.ID = id;
            label.Text = text;
            return label;
        }
        private TextBox Createtextbox(string id)
        {
            TextBox textBox = new TextBox();
            textBox.ID = id;
            return textBox;

        }

        private Button Createbutton(string id)
        {
            Button button = new Button();
            button.ID = id;
            return button;

        }
        private LiteralControl br()
        {
            LiteralControl lineBreak = new LiteralControl("<br>");
            return lineBreak;
        }

    }
}