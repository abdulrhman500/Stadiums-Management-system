<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Fan.aspx.cs" Inherits="Sports_League_Managament_System.Fan.Fan" EnableEventValidation="false"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" href="../css/bootstrap-lumen.css" />
    <style>
        
    </style>
    <title>Fan Dashboard</title>
</head>
<body>
    <figure class="text-center">
        <form id="form1" runat="server">
            <div>
                <asp:Label ID="Message2" runat="server" Text="Choose the starting date of the scheduled matches"></asp:Label>
                <br /><br />
                <input type="datetime-local" id="matchDate1" runat ="server" />
                <br />
                <asp:Button class="btn btn-success" ID="show_Match" runat="server" Text="show Matchs" OnClick="show_Match_Click" />
                <br /><br />
                <asp:GridView CssClass="table"  ID="MatchesTable" runat="server" HorizontalAlign="Center">
                    <Columns>
                        <asp:TemplateField HeaderText="Purchase">
                            <ItemTemplate>
                            <asp:Button class="btn btn-primary btn-sm" ID="Button1" runat="server" Text="Purchase" OnClick="purchaseTicket"/>
                            </ItemTemplate>
                        </asp:TemplateField>
                        </Columns>
                </asp:GridView>

                <asp:Label ID="Label" runat="server" Text=""></asp:Label>

                <hr /> 
                <div>
                    <asp:Label ID="Message" runat="server" Text="Here are the tickets you have purchased"></asp:Label>
                    <br /><br />
                    <asp:GridView CssClass="table"  ID="TicketTable" runat="server" HorizontalAlign="Center">
                    </asp:GridView>
                    <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                </div>
            </div>
        </form>
    </figure>
</body>

</html>
