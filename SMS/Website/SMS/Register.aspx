<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="SMS.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
 <link rel="stylesheet" href="./css/styl8e.css" />
    <title>Register</title>
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

        #SelectRole {
            text-align: center;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }

        #Label1 {
         font-family: Arial, sans-serif;
            font-size: 16px;

        }
        #usertype {
            width: auto;
            height: auto;
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
    <form id="form1" runat="server">
        <div id="SelectRole" runat="server">
            <asp:Label ID="Label1" runat="server" Text="Register AS"></asp:Label>
            <asp:DropDownList ID="usertype" runat="server" AutoPostBack="True" OnSelectedIndexChanged="usertype_SelectedIndexChanged">
                
                <asp:ListItem Value="0" Selected="True">Select a Role</asp:ListItem>
                <asp:ListItem Value="1">Sports Association Manager</asp:ListItem>
                <asp:ListItem Value="2">Club Representative</asp:ListItem>
                <asp:ListItem Value="3"> Stadium Manager</asp:ListItem>
                <asp:ListItem Value="4">Fan </asp:ListItem>


            </asp:DropDownList>




        </div>
 <div id="info" runat="server">

     


 </div>
        
    </form>
</body>
</html>
