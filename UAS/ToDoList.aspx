<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ToDoList.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>To-Do List</title>
</head>
<body>
    <form id="form1" runat="server" class="form-container">
        <h2>Create a New To-Do</h2>
        <asp:Label ID="MessageLabel" runat="server" Text="" Visible="false"></asp:Label>

        <label for="title">Title</label>
        <asp:TextBox ID="TitleTextBox" runat="server" placeholder="Enter task title" required></asp:TextBox>

        <label for="description">Description</label>
        <asp:TextBox ID="DescriptionTextBox" runat="server" TextMode="MultiLine" placeholder="Enter task description"></asp:TextBox>

        <label for="dueDate">Due Date</label>
        <asp:TextBox ID="DueDateTextBox" runat="server" TextMode="Date"></asp:TextBox>

        <label for="status">Status</label>
        <asp:DropDownList ID="StatusDropDown" runat="server">
            <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
            <asp:ListItem Text="In Progress" Value="In Progress"></asp:ListItem>
            <asp:ListItem Text="Completed" Value="Completed"></asp:ListItem>
        </asp:DropDownList>

        <label for="priority">Priority</label>
        <asp:DropDownList ID="PriorityDropDown" runat="server">
            <asp:ListItem Text="Low" Value="Low"></asp:ListItem>
            <asp:ListItem Text="Medium" Value="Medium"></asp:ListItem>
            <asp:ListItem Text="High" Value="High"></asp:ListItem>
        </asp:DropDownList>

        <button type="submit" runat="server" onserverclick="CreateToDoButton_Click">Create To-Do</button>
    </form>
</body>
</html>
