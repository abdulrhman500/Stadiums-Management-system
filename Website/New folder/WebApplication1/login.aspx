<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="WebApplication1.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:Label ID="username_label" runat="server" Text="username"></asp:Label>
            <input id="username" type="text" runat="server" />
            <br>
            <asp:Label ID="password_label" runat="server" Text="password"></asp:Label>
            <input id="password" type="password" runat="server" />
            <br>
            <asp:Button ID="btn1" runat="server" Text="Login" OnClick="btn1_click" /> </div>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1">
            <Columns>
                <asp:BoundField DataField="host_club" HeaderText="host_club" SortExpression="host_club" />
                <asp:BoundField DataField="guest_club" HeaderText="guest_club" SortExpression="guest_club" />
                <asp:BoundField DataField="name" HeaderText="name" SortExpression="name" />
                <asp:BoundField DataField="starting_time" HeaderText="starting_time" SortExpression="starting_time" />
            </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:DBProjectConnectionString %>" SelectCommand="SELECT * FROM [allTickets]"></asp:SqlDataSource>
    </form>
</body>
</html>
