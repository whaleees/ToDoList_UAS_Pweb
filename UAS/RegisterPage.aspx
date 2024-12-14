<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RegisterPage.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Register</title>
</head>
<body>
    <form id="form1" runat="server">
        <div class="register-container">
            <h2>Register</h2>
            <asp:Label ID="MessageLabel" runat="server" CssClass="error-message" Text="" Visible="false"></asp:Label>

            <!-- Username -->
            <label for="username">Username</label>
            <asp:TextBox ID="Username" runat="server" placeholder="Enter your username" required></asp:TextBox>

            <!-- Email -->
            <label for="email">Email</label>
            <asp:TextBox ID="Email" runat="server" placeholder="Enter your email" type="email" required></asp:TextBox>

            <!-- Password -->
            <label for="password">Password</label>
            <asp:TextBox ID="Password" runat="server" TextMode="Password" placeholder="Enter your password" 
                pattern="^(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{8,}$" 
                title="Password must be at least 8 characters long, and include a number and a special character." required>
            </asp:TextBox>

            <!-- Register Button -->
            <asp:Button ID="RegisterButton" runat="server" Text="Register" OnClick="RegisterButton_Click" />
        </div>
    </form>
</body>
</html>
