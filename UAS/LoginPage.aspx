<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LoginPage.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-800 h-screen flex items-center justify-center">
    <form id="form1" runat="server" class="bg-white p-8 rounded-lg shadow-lg w-full max-w-md">
        <h2 class="text-3xl font-bold text-center text-gray-800 mb-6">Login</h2>
        
        <asp:Label ID="ErrorMessage" runat="server" CssClass="text-red-500 mb-4 block" Text="" Visible="false"></asp:Label>
        
        <div class="mb-4">
            <label for="email" class="block text-gray-700 font-semibold text-md mb-2">Email</label>
            <asp:TextBox ID="Email" runat="server" placeholder="Enter your email" CssClass="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-600" />
        </div>
        
        <div class="mb-6">
            <label for="password" class="block text-gray-700 font-semibold text-md mb-2">Password</label>
            <asp:TextBox ID="Password" runat="server" TextMode="Password" placeholder="Enter your password" CssClass="w-full p-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-600" />
        </div>
        
        <asp:Button ID="LoginButton" runat="server" Text="Login" OnClick="LoginButtonClick" CssClass="w-full py-3 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-blue-600 transition duration-200" />
        
        <div class="mt-4 text-center">
            <span class="text-gray-600">Don't have an account?</span>
            <a href="RegisterPage.aspx" class="text-indigo-600 font-semibold hover:text-indigo-800">Register here</a>
        </div>
    </form>
</body>
</html>
