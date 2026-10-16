<%@ Page Language="C#" %>

<!DOCTYPE html>
<html>
<head>
    <title>Login Page</title>
</head>
<body>

<form id="form1" runat="server">

    <h1>Login</h1>

    Username:
    <br />
    <asp:TextBox ID="txtUsername" runat="server"></asp:TextBox>

    <br /><br />

    Password:
    <br />
    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>

    <br /><br />

    <asp:CheckBox ID="chkRemember" runat="server" Text=" Remember Me"></asp:CheckBox>

    <br /><br />

    <asp:Button ID="btnLogin" runat="server" Text="Login" OnClick="btnLogin_Click"></asp:Button>

    <br /><br />

    <asp:Label ID="lblMessage" runat="server"></asp:Label>

</form>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            // Check if Username Cookie exists
            HttpCookie cookie = Request.Cookies["Username"];

            if (cookie != null)
            {
                txtUsername.Text = cookie.Value;
                chkRemember.Checked = true;
            }
        }
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {
        // Check Username
        if (string.IsNullOrWhiteSpace(txtUsername.Text))
        {
            lblMessage.Text = "Please enter Username.";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }

        // Check Password
        if (string.IsNullOrWhiteSpace(txtPassword.Text))
        {
            lblMessage.Text = "Please enter Password.";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }

        // Any username and password are accepted

        // Create Session
        Session["Username"] = txtUsername.Text;
        Session["IsLoggedIn"] = true;

        // Create Cookie if Remember Me is checked
        if (chkRemember.Checked)
        {
            HttpCookie cookie = new HttpCookie("Username");
            cookie.Value = txtUsername.Text;
            cookie.Expires = DateTime.Now.AddDays(7);
            Response.Cookies.Add(cookie);
        }
        else
        {
            // Delete existing cookie
            if (Request.Cookies["Username"] != null)
            {
                HttpCookie cookie = new HttpCookie("Username");
                cookie.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(cookie);
            }
        }

        // Redirect to Default page
        Response.Redirect("Default.aspx");
    }

</script>

</body>
</html>