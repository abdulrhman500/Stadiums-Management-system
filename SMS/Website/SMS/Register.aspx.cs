using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Stadiums_Management_System
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HttpCookie sessionIdCookie = Request.Cookies["ASP.NET_SessionId"];
            if (sessionIdCookie != null)
            {
                string csessionId = sessionIdCookie.Value;
                Response.Write(csessionId);
            }
            else {
                Response.Write("NO");

            }

        }
    }
}