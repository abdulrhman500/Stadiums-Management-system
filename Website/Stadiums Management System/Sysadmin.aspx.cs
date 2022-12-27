using Microsoft.SqlServer.Server;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
//using System.Windows.Controls;

namespace Stadiums_Management_System
{
    public partial class Sysadmin : System.Web.UI.Page
    {
        static String lastseleceted = null;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (lastseleceted != null)
            {
                HtmlGenericControl div = (HtmlGenericControl)this.FindControl("Addclub");

                if (div == null && lastseleceted != "")
                {
                    // The div element exists

                    Addclub();

                }

            }
            


        }
        void pr(String x) {
            Response.Write(x);
            Response.Write("<br>");

        }

        protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
        {


            ListItem selectedItem = DropDownList1.SelectedItem;

            string selectedValue = selectedItem.Value;

            switch (selectedValue)
            {
                case "1" : Addclub();
                        break;
                case "2":
                    Deleteclub();
                    break;
                case "3":
                    Addstadium();
                    break;
                case "4":
                    Deletestadium();
                    break;
                case "5":
                    Blockfan();
                    break;

                    



            }









        }

        private void Blockfan()
        {
            HtmlGenericControl div = new HtmlGenericControl("div");
            div.ID = "Blockfan";
            Button btn = Createbutton("block_fan");
            btn.Text = "Block Fan";
            btn.Click += new EventHandler(BlockFan_Click);

            div.Controls.Add(Createlabel("fan_nationalid", "Fan National Id "));
            div.Controls.Add(Createtextbox("fannationalid"));
            div.Controls.Add(btn);

            form1.Controls.Add(div);
        }

        
        private void Addstadium()
        {
            HtmlGenericControl div = new HtmlGenericControl("div");
            div.ID = "Addstadium";
            Button btn = Createbutton("add_stadium");
            btn.Text = "Add stadium";
            btn.Click += new EventHandler(AddStadium_Click);

            div.Controls.Add(Createlabel("stadiumN_label", "stadium Name"));
            div.Controls.Add(Createtextbox("stadiumname"));
            div.Controls.Add(Createlabel("stadiumL_label", "Stadium Location"));
            div.Controls.Add(Createtextbox("location"));
            div.Controls.Add(Createlabel("stadiumC_label", "Stadium Capacity"));
            div.Controls.Add(Createtextbox("Capacity"));
            div.Controls.Add(btn);

            form1.Controls.Add(div);
        }

        

        private void Deleteclub()
        {
            HtmlGenericControl div = new HtmlGenericControl("div");
            div.ID = "Deleteclub";
            Button btn = Createbutton("delet_club");
            btn.Text = "Delet Club";
            btn.Click += new EventHandler(DeleteClub_Click);

            div.Controls.Add(Createlabel("clubN_label", "Club Name"));
            div.Controls.Add(Createtextbox("clubname"));
            div.Controls.Add(btn);

            form1.Controls.Add(div);
        }

        

        private void Deletestadium()
        {

            HtmlGenericControl div = new HtmlGenericControl("div");
            div.ID = "Deletestadium";
            Button btn = Createbutton("delet_stadium");
            btn.Click += new EventHandler(DeleteStadium_Click);

            btn.Text = "Delet stadium";
            div.Controls.Add(Createlabel("stadiumN_label", "stadium Name"));
            div.Controls.Add(Createtextbox("stadiumname"));
            div.Controls.Add(btn);

            form1.Controls.Add(div);

        }

        
        private void Addclub() {


            HtmlGenericControl div = new HtmlGenericControl("div");
            div.ID = "Addclub";
            Button btn = Createbutton("add_club");
            btn. Text="Add Club";
            btn.Click += new EventHandler(AddFan_Click);

            div.Controls.Add(Createlabel("clubN_label","Club Name"));
            div.Controls.Add(Createtextbox("clubname"));
            div.Controls.Add(Createlabel("clubL_label", "Club Location"));
           
            div.Controls.Add(Createtextbox("location"));
            div.Controls.Add(btn);

            form1.Controls.Add(div);





        }




        private Label Createlabel(string id,String text)
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
        private LiteralControl br() {
            LiteralControl lineBreak = new LiteralControl("<br>");
            return lineBreak;
        }
        private void AddFan_Click(object sender, EventArgs e)
        {
            // The code that you want to execute when the button is clicked goes here
        }

        private void DeleteStadium_Click(object sender, EventArgs e)
        {
            throw new NotImplementedException();
        }
        private void DeleteClub_Click(object sender, EventArgs e)
        {
            throw new NotImplementedException();
        }

        private void AddStadium_Click(object sender, EventArgs e)
        {
            throw new NotImplementedException();
        }
        private void BlockFan_Click(object sender, EventArgs e)
        {
            throw new NotImplementedException();
        }


    }
}