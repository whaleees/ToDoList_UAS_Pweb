<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Homepage.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Home</title>
</head>
<body>
    <h1>HOME!!!!!</h1>
    
    <!-- Display Welcome Message -->
    <asp:Label ID="WelcomeLabel" runat="server" Text=""></asp:Label>

    <!-- Form for logout -->
    <form id="logoutForm" runat="server">
        <asp:Button ID="LogoutButton" runat="server" Text="Logout" OnClick="LogoutButton_Click" />
    </form>
</body>
</html>
