<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="LearningApplication.Register" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="d-flex flex-column align-items-center justify-content-center my-5">
        <h1>Register</h1>
        <asp:Panel runat="server" ID="RegisterPnl" CssClass="d-flex flex-column align-items-center" DefaultButton="RegisterSubmitBtn">
            <% if (ErrorLbl.Text.Length > 0) {%>
            <div class="alert alert-danger">
                <asp:Label runat="server" ID="ErrorLbl" />
            </div>
            <%} %>
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="form-label">Full Name</label>
                        <asp:TextBox runat="server" ID="fullname" CssClass="form-control" required="true"/>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="form-label">Email</label>
                        <asp:TextBox runat="server" ID="email" CssClass="form-control" required="true"/>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="form-label">Username</label>
                        <asp:TextBox runat="server" ID="username" CssClass="form-control" required="true"/>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form-group">
                        <label class="form-label">Password</label>
                        <asp:TextBox runat="server" ID="password" type="password" CssClass="form-control" required="true"/>
                    </div>
                </div>
            </div>
            <asp:Button runat="server" ID="RegisterSubmitBtn" OnClick="RegisterSubmitBtn_Click" Text="Register" CssClass="btn btn-primary w-100" />
        </asp:Panel>
        <small class="mt-2">Already have an account? <a href="/Login">Login</a></small>
    </div>
</asp:Content>
