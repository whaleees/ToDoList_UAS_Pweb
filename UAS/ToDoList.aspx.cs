using System;
using System.Data.SqlClient;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        MessageLabel.Visible = false;
    }

    protected void CreateToDoButton_Click(object sender, EventArgs e)
    {
        string title = TitleTextBox.Text.Trim();
        string description = DescriptionTextBox.Text.Trim();
        string dueDate = DueDateTextBox.Text.Trim();
        string status = StatusDropDown.SelectedValue;
        string priority = PriorityDropDown.SelectedValue;

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

        string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            try
            {
                conn.Open();

                string insertQuery = "INSERT INTO ToDoList (Title, Description, DueDate, Status, Priority) VALUES (@Title, @Description, @DueDate, @Status, @Priority)";
                using (SqlCommand cmd = new SqlCommand(insertQuery, conn))
                {
                    cmd.Parameters.AddWithValue("@Title", title);
                    cmd.Parameters.AddWithValue("@Description", string.IsNullOrEmpty(description) ? DBNull.Value : (object)description);
                    cmd.Parameters.AddWithValue("@DueDate", string.IsNullOrEmpty(dueDate) ? DBNull.Value : (object)dueDate);
                    cmd.Parameters.AddWithValue("@Status", status);
                    cmd.Parameters.AddWithValue("@Priority", priority);

                    cmd.ExecuteNonQuery();
                    ShowMessage("To-Do created successfully!", true);

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
                ShowMessage("An error occurred while creating the To-Do. Please try again.", false);
                System.Diagnostics.Debug.WriteLine("Error: " + ex.Message);
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