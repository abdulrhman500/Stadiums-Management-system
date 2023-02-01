    <%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StadiumManager.aspx.cs" Inherits="Sports_League_Managament_System.StadiumManager.Stadium_Manager" EnableEventValidation="false"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" href="../css/bootstrap-lumen.css" />
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
                <asp:GridView CssClass="table"  ID="GridView1" runat="server" HorizontalAlign="Center"></asp:GridView>
            </div>

            <hr /> 

            <div>
                <h2>Here are the pending requests you can accept/reject</h2>
                <asp:GridView CssClass="table"  ID="GridView2" runat="server" HorizontalAlign="Center">
                  <Columns>
                    <asp:TemplateField HeaderText="Accept Request">
                      <ItemTemplate>
                        <asp:Button class="btn btn-primary btn-sm" ID="Button1" runat="server" Text="Accept Request" OnClick="acceptRequset"/>
                      </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Reject Request">
                      <ItemTemplate>
                        <asp:Button class="btn btn-primary btn-sm" ID="Button2" runat="server" Text="Reject Request" OnClick="rejectRequest"/>
                      </ItemTemplate>
                    </asp:TemplateField>
                  </Columns>
                </asp:GridView>
            </div>

            <asp:Label ID="Label" runat="server" Text=""></asp:Label>
            <hr /> 
            

        </form>
    </figure>
</body>
</html>
