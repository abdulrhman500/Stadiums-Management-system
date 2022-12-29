<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Purchase.aspx.cs" Inherits="Stadiums_Management_System.Purchase" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        .hidden {
           /**/ 
        }
        body {
            background: #ABCDEF;
            font-family: Assistant, sans-serif;
            display: flex;
            min-height: 90vh;
        }
           #IdConfirm {
            text-align: center;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            color: white;
            background: #136a8a;
            background: -webkit-linear-gradient(to right, #267871, #136a8a);
            background: linear-gradient(to right, #267871, #136a8a);
            margin: auto;
            box-shadow: 0px 2px 10px rgba(0, 0, 0, 0.2), 0px 10px 20px rgba(0, 0, 0, 0.3), 0px 30px 60px 1px rgba(0, 0, 0, 0.5);
            border-radius: 8px;
            padding: 50px;
        }
        #nationalID {
            border: none;
            background: none;
            box-shadow: 0px 2px 0px 0px white;
           
            color: white;
            font-size: 1em;
            outline: none;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div id="hiddenDiv"  runat="server">
            <asp:Label ID="Done" runat="server" Text="Please select a ticket"></asp:Label>
           
            <asp:Button ID="ba" runat="server" Text="Back to Fan Page" OnClick="back_click" />
          
        </div>
    </form>
</body>
</html>
