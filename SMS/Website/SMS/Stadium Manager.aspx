<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Stadium Manager.aspx.cs" Inherits="SMS.Stadium_Manager" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" href="./css/bootstrap.css" />
    <title></title>
</head>
<body>
    <figure class="text-center">
        <h1 id ="UserH" runat="server"></h1>

        <div id ="StadiumDiv" runat ="server"></div>

        <hr />

        <form id="form1" runat="server">
            <div>
                <h2>Here are the requests you have received</h2>
                <asp:GridView ID="GridView1" runat="server" HorizontalAlign="Center"></asp:GridView>
            </div>

            <hr /> 

            <div>
                <h2>Here are the pending requests you can accept/reject</h2>
                <asp:GridView ID="GridView2" runat="server" HorizontalAlign="Center">
                  <Columns>
                    <asp:TemplateField HeaderText="Accept Request">
                      <ItemTemplate>
                        <asp:Button ID="Button1" runat="server" Text="Accept Request" OnClick="acceptRequset"/>
                      </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Reject Request">
                      <ItemTemplate>
                        <asp:Button ID="Button2" runat="server" Text="Reject Request" OnClick="rejectRequest"/>
                      </ItemTemplate>
                    </asp:TemplateField>
                  </Columns>
                </asp:GridView>
            </div>

            <asp:Label ID="Label" runat="server" Text="Label"></asp:Label>

            <hr /> 
            

        </form>
    </figure>
</body>
</html>
