<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Club Representative.aspx.cs" Inherits="SMS.Club_Representative" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" href="./css/bootstrap.css" />
    <title></title>
<style>

</style>
</head>
<body>

    <figure class="text-center">

        <h1 id ="UserH" runat="server"></h1>

        <div id ="ClubDiv" runat ="server"></div>

        <hr />
        <form id="form1" runat="server">
            <div>
                <h2>Here are the upcoming matches for your club</h2>
                <asp:GridView ID="GridView1" runat="server" HorizontalAlign="Center"></asp:GridView>
            </div>

             <hr /> 

            <div>
                <h2>The available stadiums on a specific date</h2>
                <l for="appt">Select a time:</l abel>
                <input type="datetime-local" id="Datetime" onchange ="getDateTime()"/>
                <asp:HiddenField ID="HiddenField1" runat="server" />
                <asp:Button ID="Button2" runat="server" Text="Submit" OnClick="viewAvailableStadiums" />
                <asp:GridView ID="GridView2" runat="server" HorizontalAlign="Center"></asp:GridView>
            </div>

            <hr />

            <div>
                <h2>Make a Host Request</h2>
                <input type="datetime-local" id="DateTime2" onchange="getDateTime()"/>
                <asp:HiddenField ID="HiddenField2" runat="server" />
                <div  id ="StadiumRequest" runat="server"></div>
                    <asp:Button ID="Button1" runat="server" Text="Submit" OnClick="makeHostRequest"/>
                    <br />
                    <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
            </div>
        </form>

    </figure>

    <script>
            function getDateTime() {
        // Get the current date and time
                var currentDate = new Date();
                var dateString = document.getElementById("Datetime").value;

            // Set the value of the hidden field
            document.getElementById("HiddenField1").value = dateString;
    }
    </script>
</body>
</html>
