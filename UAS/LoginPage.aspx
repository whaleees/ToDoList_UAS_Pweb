<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LoginPage.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <h2>Login</h2>
            <asp:Label ID="ErrorMessage" runat="server" CssClass="error-message" Text="" Visible="false"></asp:Label>
            <label for="email">Email</label>
            <asp:TextBox ID="Email" runat="server" placeholder="Enter your email"></asp:TextBox>
            <label for="password">Password</label>
            <asp:TextBox ID="Password" runat="server" TextMode="Password" placeholder="Enter your password"></asp:TextBox>
            <asp:Button ID="LoginButton" runat="server" Text="Login" OnClick="LoginButtonClick" />
        </div>
    </form>
</body>
</html>
