<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ClubRepresentative.aspx.cs" Inherits="Sports_League_Managament_System.ClubRepresentative.Club_Representative"  EnableViewState="true"%>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" href="../css/bootstrap-lumen.css" />
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
                <asp:GridView CssClass="table"  ID="upcomingMatches" runat="server" HorizontalAlign="Center"></asp:GridView>
            </div>

             <hr /> 

            <div>
                <h2>The available stadiums on a specific date</h2>
                <label for="appt">Select a time:</label>
                <input type="datetime-local" id="Datetime1" runat ="server"/>
                <asp:Button ID="Button1" runat="server" Text="Submit" OnClick="viewAvailableStadiums" />
                <asp:GridView CssClass="table"  ID="availableStadiums" runat="server" HorizontalAlign="Center"></asp:GridView>
            </div>

            <hr />

            <div>
                <h2>Make a Request for a match you host</h2>
                <asp:GridView CssClass="table"  ID="UnassignedMatches" runat="server" HorizontalAlign="Center">
                    <Columns>
                        <asp:TemplateField HeaderText="Host Request">
                          <ItemTemplate>
                            <input class="form-check-input" name = "matchSelected" type ="radio" value=""/>
                          </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <br />

                <div id ="StadiumRequest" runat="server"></div>
                <br />
                
                <asp:Button class="btn btn-success" ID="Button2" runat="server" Text="Submit" OnClick="makeHostRequest"/>
                <br /><br />

                <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
            </div>
        </form>

    </figure>


    <script>
        const radioButtonGroup = document.getElementsByName("matchSelected");

        for (let i = 0; i < radioButtonGroup.length; i++) 
            radioButtonGroup[i].value = i; 
        
    </script>
</body>
</html>
