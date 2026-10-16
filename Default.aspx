<%@ Page Language="C#" %>

<!DOCTYPE html>
<html>
<head>
    <title>Academic Calendar</title>
</head>
<body>

<form id="form1" runat="server">

    <h1>Academic Calendar</h1>

    <asp:Label ID="lblWelcome" runat="server"></asp:Label>

    <br /><br />

    <asp:Calendar ID="Calendar1" runat="server"></asp:Calendar>

    <br />

    <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click"></asp:Button>

    <br /><br />

    <asp:Label ID="lblMessage" runat="server" ForeColor="Red"></asp:Label>

</form>

<script runat="server">

    protected void Page_Load(object sender, EventArgs e)
    {
        // Check Login Session
        if (Session["IsLoggedIn"] == null)
        {
            Response.Redirect("Login.aspx");
        }

        if (!IsPostBack)
        {
            // Display logged-in username
            if (Session["Username"] != null)
            {
                lblWelcome.Text = "Welcome, " + Session["Username"].ToString();
            }
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        // Check if date is selected
        if (Calendar1.SelectedDate == DateTime.MinValue)
        {
            lblMessage.Text = "Please select a date.";
            return;
        }

        // Store selected date in Session
        Session["LeaveDate"] = Calendar1.SelectedDate;

        // Open Leave.aspx
        Response.Redirect("Leave.aspx");
    }

</script>

</body>
</html>