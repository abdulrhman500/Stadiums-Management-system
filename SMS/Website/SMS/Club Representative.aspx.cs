﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SMS
{
    public partial class Club_Representative : System.Web.UI.Page
    {
        public static string connetionString = WebConfigurationManager.ConnectionStrings["CS_Abdo"].ToString();

        protected void Page_Load(object sender, EventArgs e)
        {
            
        }



    }
}