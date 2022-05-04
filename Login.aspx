<%@ Page Title="About" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="LearningApplication.Login" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel runat="server" ID="LoginPnl">
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
        <asp:Button runat="server" ID="LoginSubmitBtn" OnClick="LoginSubmitBtn_Click" Text="Login" CssClass="btn btn-primary w-100" />
    </asp:Panel>
</asp:Content>
