<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="sam.aspx.cs" Inherits="Sports_League_Managament_System.SportsAssociationManager.sam" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <asp:Label ID="message" runat="server" Text=""></asp:Label>
    <br /><br />
    <form id="form1" runat="server">
        <div id="new_match">
            <asp:Label ID="add_match_label" runat="server" Text="Add New Match" CssClass="header"></asp:Label>
            <br />
            <br />
            <asp:Label ID="Label1" runat="server" Text="host club"></asp:Label>
            <asp:TextBox ID="new_match_hclub" runat="server" Text="host club"></asp:TextBox>

            <asp:Label ID="Label2" runat="server" Text="guest club"></asp:Label>
            <asp:TextBox ID="new_match_gclub" runat="server" Text="guest club"></asp:TextBox>
            
            <asp:Label ID="Label3" runat="server" Text="start date"></asp:Label>
            <input type="datetime-local" id="new_match_start" runat ="server" />
            
            
            <asp:Label ID="Label5" runat="server" Text="end date"></asp:Label>
            <input type="datetime-local" id="edate" runat ="server" />
           
            <asp:Button ID="Addnewmatch" runat="server" Text="Add new match" OnClick="Addnewmatch_Click" />
            


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
            
            <asp:Button ID="deletmatchbtn" runat="server" Text="Delete match" OnClick="deletmatchbtn_Click" />

        </div>
        <br />
        <br />
        <div id="view_up">
            <asp:Label ID="view_up_label" runat="server" Text="UP Coming Matches"></asp:Label>
            <br />

            <asp:Button ID="view_upcomming_matches" runat="server" Text="Button" OnClick="view_upcomming_matches_Click" />
            <br />
            <br />

            <asp:GridView CssClass="table"  ID="vew_upcommingmatches" runat="server"></asp:GridView>

        </div>
        <br />
        <br />
        <div id="view_aleady">
            <asp:Label ID="view_aleady_label" runat="server" Text="View Already Played Matches"></asp:Label>
            <br />

            <asp:Button ID="btn_Already_Played" runat="server" Text="Button" OnClick="btn_Already_Played_Click" />
            <br />
            <br />

            <asp:GridView CssClass="table"  ID="view_already_Played" runat="server"></asp:GridView>

        </div>
        <br />
        <br />

        <div id="pair">
            <asp:Label ID="pair_label" runat="server" Text="Pairs of clubs who never played with each other"></asp:Label>
            <br />

            <asp:Button ID="btn_pair" runat="server" Text="view pair" OnClick="btn_pair_Click" />
            <br/>
            <br/>

            <asp:GridView CssClass="table"  ID="view_pair" runat="server"></asp:GridView>

        </div>

    </form>
</body>
</html>
