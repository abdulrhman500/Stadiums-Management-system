<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Club_Representative_Regestration.aspx.cs" Inherits="SMS.Club_Representative_Regestration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        #info {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }

        form {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        div {
            text-align: center;
        }


        input {
            display: flex;
            flex-direction: column;
        }

            input[type="text"] {
                width: 280px;
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
                margin-left: 0%;
            }

        .err {
            font-family: Arial, sans-serif;
            font-size: 12px;
            color: red;
            align-content: center;
            text-align: center;
        }

        #status {
            font-family: Arial, sans-serif;
            font-size: 16px;
            color: red;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <div id="info">
            <asp:Label ID="Name" runat="server" Text="Name"></asp:Label>
            <asp:TextBox ID="Name_Text" runat="server"></asp:TextBox>
            <asp:Label ID="name_status" runat="server" Text="" CssClass="err"></asp:Label>

            <br />

            <asp:Label ID="Username" runat="server" Text="Username"></asp:Label>
            <asp:TextBox ID="Username_text" runat="server"></asp:TextBox>
            <asp:Label ID="Username_status" runat="server" Text="" CssClass="err"></asp:Label>

            <br />
            <asp:Label ID="Password" runat="server" Text="Password"></asp:Label>
            <asp:TextBox ID="Password_text" runat="server"></asp:TextBox>
            <asp:Label ID="pass_status" runat="server" Text="" CssClass="err"></asp:Label>

            <br />

            <asp:Label ID="club" runat="server" Text="club name"></asp:Label>
            <asp:TextBox ID="club_text" runat="server"></asp:TextBox>
            <asp:Label ID="club_status" runat="server" Text="" CssClass="err"></asp:Label>

            <br />
            <asp:Label ID="status" runat="server" Text=""></asp:Label>
            <br />

            <asp:Button ID="Register" runat="server" Text="Register as Club Representative" OnClick="Register_Click" />
            <br />


        </div>

    </form>
</body>
</html>
