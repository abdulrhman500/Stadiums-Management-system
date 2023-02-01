<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Sports_League_Managament_System.Login.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" href="../css/style.css" />
    <title>Login</title>
    <style>
        form {
            text-align: center;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }

        div {
            text-align: center;
        }

        #Username, #Password {
            width: 140px;
            height: 18px;
            margin-left: 10px;
            font-family: Arial, sans-serif;
            font-size: 16px;
            background-color: white;
            color: black;
            border: 2px solid #ccc;
            border-radius: 4px;
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
            padding: 12px 20px;
        }

    </style>
</head>
<body>
    <form id="form1" runat="server" class="form">



        <div class="login" spellcheck="True" style="font-family: 'Javanese Text'; font-style: inherit">
            <div>
                <h1>Login </h1>
                <br/>
            </div>

            <asp:Label ID="Username_label" runat="server">Username  </asp:Label>
            <input id="Username" type="text" runat="server" />
            <br/><br/>
            <asp:Label ID="Label1" runat="server">Password</asp:Label>
            <input id="Password" type="password" runat="server" />
            <br/>

            <asp:Label ID="status" runat="server" Font-Size="Small" Font-Bold="False" ForeColor="Red"></asp:Label>

            <br/>

            <asp:Button Class="btn " ID="submit" runat="server" Text="Login " OnClick="MyButtonClickHandler" Height="30px" Width="70px" />
            <br/>
            <a id ="Register_link" href="/Register/Register.aspx"  target="_blank" rel="noopener noreferrer" font-size: 17px;>Not registered yet?</a>
          

        </div>
    </form>
</body>
</html>
