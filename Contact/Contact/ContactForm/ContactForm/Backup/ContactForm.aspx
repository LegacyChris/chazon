<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ContactForm.aspx.cs" Inherits="ContactForm.ContactForm" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title></title>
</head>
<body style="background-color:#B1D8B0;">
    <form id="form1" runat="server">
    <div>
    
    <asp:Panel ID="formPanel" Visible="true" runat="server">
    <p />

    <div style="padding-left:80px;">
        <h2><asp:Label ID="contactLabel" runat="server"></asp:Label></h2>
    </div>
    
    <p />
    <table cellpadding="0" cellspacing="0">
    <tr>
        <td style="padding-left:80px;">
            <fieldset style="width:300px;">
            <legend>Contact Details</legend>
             
                <table>
                <tr>
                    <td colspan="3" style="padding-left:60px;">
                        <asp:ValidationSummary ID="valSum" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td style="width:5%">&#160;</td>
                    <td style="width:25%; padding-top:10px;">
                        Name
                    </td>
                    <td style="width:70%; padding-top:10px;">
                        <asp:TextBox ID="nameBox" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td>&#160;</td>
                    <td>
                        Street
                    </td>
                    <td>   
                        <asp:TextBox ID="streetBox" runat="server" />    
                    </td>
                </tr>
                <tr>
                    <td>&#160;</td>
                    <td>
                        City
                    </td>
                    <td>
                        <asp:TextBox ID="cityBox" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td>&#160;</td>
                    <td>
                        State
                    </td>
                    <td>
                        <asp:DropDownList Width="45" ID="stateDropDown" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td>&#160;</td>
                    <td>
                        Zip
                    </td>
                    <td>
                        <asp:TextBox Width="80" ID="zipBox" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td style="width:2%">&#160;</td>
                    <td style="width:25%; padding-bottom:10px;">
                        Email
                    </td>
                    <td style="width:70%; padding-bottom:10px;">
                        <asp:TextBox ID="emailBox" runat="server" />
                        <asp:RequiredFieldValidator ID="emailReqVal" ControlToValidate="emailBox" 
                            ErrorMessage="Enter Email" runat="server">*</asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="emailRegVal" 
                            ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                                ControlToValidate="emailBox"
                                    ErrorMessage="Enter Valid Email Address" 
                                        runat="server">*</asp:RegularExpressionValidator>
                    </td>
                </tr>
                </table> 
                
            </fieldset>  
        </td>
    </tr>
    <tr>
        <td style="padding-left:80px;">
        <br />
            <fieldset style="width:300px;">
            <legend>Message</legend>
            
            <table>
            <tr>
                
                <td align="center" style="width:24%; padding-top:10px;">
                    Subject
                </td>
                <td style="width:76%; padding-top:10px; padding-left:5px;">
                    <asp:TextBox Width="199" ID="subjectBox" runat="server" />
                    <asp:RequiredFieldValidator ID="subjectReqVal" ControlToValidate="subjectBox" 
                        ErrorMessage="Enter Subject" runat="server">*</asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td colspan="2" style="padding-left:14px; padding-bottom:10px;">
                    <asp:textbox ID="messageBox" Width="264" TextMode="MultiLine" 
                        Rows="6" runat="server"></asp:textbox>
                    <asp:RequiredFieldValidator ID="messageReqVal" ControlToValidate="messageBox" 
                        ErrorMessage="Enter Message" runat="server">*</asp:RequiredFieldValidator> 
                </td>
            </tr>
            </table>                
            </fieldset>
        </td>
    </tr>
    <tr>
        <td style="padding-left:80px; padding-top:5px;">
            <asp:Button ID="submitBtn" Text="Submit" Width="80" runat="server" OnClick="SubmitBtn_Click" />
            <asp:Button ID="resetBtn" Text="Reset" Width="60" CausesValidation="false" 
                OnClick="ResetBtn_Click" runat="server" />
        </td>
    </tr>
    </table>
    <br />
</asp:Panel>

<asp:Panel ID="successPanel" Visible="false" runat="server">
    <br /><br />
    <table align="center" width="400" cellpadding="0" cellspacing="0">
    <tr>
        <th align="center">
            <b>Message Received</b>
        </th>
    </tr>
    <tr>
        <td>
            <p />
            Thank you for your inquiry. If you requested information or are
            placing an order, we will get back to you as soon as possible. 
            <p />
            If you have a technical question, please contact the 
            <a href="mailto:webmaster@website.com">Webmaster</a>.
        </td>
    </tr>
    </table>
</asp:Panel>

<asp:Panel ID="errorPanel" Visible="false" runat="server">  
    <br /><br />
    <table align="center" width="400" cellpadding="0" cellspacing="0">
    <tr>
        <th align="center">
            <b>Problem...</b>
        </th>
    </tr>
    <tr>
        <td>
            <p />
            We seem to be experiencing some problems at the moment. 
            We apologize for this inconvenience and suggest that you try again later.
        </td>
    </tr>
    </table>
    </asp:Panel>
    
    </div>
    </form>
</body>
</html>
