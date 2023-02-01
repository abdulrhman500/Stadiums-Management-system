using System;
using System.Net;
using System.Security.Policy;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Sports_League_Managament_System.Register
{
    public partial class Register : System.Web.UI.Page
    {
        private static String selectedUserType;
        private String input_name;
        private String user_name;
        private String user_password;

        protected void usertype_SelectedIndexChanged(object sender, EventArgs e)
        {
            selectedUserType = usertype.SelectedItem.Value;

            Shared1.Style.Clear();
            SelectRole.Style.Value = "display: none";
            if (selectedUserType == "cr" || selectedUserType == "sm")
            {
                StadiumORClub.Style.Clear();
                StadiumORClubLabel.Text = selectedUserType == "cr" ? "Club Name" : "Stadium Name";
                Fan.Style.Value = "display: none";
            } 
            if (selectedUserType == "fan")
            {
                Fan.Style.Clear();
                StadiumORClub.Style.Value = "display: none";
            }

            Shared2.Style.Clear();

        }

        protected void Register_Click(object sender, EventArgs e)
        {
            input_name = NameText.Text;
            user_name = UsernameText.Text;
            user_password = PasswordText.Value;

            String[] inputs = { input_name, user_name, user_password };
            bool valid = validateInput(inputs);
            if (!valid)
            {
                status.Text = "fields must be between 1 and 20 characters";
                return;
            }

            bool isSuccess = false;
            if (selectedUserType == "cr")
                isSuccess = AddRepresentative();
            if (selectedUserType == "sm")
                isSuccess = AddStadiumManager();
            if (selectedUserType == "sam")
                isSuccess = AddSAM();
            if (selectedUserType == "fan")
                isSuccess = AddFan();

            if (isSuccess)
                Response.Redirect("/Login/Login.aspx");
            else
                status.Text = "Already exits or internal error happened";

        }

        private bool AddSAM()
        {
            String procedureName = "addAssociationManager";
            string[] parameters = { "@uname", "@username", "@pASsword" };
            Object[] values = { input_name, user_name, user_password };

            bool isSuccess = Utils.execProcedure(procedureName, parameters, values);

            return isSuccess;
        }

        private bool AddRepresentative()
        {
            String clubName = StadiumORClubText.Text;

            String[] inputs = { clubName };
            bool valid = validateInput(inputs);
            if (!valid)
            {
                status.Text = "fields must be between 1 and 20 characters";
                return false;
            }

            String procedureName = "addRepresentative";
            string[] parameters = { "@uname", "@cname", "@pASsword", "@username" };
            Object[] values = { input_name, clubName, user_password, user_name };

            bool isSuccess = Utils.execProcedure(procedureName, parameters, values);

            return isSuccess;
        }

        private bool AddStadiumManager()
        {
            String stadiumName = StadiumORClubText.Text;

            String[] inputs = { stadiumName };
            bool valid = validateInput(inputs);
            if (!valid)
            {
                status.Text = "fields must be between 1 and 20 characters";
                return false;
            }

            String procedureName = "addStadiumManager";
            string[] parameters = { "@name", "@stadium_name", "@pASsword", "@username" };
            Object[] values = { input_name, stadiumName, user_password, user_name };

            bool isSuccess = Utils.execProcedure(procedureName, parameters, values);

            return isSuccess;
        }

        private bool AddFan()
        {
            String id = NationalIDText.Value;
            String address = AddressText.Text;
            String phone = PhoneText.Value;
            DateTime date = DateTime.Parse(BirthText.Value);
            string dt = date.ToString("yyyy-MM-dd HH:mm:ss");

            String[] inputs = { id, address, phone };
            bool valid = validateInput(inputs);
            if (!valid)
            {
                status.Text = "fields must be between 1 and 20 characters";
                return false;
            }

            String procedureName = "addFan";
            string[] parameters = { "@name", "@username", "@pASsword", "@national_id", "@birth_dath", "@address", "@phone" };
            Object[] values = { input_name, user_name, user_password, id, dt, address, int.Parse(phone) };

            bool isSuccess = Utils.execProcedure(procedureName, parameters, values);

            return isSuccess;
        }

        private bool validateInput(String[] inputs)
        {
            foreach (String input in inputs)
                if (String.IsNullOrWhiteSpace(input) || input.Length > 20)
                    return false;
            return true;
        }

    }
}