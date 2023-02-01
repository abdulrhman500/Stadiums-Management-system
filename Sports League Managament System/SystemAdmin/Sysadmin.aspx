<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sysadmin.aspx.cs" Inherits="Sports_League_Managament_System.SystemAdmin.Sysadmin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">

        <div>
            <asp:Label ID="add_match_label" runat="server" Text="Add New Club" CssClass="header"></asp:Label>
            <br /><br />
            
            <asp:Label ID="Label1" runat="server" Text="Club name"></asp:Label>
            <asp:TextBox ID="clubn" runat="server" Text=""></asp:TextBox>

            <asp:Label ID="Location_L" runat="server" Text="Location"></asp:Label>
            <asp:TextBox ID="location" runat="server" Text=""></asp:TextBox>
            <asp:Button ID="btn_club" runat="server" Text="Add Club"  OnClick="btn_club_Click"/>
        </div>

        <br/>
        <br/>

        <div>
            <asp:Label ID="Label2" runat="server" Text="Delete a Club" CssClass="header"></asp:Label>
            <br /><br />

            <asp:Label ID="Label3" runat="server" Text="Club name"></asp:Label>
            <asp:TextBox ID="delete_club" runat="server" Text=""></asp:TextBox>

            <asp:Button ID="btn_deleteclub" runat="server" Text="Delete Club"  OnClick="btn_deleteclub_Click"/>
        </div>

        <br/>
        <br/>

        <div>
             <asp:Label ID="Label4" runat="server" Text="Add New Stadium" CssClass="header"></asp:Label>
             <br /><br />

            <asp:Label ID="Label5" runat="server" Text="Stadium name"></asp:Label>
            <asp:TextBox ID="sname" runat="server" Text=""></asp:TextBox>

            <asp:Label ID="Label6" runat="server" Text="Location"></asp:Label>
            <asp:TextBox ID="slocation" runat="server" Text=""></asp:TextBox>

            <asp:Label ID="Label7" runat="server" Text="Capacity"></asp:Label>
            <input type ="number" ID="cap" runat="server" Text=""></input>

            <asp:Button ID="add_std" runat="server" Text="Add stadium"  OnClick="add_std_Click"/>
        </div>

        <br/>
        <br/>

        <div>
            <asp:Label ID="Label8" runat="server" Text="Delete a stadium" CssClass="header"></asp:Label>
            <br /><br />

            <asp:Label ID="Label9" runat="server" Text="Stadium name"></asp:Label>
            <asp:TextBox ID="std_name" runat="server" Text=""></asp:TextBox>
           
            <asp:Button ID="btn_delete_std" runat="server" Text="Delete stadium"  OnClick="btn_delete_std_Click"/>
        </div>

        <br/>
        <br />

        <div>
            <asp:Label ID="Label10" runat="server" Text="Block Fan" CssClass="header"></asp:Label>
            <br />
            <br />
            <asp:Label ID="Label11" runat="server" Text="National id"></asp:Label>
            <input type ="number" ID="TextBox1" runat="server" Text=""></asp:TextBox>
            
            <asp:Button ID="btn_block" runat="server" Text="block Fan"  OnClick="btn_block_Click"/>
        </div>

        <br/>
        <br />

    </form>
</body>
</html>
