<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ToDoList.aspx.cs"
Inherits="_Default" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head runat="server">
    <title>To-Do List</title>
    <link
      href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css"
      rel="stylesheet" />
  </head>
  <body class="bg-gray-100 overflow-x-hidden">
    <form id="form1" runat="server">
      <div class="w-screen h-24 bg-gray-800 py-2 px-12 flex justify-between items-center">
          <h2 class="font-bold text-2xl text-white">TodoList</h2>
          <button onclick="openModal('logoutModal'); event.preventDefault();" class="px-4 py-2 rounded-lg bg-indigo-600 text-white font-semibold cursor-pointer hover:bg-indigo-700">Logout</button>
      </div>
      <div class="container mx-auto p-20">
        <asp:Label ID="WelcomeLabel" runat="server" Text="" CssClass="text-4xl font-bold"></asp:Label>

        <div class="flex justify-between items-center mt-2">
            <h2 class="text-2xl font-bold">Your Todos</h2>
            <!-- Add Todo Button -->
            <button
              type="button"
              class="bg-indigo-600 hover:bg-indigo-700 text-white px-4 py-2 rounded mb-6 min-w-fit font-semibold"
              onclick="openModal('addTodoModal')">
              Add Todo
            </button>
        </div>

        <div class="flex space-x-6">
          <!-- Pending Column -->
          <div class="w-1/3 bg-white p-4 rounded-lg shadow-lg">
            <h2 class="text-xl font-semibold mb-4 text-center">Pending</h2>
            <asp:Repeater ID="PendingRepeater" runat="server">
              <ItemTemplate>
                <div
                  class="todo-card bg-gray-200 p-4 rounded-lg mb-4 cursor-pointer hover:bg-gray-300"
                  onclick="showDetails('<%# Eval("TodoID") %>','<%# Eval("Title") %>', '<%# Eval("Description") %>', '<%# Eval("DueDate") %>', '<%# Eval("Status") %>', '<%# Eval("Priority") %>')">
                  <h3 class="font-semibold text-lg"><%# Eval("Title") %></h3>
                </div>
              </ItemTemplate>
            </asp:Repeater>
          </div>

          <!-- In Progress Column -->
          <div class="w-1/3 bg-white p-4 rounded-lg shadow-lg">
            <h2 class="text-xl font-semibold mb-4 text-center">In Progress</h2>
            <asp:Repeater ID="InProgressRepeater" runat="server">
              <ItemTemplate>
                <div
                  class="todo-card bg-gray-200 p-4 rounded-lg mb-4 cursor-pointer hover:bg-gray-300"
                  onclick="showDetails('<%# Eval("TodoID") %>','<%# Eval("Title") %>', '<%# Eval("Description") %>', '<%# Eval("DueDate") %>', '<%# Eval("Status") %>', '<%# Eval("Priority") %>')">
                  <h3 class="font-semibold text-lg"><%# Eval("Title") %></h3>
                </div>
              </ItemTemplate>
            </asp:Repeater>
          </div>

          <!-- Completed Column -->
          <div class="w-1/3 bg-white p-4 rounded-lg shadow-lg">
            <h2 class="text-xl font-semibold mb-4 text-center">Completed</h2>
            <asp:Repeater ID="CompletedRepeater" runat="server">
              <ItemTemplate>
                <div
                  class="todo-card bg-gray-200 p-4 rounded-lg mb-4 cursor-pointer hover:bg-gray-300"
                  onclick="showDetails('<%# Eval("TodoID") %>', '<%# Eval("Title") %>', '<%# Eval("Description") %>', '<%# Eval("DueDate") %>', '<%# Eval("Status") %>', '<%# Eval("Priority") %>')">
                  <h3 class="font-semibold text-lg"><%# Eval("Title") %></h3>
                </div>
              </ItemTemplate>
            </asp:Repeater>
          </div>
        </div>

        <!-- Add To-Do Modal -->
        <div
          id="addTodoModal"
          class="fixed inset-0 bg-gray-800 bg-opacity-50 hidden flex items-center justify-center z-50">
          <div class="bg-white p-6 rounded-lg max-w-md w-full">
            <div class="flex justify-between items-center">
              <h3 class="text-lg font-semibold text-gray-800 font-semibold">Add New Todo</h3>
              <button
                class="text-gray-600"
                onclick="closeModal('addTodoModal')">
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  class="h-5 w-5"
                  fill="none"
                  viewBox="0 0 24 24"
                  stroke="currentColor">
                  <path
                    stroke-linecap="round"
                    stroke-linejoin="round"
                    stroke-width="2"
                    d="M6 18L18 6M6 6l12 12"></path>
                </svg>
              </button>
            </div>
            <div class="mt-4">
              <asp:TextBox
                ID="TitleTextBox"
                runat="server"
                placeholder="Title"
                CssClass="form-input w-full p-2 mb-4 border rounded-lg"></asp:TextBox>
              <asp:TextBox
                ID="DescriptionTextBox"
                runat="server"
                TextMode="MultiLine"
                placeholder="Description"
                CssClass="form-input w-full p-2 mb-4 border rounded-lg h-32"></asp:TextBox>
              <asp:TextBox
                ID="DueDateTextBox"
                runat="server"
                TextMode="Date"
                CssClass="form-input w-full p-2 mb-4 border rounded-lg"></asp:TextBox>
              <asp:DropDownList
                ID="StatusDropDown"
                runat="server"
                CssClass="form-input w-full p-2 mb-4 border rounded-lg">
                <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
                <asp:ListItem
                  Text="In Progress"
                  Value="In Progress"></asp:ListItem>
                <asp:ListItem Text="Completed" Value="Completed"></asp:ListItem>
              </asp:DropDownList>
              <asp:DropDownList
                ID="PriorityDropDown"
                runat="server"
                CssClass="form-input w-full p-2 mb-4 border rounded-lg">
                <asp:ListItem Text="Low" Value="Low"></asp:ListItem>
                <asp:ListItem Text="Medium" Value="Medium"></asp:ListItem>
                <asp:ListItem Text="High" Value="High"></asp:ListItem>
              </asp:DropDownList>
            <button type="submit" runat="server" onserverclick="CreateToDoButton_Click" class="bg-indigo-600 hover:bg-indigo-700 w-full px-12 py-2 text-white font-semibold rounded-md">Add Todo</button>
            </div>
          </div>
        </div>

        <!-- Modal for Todo Details -->
        <div id="todoDetailsModal" class="fixed inset-0 bg-gray-800 bg-opacity-50 hidden flex items-center justify-center z-50">
            <div class="bg-white p-6 rounded-lg max-w-md w-full shadow-lg">
                <div class="flex justify-between items-center mb-4">
                    <h3 class="text-2xl font-semibold text-gray-900 truncate" id="todoTitle">Title</h3>
                    <button class="text-gray-600" onclick="closeModal('todoDetailsModal')">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                        </svg>
                    </button>
                </div>

                <div class="space-y-3 text-gray-800">
                    <div>
                        <p id="todoDescription" class="text-md text-gray-700"></p>
                    </div>
                    <div>
                        <strong>Due Date</strong> 
                        <p id="todoDueDate" class="text-md"></p>
                    </div>
                    <div>
                        <strong>Status</strong> 
                        <p id="todoStatus" class="text-md"></p>
                    </div>
                    <div>
                        <strong>Priority</strong> 
                        <p id="todoPriority" class="text-md"></p>
                    </div>
                </div>

                <div class="mt-6 flex gap-4 justify-end">
                    <button class="bg-indigo-600 hover:bg-indigo-700 text-white py-2 px-4 rounded transition duration-200" onclick="openEditModal()">Edit</button>
                    <button class="bg-red-500 text-white py-2 px-4 rounded hover:bg-red-600 transition duration-200" onclick="confirmDelete()">Delete</button>
                </div>
            </div>
        </div>


        <!-- Modal for Edit Todo -->
        <div id="editTodoModal" class="fixed inset-0 bg-gray-800 bg-opacity-50 hidden flex items-center justify-center z-50">
            <div class="bg-white p-6 rounded-lg max-w-md w-full">
                <div class="flex justify-between items-center">
                    <h3 class="text-lg font-semibold text-gray-800">Edit Todo</h3>
                    <button class="text-gray-600" onclick="closeModal('editTodoModal')">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                        </svg>
                    </button>
                </div>
                <div class="mt-4">
                    <asp:TextBox
                        ID="EditID"
                        runat="server"
                        Text="9"
                        CssClass="hidden"></asp:TextBox>
                  <asp:TextBox
                    ID="EditTitle"
                    runat="server"
                    placeholder="Title"
                    CssClass="form-input w-full p-2 mb-4 border rounded-lg"></asp:TextBox>
                  <asp:TextBox
                    ID="EditDesc"
                    runat="server"
                    TextMode="MultiLine"
                    placeholder="Description"
                    CssClass="form-input w-full p-2 mb-4 border rounded-lg h-32"></asp:TextBox>
                  <asp:TextBox
                    ID="EditDue"
                    runat="server"
                    TextMode="Date"
                    CssClass="form-input w-full p-2 mb-4 border rounded-lg"></asp:TextBox>
                    <asp:DropDownList
                      ID="EditStatus"
                      runat="server"
                      CssClass="form-input w-full p-2 mb-4 border rounded-lg">
                      <asp:ListItem Text="Pending" Value="Pending"></asp:ListItem>
                      <asp:ListItem
                        Text="In Progress"
                        Value="In Progress"></asp:ListItem>
                      <asp:ListItem Text="Completed" Value="Completed"></asp:ListItem>
                    </asp:DropDownList>
                    <asp:DropDownList
                      ID="EditPriority"
                      runat="server"
                      CssClass="form-input w-full p-2 mb-4 border rounded-lg">
                      <asp:ListItem Text="Low" Value="Low"></asp:ListItem>
                      <asp:ListItem Text="Medium" Value="Medium"></asp:ListItem>
                      <asp:ListItem Text="High" Value="High"></asp:ListItem>
                    </asp:DropDownList>
                <button type="submit" runat="server" onserverclick="EditToDoButton_Click" class="bg-indigo-600 hover:bg-indigo-700 w-full px-12 py-2 text-white font-semibold rounded-md">Save Changes</button>
                </div>
            </div>
        </div>

        <!-- Confirmation for Delete -->
        <div id="confirmDeleteModal" class="fixed inset-0 bg-gray-800 bg-opacity-50 hidden flex items-center justify-center z-50">
            <div class="bg-white p-6 rounded-lg max-w-sm w-full shadow-lg">
                <div class="flex justify-between items-center mb-4">
                    <h3 class="text-2xl font-bold text-gray-800">Confirm Delete</h3>
                    <button class="text-gray-600" onclick="closeModal('confirmDeleteModal')">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                        </svg>
                    </button>
                </div>

                <div class="mt-4 text-gray-800">
                    <p class="text-md">Are you sure you want to delete this todo? This action cannot be undone.</p>
                </div>

                <div class="mt-6 flex justify-end gap-4">
                    <asp:TextBox ID="DeleteID" runat="server" CssClass="hidden"></asp:TextBox>
                    <button class="bg-gray-800 text-white py-2 px-4 rounded hover:bg-gray-700 transition duration-200" onclick="closeModal('confirmDeleteModal')">Cancel</button>
                    <button class="bg-red-500 text-white py-2 px-4 rounded hover:bg-red-600 transition duration-200" runat="server" onserverclick="DeleteToDoButton_Click">Delete</button>
                </div>
            </div>
        </div>

        <div id="logoutModal" class="fixed inset-0 bg-gray-800 bg-opacity-50 hidden flex items-center justify-center z-50">
            <div class="bg-white p-6 rounded-lg max-w-sm w-full shadow-lg">
                <div class="flex justify-between items-center mb-4">
                    <h3 class="text-2xl font-bold text-gray-800">Logout</h3>
                    <button class="text-gray-600" onclick="closeModal('logoutModal')">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"></path>
                        </svg>
                    </button>
                </div>

                <div class="mt-4 text-gray-800">
                    <p class="text-md">Are you sure you want to logout?</p>
                </div>

                <div class="mt-6 flex justify-end gap-4">
                    <asp:TextBox ID="TextBox1" runat="server" CssClass="hidden"></asp:TextBox>
                    <button class="bg-gray-800 text-white py-2 px-4 rounded hover:bg-gray-700 transition duration-200" onclick="closeModal('logoutModal')">Cancel</button>
                    <button class="bg-indigo-600 text-white py-2 px-4 rounded hover:bg-indigo-700 transition duration-200" runat="server" onserverclick="LogoutButton_Click">Logout</button>
                </div>
            </div>
        </div>

      <asp:Label ID="MessageLabel" Text="" runat="server" CssClass="mt-8 font-semibold text-lg"/>
      </div>
    </form>
    

    <script>
        function formatToDate(dateString) {
            const parts = dateString.split(' ')[0].split('/');
            return `${parts[2]}-${parts[1]}-${parts[0]}`;
        }


        function formatDate(dateString) {
            const parts = dateString.split(' ')[0].split('/');
            const date = new Date(`${parts[1]}/${parts[0]}/${parts[2]} 00:00:00`);
            const options = { day: '2-digit', month: 'short', year: 'numeric' };
            return date.toLocaleDateString('en-GB', options);
        }

      function openModal(modalId) {
        document.getElementById(modalId).classList.remove("hidden");
      }

      function closeModal(modalId) {
        document.getElementById(modalId).classList.add("hidden");
      }

        function showDetails(id, title, desc, due, status, priority) {
            document.getElementById("todoTitle").textContent = title;
            document.getElementById("todoDescription").textContent = desc;
            document.getElementById("todoDueDate").textContent = formatDate(due);
            document.getElementById("todoStatus").textContent = status;
            document.getElementById("todoPriority").textContent = priority;

            document.getElementById('<%= EditID.ClientID %>').value = id;
            document.getElementById('<%= EditTitle.ClientID %>').value = title;
            document.getElementById('<%= EditDesc.ClientID %>').value = desc;
            document.getElementById('<%= EditDue.ClientID %>').value = formatToDate(due);
            document.getElementById('<%= EditStatus.ClientID %>').value = status;
            document.getElementById('<%= EditPriority.ClientID %>').value = priority;

            document.getElementById('<%= DeleteID.ClientID %>').value = id;



            openModal('todoDetailsModal');
        }

        function openEditModal() {
            closeModal('todoDetailsModal');
            openModal('editTodoModal');
            event.preventDefault();
        }

        function saveChanges() {
            alert("Changes Saved");
            closeModal('editTodoModal');
        }

        function confirmDelete() {
            closeModal('todoDetailsModal');
            openModal('confirmDeleteModal');
            event.preventDefault();
        }
    </script>
  </body>
</html>
