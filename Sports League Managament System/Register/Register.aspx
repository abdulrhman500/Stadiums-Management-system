<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="Sports_League_Managament_System.Register.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
 <link rel="stylesheet" href="..\css\bootstrap-lumen.css" />
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
            input[type="password"] {
                width: 280px;
                height: 30px;
                padding: 12px 20px;
                margin-bottom: 3px;
                box-sizing: border-box;
                border: 2px solid #ccc;
                border-radius: 4px;
                box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
            }
            input[type="number"] {
                width: 280px;
                height: 30px;
                padding: 12px 20px;
                margin-bottom: 3px;
                box-sizing: border-box;
                border: 2px solid #ccc;
                border-radius: 4px;
                box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);

            }
            input[type="datetime-local"] {
                width: 280px;
                margin-bottom: 3px;
                box-sizing: border-box;
                border: 2px solid #ccc;
                border-radius: 4px;

            }
            
    </style>
</head>
<body>

    <form id="form1" runat="server">

        <div id="SelectRole" runat="server">

            <asp:Label ID="Label1" runat="server" Text="Register As"></asp:Label>
            <asp:DropDownList ID="usertype" runat="server" AutoPostBack="True" OnSelectedIndexChanged="usertype_SelectedIndexChanged">
                <asp:ListItem Value="0" Selected="True">Select a Role</asp:ListItem>
                <asp:ListItem Value="sam">Sports Association Manager</asp:ListItem>
                <asp:ListItem Value="cr">Club Representative</asp:ListItem>
                <asp:ListItem Value="sm">Stadium Manager</asp:ListItem>
                <asp:ListItem Value="fan">Fan</asp:ListItem>
            </asp:DropDownList>

        </div>

        <div id ="info">
             <div id="Shared1" style = "display: none" runat="server">
                <asp:Label ID="Name" runat="server" Text="Name"></asp:Label>
                <asp:TextBox ID="NameText" runat="server"></asp:TextBox>
                <br />

                <asp:Label ID="Username" runat="server" Text="Username"></asp:Label>
                <asp:TextBox ID="UsernameText" runat="server"></asp:TextBox>
                <br />

                <asp:Label ID="Password" runat="server" Text="Password"></asp:Label>
                 <input type="password" id="PasswordText" runat ="server"/>
                <br />
            </div>

            <div id="StadiumORClub" runat="server" style = "display: none">
                <asp:Label ID="StadiumORClubLabel" runat="server" Text=""></asp:Label>
                <asp:TextBox ID="StadiumORClubText" runat="server"></asp:TextBox>
            </div>

            <div id="Fan" runat="server" style = "display: none">
                <asp:Label ID="NationalID" runat="server" Text="National ID"></asp:Label>
                <input type="number" id="NationalIDText" runat ="server"/>
                <br />

                <asp:Label ID="Phone" runat="server" Text="Phone number"></asp:Label>
               <input type="number" id="PhoneText" runat ="server"/>
                <br />

                <asp:Label ID="Address" runat="server" Text="Address"></asp:Label>
                <asp:TextBox ID="AddressText" runat="server"></asp:TextBox>
                <br />

                <asp:Label ID="Birth" runat="server" Text="Birth Date"></asp:Label>
                <input type="datetime-local" id="BirthText" runat ="server"/>
            </div>

            <div id="Shared2" runat="server" style = "display: none">
                <br />

                <asp:Button ID="RegisterButton" class="btn btn-primary" runat="server" Text="Register" OnClick="Register_Click" />
                <br />
            </div>
            <br /><br />
            <asp:Label ID="status" runat="server" Text=""></asp:Label>
        </div>

    </form>
</body>
</html>
