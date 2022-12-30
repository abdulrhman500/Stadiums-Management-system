<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="sam.aspx.cs" Inherits="SMS.sam" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div id="new_match">
            <asp:Label ID="add_match_label" runat="server" Text="Add New Match" CssClass="header"></asp:Label>
            <br />
            <br />
            <asp:Label ID="Label1" runat="server" Text="host club"></asp:Label>
            <asp:TextBox ID="new_match_hclub" runat="server" Text="host club"></asp:TextBox>

            <asp:Label ID="Label2" runat="server" Text="guest club"></asp:Label>
            <asp:TextBox ID="new_match_gclub" runat="server" Text="gust club"></asp:TextBox>
            
            <asp:Label ID="Label3" runat="server" Text="start date"></asp:Label>
            <asp:TextBox ID="new_match_start" runat="server" TextMode="Date" CssClass="calender"></asp:TextBox>
            
            <asp:Label ID="hours_label" runat="server" Text="hour:"></asp:Label>
            <asp:TextBox ID="shours" runat="server" Text=""></asp:TextBox>

            
            <asp:Label ID="Label5" runat="server" Text="end date"></asp:Label>
               <asp:TextBox ID="edate" runat="server" TextMode="Date" CssClass="calender"></asp:TextBox>
           
            <asp:Label ID="Label4" runat="server" Text="hour:"></asp:Label>
            <asp:TextBox ID="ehours" runat="server" Text=""></asp:TextBox>
        
            
            
            
            <asp:Button ID="Addnewmatch" runat="server" Text="Add new match" OnClick="Addnewmatch_Click" />
            <asp:Label ID="status_2" runat="server" Text=""></asp:Label>


        </div>
        <br />
        <br />

        <div id="delete_match">
            <asp:Label ID="delet_label" runat="server" Text="Delete Match" CssClass="header"></asp:Label>
            <br />
            <br />

            <asp:Label ID="delete_hclub_label" runat="server" Text="host club"></asp:Label>
            <asp:TextBox ID="delete_hc" runat="server" Text="host club"></asp:TextBox>

            <asp:Label ID="delte_gc_label" runat="server" Text="guest club"></asp:Label>
            <asp:TextBox ID="delet_gc" runat="server" Text="gust club"></asp:TextBox>
            
            <asp:Label ID="delet_date_label" runat="server" Text="date"></asp:Label>
            <asp:TextBox ID="delete_date" runat="server" TextMode="Date" CssClass="calender"></asp:TextBox>
            
            <asp:Label ID="delete_h_label" runat="server" Text="hour:"></asp:Label>
            <asp:TextBox ID="delete_hour" runat="server" Text=""></asp:TextBox>

            <asp:Label ID="Label6" runat="server" Text="date"></asp:Label>
            <asp:TextBox ID="TextBox1" runat="server" TextMode="Date" CssClass="calender"></asp:TextBox>
            
            <asp:Label ID="Label7" runat="server" Text="hour:"></asp:Label>
            <asp:TextBox ID="TextBox2" runat="server" Text=""></asp:TextBox>
            
            <asp:Button ID="deletmatchbtn" runat="server" Text="Delete match" OnClick="deletmatchbtn_Click" />
            <asp:Label ID="status_3" runat="server" Text=""></asp:Label>

        </div>
        <br />
        <br />
        <div id="view_up">
            <asp:Label ID="view_up_label" runat="server" Text="UP Coming Matches"></asp:Label>
            <br />

            <asp:Button ID="view_upcomming_matches" runat="server" Text="Button" OnClick="view_upcomming_matches_Click" />
            <br />
            <br />
            <asp:Label ID="status1" runat="server" Text=""></asp:Label>

            <asp:GridView ID="vew_upcommingmatches" runat="server"></asp:GridView>

        </div>
        <br />
        <br />
        <div id="view_aleady">
            <asp:Label ID="view_aleady_label" runat="server" Text="View Already Played Matches"></asp:Label>
            <br />

            <asp:Button ID="btn_Already_Played" runat="server" Text="Button" OnClick="btn_Already_Played_Click" />
            <br />
            <br />
            <asp:Label ID="status2" runat="server" Text=""></asp:Label>

            <asp:GridView ID="view_already_Played" runat="server"></asp:GridView>

        </div>
        <br />
        <br />

        <div id="pair">
            <asp:Label ID="pair_label" runat="server" Text="View pair of club names who never scheduled to play with each other"></asp:Label>
            <br />

            <asp:Button ID="btn_pair" runat="server" Text="view pair" OnClick="btn_pair_Click" />
            <br/>
            <br/>
            <asp:Label ID="status3" runat="server" Text=""></asp:Label>

            <asp:GridView ID="view_pair" runat="server"></asp:GridView>

        </div>

    </form>
</body>
</html>
