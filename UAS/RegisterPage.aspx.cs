using System;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        MessageLabel.Visible = false; 
    }

    protected void RegisterButton_Click(object sender, EventArgs e)
    {
        string username = Username.Text.Trim();
        string email = Email.Text.Trim();
        string password = Password.Text.Trim();

        if (string.IsNullOrEmpty(username))
        {
            ShowMessage("Username is required.", false);
            return;
        }

        if (string.IsNullOrEmpty(email) || !IsValidEmail(email))
        {
            ShowMessage("Invalid email format.", false);
            return;
        }

        if (string.IsNullOrEmpty(password) || !IsValidPassword(password))
        {
            ShowMessage("Password must be at least 8 characters long, and include a number and a special character.", false);
            return;
        }

        string hashedPassword = HashPassword(password);
        string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            try
            {
                conn.Open();

                string checkQuery = "SELECT COUNT(1) FROM Users WHERE Username = @Username OR Email = @Email";
                using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                {
                    checkCmd.Parameters.AddWithValue("@Username", username);
                    checkCmd.Parameters.AddWithValue("@Email", email);

                    int exists = Convert.ToInt32(checkCmd.ExecuteScalar());
                    if (exists > 0)
                    {
                        ShowMessage("Username or email already exists. Please try again.", false);
                        return;
                    }
                }

                string insertQuery = "INSERT INTO Users (Username, Email, Password) VALUES (@Username, @Email, @Password)";
                using (SqlCommand insertCmd = new SqlCommand(insertQuery, conn))
                {
                    insertCmd.Parameters.AddWithValue("@Username", username);
                    insertCmd.Parameters.AddWithValue("@Email", email);
                    insertCmd.Parameters.AddWithValue("@Password", hashedPassword); 

                    insertCmd.ExecuteNonQuery();
                    ShowMessage("Registration successful!", true);

                    Response.Redirect("LoginPage.aspx");
                }
            }
            catch (Exception ex)
            {
                ShowMessage("An error occurred during registration. Please try again.", false);
                System.Diagnostics.Debug.WriteLine("Error: " + ex.Message); 
            }
        }
    }

    private void ShowMessage(string message, bool isSuccess)
    {
        MessageLabel.Text = message;
        MessageLabel.CssClass = isSuccess ? "success-message" : "error-message";
        MessageLabel.Visible = true;
    }

    private string HashPassword(string password)
    {
        using (SHA256 sha256 = SHA256.Create())
        {
            byte[] bytes = Encoding.UTF8.GetBytes(password);
            byte[] hash = sha256.ComputeHash(bytes);

            StringBuilder result = new StringBuilder();
            foreach (byte b in hash)
            {
                result.Append(b.ToString("x2"));
            }
            return result.ToString();
        }
    }

    private bool IsValidEmail(string email)
    {
        string emailPattern = @"^[^@\s]+@[^@\s]+\.[^@\s]+$";
        return Regex.IsMatch(email, emailPattern);
    }

    private bool IsValidPassword(string password)
    {
        string passwordPattern = @"^(?=.*[0-9])(?=.*[!@#$%^&*.,?])[a-zA-Z0-9!@#$%^&*.,?]{8,}$";
        return Regex.IsMatch(password, passwordPattern);
    }
}
