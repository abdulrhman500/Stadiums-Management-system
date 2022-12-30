<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Fan.aspx.cs" Inherits="SMS.Fan" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <style>
        body {
            font-family: Assistant, sans-serif;
            display: flex;
            flex-direction: column;
            min-height: 90vh;

        }

        table {
            text-align: center;
            position: absolute;
            top: 25%;
            left: 50%;
            transform: translate(-50%, -10%);
        }



        form {
            display: flex;
            flex-direction: column;
                        text-align: center;
            align-items: center;
            justify-content: center;
         
        }

        div {
         
            }


        input {
            display: flex;
            flex-direction: column;
        }

            input[type="text"] {
                width: 320px;
                height: 30px;
                padding: 12px 20px;
                margin-bottom: 3px;
                box-sizing: border-box;
                border: 2px solid #ccc;
                border-radius: 4px;
                box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
            }

            input[type="submit"] {
                font-family: Arial, sans-serif;
                font-size: 16px;
                background-color: #4caf50;
                color: white;
                border: none;
                border-radius: 4px;
                box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
                padding: 12px 20px;
                text-align: center;
                align-content: center;
                align-items: center;
                
                }
        #show_Match {
        margin-left:25%;
        }


        #Title {
            text-align: center;
            text-decoration-color: red;
        }

        .calender {
            width: 300px;
            height: 55px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
            color: #555;
            padding: 6px 12px;
            box-shadow: inset 0 1px 1px rgba(0,0,0,0.075);
        }
    </style>
    <title>Fan Home</title>
</head>
<body>
    <form id="form1" runat="server">



        <div>
            <asp:TextBox ID="matchDate" runat="server" TextMode="Date" CssClass="calender"></asp:TextBox>
            <asp:Button ID="show_Match" runat="server" Text="show Matchs" OnClick="show_Match_Click" />
        </div>
        <div>
            <asp:GridView ID="TicketTable" runat="server" OnRowCommand="GridView1_RowCommand" BackColor="White" BorderColor="#999999" BorderStyle="Solid" BorderWidth="1px" CellPadding="3" ForeColor="Black" GridLines="Vertical">
                <AlternatingRowStyle BackColor="#CCCCCC" />
                <FooterStyle BackColor="#CCCCCC" />
                <HeaderStyle BackColor="Black" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                <SelectedRowStyle BackColor="#000099" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#808080" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#383838" />
            </asp:GridView>
            <br />

        </div>

    </form>
</body>

</html>
