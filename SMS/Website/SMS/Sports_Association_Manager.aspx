<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Sports_Association_Manager.aspx.cs" Inherits="SMS.Sports_Association_Manager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
                        <asp:DropDownList ID="DropDownList1" runat="server" OnSelectedIndexChanged="DropDownList1_SelectedIndexChanged" AutoPostBack="True">
                <asp:ListItem Value="0"> Choose Function</asp:ListItem>  
                <asp:ListItem Value="1"> Add a new match</asp:ListItem>
                <asp:ListItem Value="2"> delete a match </asp:ListItem>
                <asp:ListItem Value="3"> View All upcoming matches</asp:ListItem>
                <asp:ListItem Value="4">  View already played matches</asp:ListItem>
                <asp:ListItem Value="5"> View pair of club  </asp:ListItem>

            </asp:DropDownList>
            <br />

        </div>
    </form>
</body>
</html>
