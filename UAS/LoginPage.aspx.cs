using System;
using System.Data.SqlClient;
using System.Security.Cryptography;
using System.Text;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ErrorMessage.Visible = false; 
    }

    protected void LoginButtonClick(object sender, EventArgs e)
    {
        string email = Email.Text.Trim();
        string password = Password.Text.Trim();

        if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
        {
            ShowErrorMessage("Please enter both email and password.");
            return;
        }

        string hashedPassword = HashPassword(password);
        string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            try
            {
                conn.Open();

                string query = "SELECT Password FROM Users WHERE Email = @Email";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Email", email);

                    object storedPasswordObj = cmd.ExecuteScalar();

                    if (storedPasswordObj != null)
                    {
                        string storedPassword = storedPasswordObj.ToString();

                        if (storedPassword == hashedPassword)
                        {
                            Response.Redirect("Homepage.aspx");
                        }
                        else
                        {
                            ShowErrorMessage("Invalid email or password.");
                        }
                    }
                    else
                    {
                        ShowErrorMessage("Invalid email or password.");
                    }
                }
            }
            catch (Exception ex)
            {
                ShowErrorMessage("An error occurred while connecting to the database.");
                System.Diagnostics.Debug.WriteLine("Database error: " + ex.Message);
            }
        }
    }

    private void ShowErrorMessage(string message)
    {
        ErrorMessage.Text = message;
        ErrorMessage.Visible = true;
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
}
