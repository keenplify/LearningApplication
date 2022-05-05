<%@ Page Title="Login" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="LearningApplication.Login" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="d-flex flex-column align-items-center justify-content-center my-5">
        <h1>Login</h1>
        <asp:Panel runat="server" ID="LoginPnl" DefaultButton="LoginSubmitBtn">
            <% if (ErrorLbl.Text.Length > 0) {%>
            <div class="alert alert-danger">
                <asp:Label runat="server" ID="ErrorLbl" />
            </div>
            <%} %>
            <div class="form-group">
                <label class="form-label">Username</label>
                <asp:TextBox runat="server" ID="username" CssClass="form-control"/>
            </div>
            <div class="form-group">
                <label class="form-label">Password</label>
                <asp:TextBox runat="server" ID="password" type="password" CssClass="form-control"/>
            </div>
            <asp:Button runat="server" ValidationGroup="LoginValidationGroup" ID="LoginSubmitBtn" OnClick="LoginSubmitBtn_Click" Text="Login" CssClass="btn btn-primary w-100" />
        </asp:Panel>
        <small class="mt-2">Dont have an account? <a href="/Register">Register</a></small>
    </div>
</asp:Content>
