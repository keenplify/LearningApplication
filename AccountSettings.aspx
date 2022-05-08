<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="AccountSettings.aspx.cs" Inherits="LearningApplication.AccountSettings" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div id="accordion">
        <div class="card">
        <div class="card-header" id="headingOne">
            <h5 class="mb-0">
            <button type="button" class="btn btn-link <%= (lblPasswordError.Text.Length > 0) ? "collapsed":""%>" data-toggle="collapse" data-target="#collapseEditUserDetails" aria-expanded="true" aria-controls="collapseOne">
                Edit User Account Details
            </button>
            </h5>
        </div>

        <div id="collapseEditUserDetails" class="collapse  <%= (lblPasswordError.Text.Length > 0) ? "":"show"%>" aria-labelledby="headingOne" data-parent="#accordion">
            <div class="card-body">
                <% if (lblEditUserError.Text.Length > 0)
                    { %>
                <div class="alert alert-danger">
                    <asp:Label runat="server" ID="lblEditUserError"/>
                </div>
                <%} %>
                <asp:Panel runat="server" ID="pnlEditUser" DefaultButton="btnEditUser">
                    <div class="container" style="max-width: 576px">
                        <div class="form-group">
                            <label class="font-weight-bold">Full Name</label>
                            <asp:TextBox runat="server" ID="fullName" placeholder="Full Name" CssClass="form-control"/>
                        </div>
                        <div class="form-group">
                            <label class="font-weight-bold">Email</label>
                            <asp:TextBox runat="server" ID="email" type="email" placeholder="Email" CssClass="form-control"/>
                        </div>
                        <asp:Button runat="server" ID="btnEditUser" Text="Update User" CssClass="btn btn-primary" OnClick="btnEditUser_Click"/>
                    </div>
                </asp:Panel>
            </div>
        </div>
        </div>
        <div class="card">
        <div class="card-header" id="headingTwo">
            <h5 class="mb-0">
            <button type="button" class="btn btn-link collapsed" data-toggle="collapse" data-target="#collapseEditUsername" aria-expanded="false" aria-controls="collapseTwo">
                Edit Username
            </button>
            </h5>
        </div>
        <div id="collapseEditUsername" class="collapse" aria-labelledby="headingTwo" data-parent="#accordion">
            <div class="card-body">
                <% if (lblUsernameError.Text.Length > 0)
                    { %>
                <div class="alert alert-danger">
                    <asp:Label runat="server" ID="lblUsernameError"/>
                </div>
                <%} else { %>
                <div class="alert alert-info">
                    Your account will be forcibly logged out when you changed your username.
                </div>
                <%} %>
                <asp:Panel runat="server" ID="pnlEditUsername" DefaultButton="btnEditUsername">
                    <div class="container" style="max-width: 576px">
                        <div class="form-group">
                            <label class="font-weight-bold">New Username</label>
                            <asp:TextBox runat="server" ID="username" placeholder="Username" CssClass="form-control"/>
                        </div>
                        <asp:Button runat="server" ID="btnEditUsername" Text="Update Username" CssClass="btn btn-primary" OnClick="btnEditUsername_Click"/>
                    </div>
                </asp:Panel>
            </div>
        </div>
        </div>
        <div class="card">
        <div class="card-header" id="headingThree">
            <h5 class="mb-0">
            <button type="button" class="btn btn-link <%= (lblPasswordError.Text.Length > 0) ? "":"collapsed"%>" data-toggle="collapse" data-target="#collapseEditPassword" aria-expanded="false" aria-controls="collapseThree">
                Edit Password
            </button>
            </h5>
        </div>
        <div id="collapseEditPassword" class="collapse <%= (lblPasswordError.Text.Length > 0) ? "show":""%>" aria-labelledby="headingThree" data-parent="#accordion">
            <div class="card-body">
                
                <% if (lblPasswordError.Text.Length > 0)
                    { %>
                <div class="alert alert-danger">
                    <asp:Label runat="server" ID="lblPasswordError"/>
                </div>
                <%} else { %>
                <div class="alert alert-info">
                    Your account will be forcibly logged out when you changed your password.
                </div>
                <%} %>
                <asp:Panel runat="server" ID="pnlEditPassword" DefaultButton="btnEditPassword">
                    <div class="container" style="max-width: 576px">
                        <div class="form-group">
                            <label class="font-weight-bold">New Password</label>
                            <asp:TextBox runat="server" ID="newPassword" placeholder="New Password" type="password" CssClass="form-control"/>
                        </div>
                        <div class="form-group">
                            <label class="font-weight-bold">Retype New Password</label>
                            <asp:TextBox runat="server" ID="newPasswordRetype" placeholder="Retype New Password" type="password" CssClass="form-control"/>
                        </div>
                        <asp:Button runat="server" ID="btnEditPassword" Text="Update Password" CssClass="btn btn-primary" OnClick="btnEditPassword_Click"/>
                    </div>
                </asp:Panel>
            </div>
        </div>
        </div>
    </div>
</asp:Content>
