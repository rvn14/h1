using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using MySql.Data.MySqlClient;


namespace testForm
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }
        private void button1_Click(object sender, EventArgs e)
        {
            String connectionString = "server=localhost;user=root;password=DJdas12345;database=testdb";
            MySqlConnection conn = new MySqlConnection(connectionString);
            Console.WriteLine("Connecting to MySQL...");

            String username, password;

            username = txtUsername.Text.Trim();
            password = txtPassword.Text.Trim();

            try
            {
                String query = "SELECT COUNT(*) FROM users WHERE username = @username AND password = @password";
                MySqlCommand cmd = new MySqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@username", username);
                cmd.Parameters.AddWithValue("@password", password);
                conn.Open();

                int count = Convert.ToInt32(cmd.ExecuteScalar());

                if (count > 0)
                {
                    MessageBox.Show("Login Successful!", "Success", MessageBoxButtons.OK, MessageBoxIcon.Information);
                    Home homeForm = new Home();
                    homeForm.FormClosed += (s, args) => Application.Exit();
                    homeForm.Show();
                    this.Hide();

                }
                else
                {
                    MessageBox.Show("Invalid Credentials!", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }

            }


            catch (Exception)
            {

                MessageBox.Show("Invalid Credentials!", "Error", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            finally
            { conn.Close(); }
        }

    }
}

namespace SignupApp
{
    public partial class SignupForm : Form
    {
        // Connection string (edit password/db as needed)
        private string connectionString = "server=localhost;user=root;password=12345;database=database1";

        public SignupForm()
        {
            InitializeComponent();
        }

        private void btnSignup_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();

            // --- Basic Validation ---
            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password) || string.IsNullOrEmpty(confirmPassword))
            {
                MessageBox.Show("Please fill in all fields.");
                return;
            }
            if (password != confirmPassword)
            {
                MessageBox.Show("Passwords do not match.");
                return;
            }

            // --- Check if username exists ---
            using (MySqlConnection conn = new MySqlConnection(connectionString))
            {
                try
                {
                    conn.Open();

                    // Check if username already exists
                    string checkUserQuery = "SELECT COUNT(*) FROM users WHERE username = @username";
                    MySqlCommand checkCmd = new MySqlCommand(checkUserQuery, conn);
                    checkCmd.Parameters.AddWithValue("@username", username);

                    int userCount = Convert.ToInt32(checkCmd.ExecuteScalar());
                    if (userCount > 0)
                    {
                        MessageBox.Show("Username already exists. Choose another.");
                        return;
                    }

                    // Insert new user
                    string insertQuery = "INSERT INTO users (username, password) VALUES (@username, @password)";
                    MySqlCommand insertCmd = new MySqlCommand(insertQuery, conn);
                    insertCmd.Parameters.AddWithValue("@username", username);
                    insertCmd.Parameters.AddWithValue("@password", password); // For demo only

                    insertCmd.ExecuteNonQuery();

                    MessageBox.Show("Signup successful! You can now log in.");
                    this.Close(); // Or clear fields, or redirect to login
                }
                catch (Exception ex)
                {
                    MessageBox.Show("Database error: " + ex.Message);
                }
            }
        }
    }
}
