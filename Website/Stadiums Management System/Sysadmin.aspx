<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sysadmin.aspx.cs" Inherits="Stadiums_Management_System.Sysadmin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

<style>
    Div1 {
    
    background-color :aqua;
    }

</style>

</head>
<body id="body" runat="server">
    <form id="form1" runat="server">
        <div>
            <asp:DropDownList ID="DropDownList1" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="True">
                <asp:ListItem Value="0"> Choose Function</asp:ListItem>  
                <asp:ListItem Value="1"> Add a new club</asp:ListItem>
                <asp:ListItem Value="2">Delete a club</asp:ListItem>
                <asp:ListItem Value="3">Add a new stadium</asp:ListItem>
                <asp:ListItem Value="4">Delete a stadium</asp:ListItem>
                <asp:ListItem Value="5">Block a fan </asp:ListItem>

            </asp:DropDownList>
            <br />


        </div>
        
    </form>
</body>
</html>
