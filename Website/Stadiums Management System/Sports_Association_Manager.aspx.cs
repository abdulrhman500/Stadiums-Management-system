using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace Stadiums_Management_System
{
    public partial class Sports_Association_Manager : System.Web.UI.Page
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

                    Addmatch();

                }

            }

        }
    
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {


        ListItem selectedItem = DropDownList1.SelectedItem;

        string selectedValue = selectedItem.Value;

        switch (selectedValue)
        {
            case "1":
                Addmatch();
                break;
            case "2":
                Deletematch();
                break;
            case "3":
                Upcomingmatches();
                break;
            case "4":
                Playedmatches();
                break;
            case "5":
                Pairclub();
                break;





        }









    }

    private void Pairclub()
    {
            HtmlGenericControl div = new HtmlGenericControl("div");
            div.ID = "Pairclub";
            Button btn = Createbutton("Pair_club");
            btn.Text = "Pairclub";
            div.Controls.Add(btn);
            form1.Controls.Add(div);
        }

    private void Playedmatches()
    {
            HtmlGenericControl div = new HtmlGenericControl("div");
            div.ID = "Playedmatches";
            Button btn = Createbutton("Played_matches");
            btn.Text = "Played Matches";
            div.Controls.Add(btn);
            form1.Controls.Add(div);
        }

    private void Upcomingmatches()
    {
        HtmlGenericControl div = new HtmlGenericControl("div");
        div.ID = "Upcomingmatches";
        Button btn = Createbutton("Upcoming_matches");
        btn.Text = "Upcoming Matches";
        div.Controls.Add(btn);
        form1.Controls.Add(div);
    }

    private void Deletematch()
    {

            HtmlGenericControl div = new HtmlGenericControl("div");
            div.ID = "Deletematch";
            Button btn = Createbutton("delete_match");
            btn.Text = "Delete Match";
            div.Controls.Add(Createlabel("clubNG_label", "Geust Club Name"));
            div.Controls.Add(Createtextbox("GeustClubName"));
            div.Controls.Add(Createlabel("clubLH_label", "Host Club Location"));
            div.Controls.Add(Createtextbox("Host Club Location"));
            div.Controls.Add(Createlabel("start_time", "Start Time"));
            div.Controls.Add(Createtextbox("starttime"));
            div.Controls.Add(Createlabel("end_time", "End time"));
            div.Controls.Add(Createtextbox("endtime"));

            div.Controls.Add(btn);

            form1.Controls.Add(div);

        }

    private void Addmatch()
    {


        HtmlGenericControl div = new HtmlGenericControl("div");
        div.ID = "Addmatch";
        Button btn = Createbutton("add_match");
        btn.Text = "Add Match";
        div.Controls.Add(Createlabel("clubNG_label", "Geust Club Name"));
        div.Controls.Add(Createtextbox("GeustClubName"));
        div.Controls.Add(Createlabel("clubLH_label", "Host Club Location"));
        div.Controls.Add(Createtextbox("Host Club Location"));
        div.Controls.Add(Createlabel("start_time", "Start Time"));
        div.Controls.Add(Createtextbox("starttime"));
        div.Controls.Add(Createlabel("end_time", "End time"));
        div.Controls.Add(Createtextbox("endtime"));

            div.Controls.Add(btn);

        form1.Controls.Add(div);





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
