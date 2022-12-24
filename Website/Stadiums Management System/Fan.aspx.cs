using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Stadiums_Management_System;

namespace Stadiums_Management_System
{
    public partial class Fan : System.Web.UI.Page
    {
        
        protected void Page_Load(object sender, EventArgs e)
        {

            loadTable();
        
        
        }





        private void loadTable() {

            String cmd = "select * from availableMatchesToAttend (@date)";
            SqlCommand scmd = new SqlCommand(cmd, null);
            scmd.CommandType = CommandType.Text;
            DateTime dt = DateTime.Now;
            scmd.Parameters.Add("@date", SqlDbType.DateTime).Value = dt;
            DataTable table = Login.SqlTable(Login.connetionString, scmd);
            if (table != null)
            {



            }
        }


    }
}