using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["Username"] == null)
        {
            String routeUrl = VirtualPathUtility.ToAbsolute("~/login");
            Response.Redirect(routeUrl);
        }
        else
        {
            WelcomeLabel.Text = "Welcome, " + Session["Username"].ToString() + " " + Session["UserID"].ToString();
        }
    }

    protected void LogoutButton_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        String routeUrl = VirtualPathUtility.ToAbsolute("~/login");
        Response.Redirect(routeUrl);
    }
}
