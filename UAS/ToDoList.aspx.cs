using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;

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
            WelcomeLabel.Text = "Welcome, " + Session["Username"].ToString() + "!";
        }
        MessageLabel.Visible = false;

        LoadTodos();
    }

    protected void LogoutButton_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        String routeUrl = VirtualPathUtility.ToAbsolute("~/login");
        Response.Redirect(routeUrl);
    }

    protected void CreateToDoButton_Click(object sender, EventArgs e)
    {
        string title = TitleTextBox.Text.Trim();
        string description = DescriptionTextBox.Text.Trim();
        string dueDate = DueDateTextBox.Text.Trim();
        string status = StatusDropDown.SelectedValue;
        string priority = PriorityDropDown.SelectedValue;
        string userId = Session["UserID"] as string;

        if (string.IsNullOrEmpty(title))
        {
            ShowMessage("Title is required.", false);
            return;
        }

        if (string.IsNullOrEmpty(status) || string.IsNullOrEmpty(priority))
        {
            ShowMessage("Status and Priority are required.", false);
            return;
        }

        if (string.IsNullOrEmpty(userId))
        {
            ShowMessage("User is not logged in.", false);
            return;
        }

        string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            try
            {
                conn.Open();

                string insertQuery = "INSERT INTO Todos (Title, Description, DueDate, Status, Priority, UserID) VALUES (@Title, @Description, @DueDate, @Status, @Priority, @UserID)";
                using (SqlCommand cmd = new SqlCommand(insertQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@Title", title);
                    cmd.Parameters.AddWithValue("@Description", string.IsNullOrEmpty(description) ? DBNull.Value : (object)description);
                    cmd.Parameters.AddWithValue("@DueDate", string.IsNullOrEmpty(dueDate) ? DBNull.Value : (object)dueDate);
                    cmd.Parameters.AddWithValue("@Status", status);
                    cmd.Parameters.AddWithValue("@Priority", priority);
                    cmd.Parameters.AddWithValue("@UserID", userId);

                    cmd.ExecuteNonQuery();
                    ShowMessage("Todo created successfully!", true);

                    String routeUrl = VirtualPathUtility.ToAbsolute("~/");
                    Response.Redirect(routeUrl);

                    // Clear the form
                    TitleTextBox.Text = string.Empty;
                    DescriptionTextBox.Text = string.Empty;
                    DueDateTextBox.Text = string.Empty;
                    StatusDropDown.SelectedIndex = 0;
                    PriorityDropDown.SelectedIndex = 0;
                }
            }
            catch (Exception ex)
            {
                ShowMessage("An error occurred while creating the Todo. Please try again.", false);
                System.Diagnostics.Debug.WriteLine("Error: " + ex.Message);
            }
        }
    }

    protected void EditToDoButton_Click(object sender, EventArgs e)
    {
        string todoID = EditID.Text;
        string title = EditTitle.Text.Trim();
        string description = EditDesc.Text.Trim();
        string dueDate = EditDue.Text.Trim();
        string status = EditStatus.SelectedValue;
        string priority = EditPriority.SelectedValue;
        string userId = Session["UserID"] as string;

        if (string.IsNullOrEmpty(title))
        {
            ShowMessage("Title is required.", false);
            return;
        }

        if (string.IsNullOrEmpty(status) || string.IsNullOrEmpty(priority))
        {
            ShowMessage("Status and Priority are required.", false);
            return;
        }

        if (string.IsNullOrEmpty(userId))
        {
            ShowMessage("User is not logged in.", false);
            return;
        }

        string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            try
            {
                conn.Open();

                string query = "UPDATE Todos SET Title = @Title, Description = @Description, DueDate = @DueDate, Status = @Status, Priority = @Priority WHERE TodoID = @TodoID";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Title", title);
                    cmd.Parameters.AddWithValue("@Description", string.IsNullOrEmpty(description) ? DBNull.Value : (object)description);
                    cmd.Parameters.AddWithValue("@DueDate", string.IsNullOrEmpty(dueDate) ? DBNull.Value : (object)dueDate);
                    cmd.Parameters.AddWithValue("@Status", status);
                    cmd.Parameters.AddWithValue("@Priority", priority);
                    cmd.Parameters.AddWithValue("@TodoID", todoID);

                    cmd.ExecuteNonQuery();
                    ShowMessage("Todo edited successfully!", true);

                    String routeUrl = VirtualPathUtility.ToAbsolute("~/");
                    Response.Redirect(routeUrl);

                    // Clear the form
                    TitleTextBox.Text = string.Empty;
                    DescriptionTextBox.Text = string.Empty;
                    DueDateTextBox.Text = string.Empty;
                    StatusDropDown.SelectedIndex = 0;
                    PriorityDropDown.SelectedIndex = 0;
                }
            }
            catch (Exception ex)
            {
                ShowMessage("An error occurred while editing the Todo. Please try again.", false);
                System.Diagnostics.Debug.WriteLine("Error: " + ex.Message);
            }
        }
    }

    protected void DeleteToDoButton_Click(object sender, EventArgs e)
    {
        string todoID = DeleteID.Text;
        string userId = Session["UserID"].ToString();


        if (string.IsNullOrEmpty(userId))
        {
            ShowMessage("User is not logged in.", false);
            return;
        }

        string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            try
            {
                conn.Open();

                string query = "DELETE FROM Todos WHERE TodoID = @TodoID";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {

                    cmd.Parameters.AddWithValue("@TodoID", todoID);

                    cmd.ExecuteNonQuery();
                    ShowMessage("Todo deleted successfully!", true);

                    String routeUrl = VirtualPathUtility.ToAbsolute("~/");
                    Response.Redirect(routeUrl);
                }
            }
            catch (Exception ex)
            {
                ShowMessage("An error occurred while editing the Todo. Please try again.", false);
                System.Diagnostics.Debug.WriteLine("Error: " + ex.Message);
            }
        }
    }



    private void LoadTodos()
    {
        string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            try
            {
                conn.Open();

                string userId = Session["UserID"] as string;
                if (string.IsNullOrEmpty(userId))
                {
                    Response.Write("User is not logged in.");
                    return;
                }

                string selectQuery = @"
                    SELECT TodoID, Title, Description, DueDate, Status, Priority 
                    FROM Todos 
                    WHERE UserID = @UserID AND Status = @Status
                    ORDER BY 
                        CASE Priority
                            WHEN 'High' THEN 1
                            WHEN 'Medium' THEN 2
                            WHEN 'Low' THEN 3
                            ELSE 4
                        END";


                using (SqlCommand cmd = new SqlCommand(selectQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    cmd.Parameters.AddWithValue("@Status", "Pending");

                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        adapter.Fill(dt);

                        PendingRepeater.DataSource = dt;
                        PendingRepeater.DataBind();
                    }
                }


                using (SqlCommand cmd = new SqlCommand(selectQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    cmd.Parameters.AddWithValue("@Status", "In Progress");

                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        adapter.Fill(dt);

                        InProgressRepeater.DataSource = dt;
                        InProgressRepeater.DataBind();
                    }
                }

                using (SqlCommand cmd = new SqlCommand(selectQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    cmd.Parameters.AddWithValue("@Status", "Completed");

                    using (SqlDataAdapter adapter = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        adapter.Fill(dt);

                        CompletedRepeater.DataSource = dt;
                        CompletedRepeater.DataBind();
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("Error: " + ex.Message);
            }
        }
    }


    private void ShowMessage(string message, bool isSuccess)
    {
        MessageLabel.Text = message;
        MessageLabel.ForeColor = isSuccess ? System.Drawing.Color.Green : System.Drawing.Color.Red;
        MessageLabel.Visible = true;
    }
}