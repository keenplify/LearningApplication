<%@ Page Language="C#" AutoEventWireup="true" Title="Subjects Viewer" MasterPageFile="~/Site.Master" CodeBehind="Subjects.aspx.cs" Inherits="LearningApplication.User.Subjects" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="/">Home</a></li>
        <li class="breadcrumb-item active" aria-current="page">Subjects</li>
      </ol>
    </nav>
    <div class="d-flex mt-3">
        <h1>Subjects</h1>
    </div>
    <div class="container">
        <div class="card-columns">
            <% foreach( var subject in subjects ) { %>
                <a href="./SubjectViewer?subject_uuid=<%= subject["subject_uuid"] %>" class="card shadow">
                    <img class="card-img-top" src="<%= subject["logo_src"] != DBNull.Value ? subject["logo_src"] : "/Images/question.png"   %>" />
                    <div class="card-body text-center">
                        <h6 class="card-title"><%=subject["title"] %></h6>
                    </div>
                </a>
            <%} %>
        </div>
    </div>
</asp:Content>
