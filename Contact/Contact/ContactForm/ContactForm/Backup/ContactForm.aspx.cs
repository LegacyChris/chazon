using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Net.Mail;
using System.Web;
using System.Web.Configuration;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

namespace ContactForm
{
    public partial class ContactForm : System.Web.UI.Page
    {
        private string[] stateArray;


        public ContactForm()
        {
            this.stateArray = new string[] { 
            " ", "AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DC", "DE", "FL", "GA", "HI", "ID", "IL", "IN", "IA", 
            "KS", "KY", "LA", "ME", "MD", "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ", "NM", 
            "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC", "SD", "TN", "TX", "UT", "VT", "VA", "WA", 
            "WV", "WI", "WY"
            };
        }


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                this.stateDropDown.DataSource = this.stateArray;
                this.stateDropDown.DataBind();
            }
        }


        protected void SubmitBtn_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                System.Configuration.Configuration config 
                    = WebConfigurationManager.OpenWebConfiguration(base.Request.ApplicationPath);
                AppSettingsSection appSettings = (AppSettingsSection)config.GetSection("appSettings");

                string emailHost = appSettings.Settings["EmailHost"].Value;
                string fromAddress = appSettings.Settings["FromEmailAddr"].Value;
                string toAddress = appSettings.Settings["ToEmailAddr"].Value;

                SmtpClient smtpClient = new SmtpClient(emailHost);

                // Default in IIS will be localhost 
                //smtpClient.Host = "localhost";

                //Default port will be 25
                smtpClient.Port = 25;

                MailMessage message = new MailMessage();
                message.IsBodyHtml = false;
                message.Priority = MailPriority.High;
                message.DeliveryNotificationOptions = DeliveryNotificationOptions.OnFailure;

                try
                {
                    message.Subject = "Customer Site: " + this.subjectBox.Text;
                    message.Body = "Sender: " + nameBox.Text.Trim() + "\n";
                    message.Body += "Street: " + streetBox.Text.Trim() + "\n";
                    message.Body += "City: " + cityBox.Text.Trim() + "\n";
                    message.Body += "State: " + stateDropDown.SelectedValue + " " + zipBox.Text.Trim() + "\n";
                    message.Body += "Email: " + emailBox.Text.Trim() + "\n";
                    message.Body += "\n\n" + this.messageBox.Text + "\n\n";
    
                    smtpClient.Send(fromAddress, toAddress, message.Subject, message.Body);
                }
                catch (Exception ex)
                {
                    // Display error panel
                    contactLabel.Visible = false;
                    formPanel.Visible = false;
                    errorPanel.Visible = true;

                    // Log error
                    LogError(ex);
                }
                contactLabel.Visible = false;
                formPanel.Visible = false;
                errorPanel.Visible = false;
                successPanel.Visible = true;
            }

        }


        protected void ResetBtn_Click(object sender, EventArgs e)
        {
            nameBox.Text = "";
            streetBox.Text = "";
            cityBox.Text = "";
            stateDropDown.SelectedIndex = 0;
            zipBox.Text = "";
            emailBox.Text = "";
            subjectBox.Text = "";
            messageBox.Text = "";

            contactLabel.Text = "Contact Us";
        }


        private void LogError(Exception error)
        {
            LogError(error.Message, error.StackTrace);
        }


        private void LogError(string errMsg, string errTrace)
        {
            // Get programatic access to the email information stored in the web.config file
            Configuration config = WebConfigurationManager.OpenWebConfiguration(Request.ApplicationPath);
            AppSettingsSection appSettings = (AppSettingsSection)config.GetSection("appSettings");

            // Extract the values based on their key names
            string toAddress = appSettings.Settings["MyEmailAddr"].Value;
            string fromAddress = appSettings.Settings["ToEmailAddr"].Value;
            string emailHost = appSettings.Settings["EmailHost"].Value;
            string mailSubject = "Error in Customer Site: Contact.aspx.cs";
            string mailBody = errMsg + errTrace;

            // Create error notification email
            SmtpClient smtpClient = new SmtpClient(emailHost);
            MailMessage message = new MailMessage(fromAddress, toAddress, mailSubject, mailBody);
            message.IsBodyHtml = false;
            smtpClient.Send(message);
        }
    }
}
