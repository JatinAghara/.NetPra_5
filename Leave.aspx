<%@ Page Language="C#" %>

<!DOCTYPE html>
<html>
<head>
    <title>Leave Application</title>
</head>
<body>

<form id="form1" runat="server">

    <h1>Leave Application</h1>

    Name:
    <br />
    <asp:TextBox ID="txtName" runat="server"></asp:TextBox>

    <br /><br />

    Roll No:
    <br />
    <asp:TextBox ID="txtRollNo" runat="server"></asp:TextBox>

    <br /><br />

    Leave Date:
    <br />
    <asp:TextBox ID="txtLeaveDate" runat="server" ReadOnly="true"></asp:TextBox>

    <br /><br />

    Reason:
    <br />
    <asp:TextBox ID="txtReason" runat="server" TextMode="MultiLine" Rows="5" Columns="40"></asp:TextBox>

    <br /><br />

    <asp:Button ID="btnSubmit" runat="server" Text="Submit Leave" OnClick="btnSubmit_Click"></asp:Button>

    <br /><br />

    <asp:Label ID="lblMessage" runat="server"></asp:Label>

    <!-- Submitted Information -->

    <asp:Panel ID="pnlResult" runat="server" Visible="false">

        <hr />

        <h2>Leave Application Details</h2>

        Name:
        <asp:Label ID="lblName" runat="server"></asp:Label>

        <br /><br />

        Roll No:
        <asp:Label ID="lblRollNo" runat="server"></asp:Label>

        <br /><br />

        Leave Date:
        <asp:Label ID="lblDate" runat="server"></asp:Label>

        <br /><br />

        Reason:
        <asp:Label ID="lblReason" runat="server"></asp:Label>

        <br /><br />

        <!-- Logout Button -->

        <asp:Button ID="btnLogout" runat="server" Text="Logout" OnClick="btnLogout_Click"></asp:Button>

    </asp:Panel>

</form>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        // Check if user is logged in
        if (Session["IsLoggedIn"] == null)
        {
            Response.Redirect("Login.aspx");
        }

        if (!IsPostBack)
        {
            // Get selected date from Default.aspx
            if (Session["LeaveDate"] != null)
            {
                DateTime date = Convert.ToDateTime(Session["LeaveDate"]);
                txtLeaveDate.Text = date.ToString("dd-MM-yyyy");
            }
            else
            {
                Response.Redirect("Default.aspx");
            }
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        // Check Name
        if (string.IsNullOrWhiteSpace(txtName.Text))
        {
            lblMessage.Text = "Please enter Name.";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }

        // Check Roll No
        if (string.IsNullOrWhiteSpace(txtRollNo.Text))
        {
            lblMessage.Text = "Please enter Roll No.";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }

        // Check Reason
        if (string.IsNullOrWhiteSpace(txtReason.Text))
        {
            lblMessage.Text = "Please enter Reason.";
            lblMessage.ForeColor = System.Drawing.Color.Red;
            return;
        }

        // Store information in Session
        Session["LeaveName"] = txtName.Text;
        Session["RollNo"] = txtRollNo.Text;
        Session["Reason"] = txtReason.Text;

        // Store Leave Name in Cookie
        HttpCookie cookie = new HttpCookie("LeaveName");
        cookie.Value = txtName.Text;
        cookie.Expires = DateTime.Now.AddDays(7);
        Response.Cookies.Add(cookie);

        // Display information
        lblName.Text = txtName.Text;
        lblRollNo.Text = txtRollNo.Text;
        lblDate.Text = txtLeaveDate.Text;
        lblReason.Text = txtReason.Text;

        // Show result
        pnlResult.Visible = true;

        lblMessage.Text = "Leave submitted successfully.";
        lblMessage.ForeColor = System.Drawing.Color.Green;
    }

    protected void btnLogout_Click(object sender, EventArgs e)
    {
        // Clear all Session data
        Session.Clear();
        Session.Abandon();

        // Delete Username Cookie
        if (Request.Cookies["Username"] != null)
        {
            HttpCookie cookie = new HttpCookie("Username");
            cookie.Expires = DateTime.Now.AddDays(-1);
            Response.Cookies.Add(cookie);
        }

        // Redirect to Login page
        Response.Redirect("Login.aspx");
    }

</script>

</body>
</html>