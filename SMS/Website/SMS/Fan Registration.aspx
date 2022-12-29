<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Fan Registration.aspx.cs" Inherits="SMS.Fan_Registration" %>

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
                margin-left: 15%;
            }



        #status {
            font-family: Arial, sans-serif;
            font-size: 16px;
            color: red;
        }

        .err {
            font-family: Arial, sans-serif;
            font-size: 12px;
            color: red;
            align-content:center;
            text-align:center;
        }

        .calender {
            width: 300px;
            height: 35px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
            color: #555;
            padding: 6px 12px;
            box-shadow: inset 0 1px 1px rgba(0,0,0,0.075);
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <div id="info">
            <asp:Label ID="Name" runat="server" Text="Name"></asp:Label>
            <asp:TextBox ID="Name_Text" runat="server" ></asp:TextBox>
            <asp:Label ID="name_status" runat="server" Text="" CssClass="err"></asp:Label>

            <br />

            <asp:Label ID="Username" runat="server" Text="Username"></asp:Label>
            <asp:TextBox ID="Username_text" runat="server"></asp:TextBox>
            <asp:Label ID="Username_status" runat="server" Text="" CssClass="err"></asp:Label>

            <br />
            <asp:Label ID="Password" runat="server" Text="Password"></asp:Label>
            <asp:TextBox ID="Password_text" runat="server" ></asp:TextBox>
            <asp:Label ID="pass_status" runat="server" Text="" CssClass="err"></asp:Label>

            <br />

            <asp:Label ID="National_ID" runat="server" Text="National ID"></asp:Label>
            <asp:TextBox ID="National_ID_text" runat="server" ></asp:TextBox>
            <asp:Label ID="id_status" runat="server" Text="" CssClass="err"></asp:Label>

            <br />

            <asp:Label ID="Phone" runat="server" Text="Phone"></asp:Label>
            <asp:TextBox ID="Phone_text" runat="server" ></asp:TextBox>
            <asp:Label ID="phone_status" runat="server" Text="" CssClass="err"></asp:Label>

            <br />

            <asp:Label ID="Address" runat="server" Text="Address"></asp:Label>
            <asp:TextBox ID="Address_text" runat="server"></asp:TextBox>
            <asp:Label ID="address_status" runat="server" Text="" CssClass="err"></asp:Label>

            <br />

            <asp:Label ID="birth" runat="server" Text="Birth Date"></asp:Label>

            <asp:TextBox ID="BirthDate" runat="server" TextMode="Date" CssClass="calender"></asp:TextBox>
            <asp:Label ID="bith_status" runat="server" Text="" CssClass="err"></asp:Label>

            <br />
            <asp:Label ID="status" runat="server" Text=""></asp:Label>


            <asp:Button ID="Register" runat="server" Text="Register as fan" OnClick="Register_Click" />
            <br />





        </div>
    </form>
</body>
</html>
