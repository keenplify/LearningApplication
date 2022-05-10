<%@ Page Language="C#" AutoEventWireup="true" Title="Subject" MasterPageFile="~/Site.Master" CodeBehind="SubjectViewer.aspx.cs" Inherits="LearningApplication.User.SubjectViewer" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
  
    <% if (subject != null)
        { %>
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="/">Home</a></li>
        <li class="breadcrumb-item"><a href="/User/Subjects">Subjects</a></li>
        <li class="breadcrumb-item active" aria-current="page"><%=subject["title"] %></li>
      </ol>
    </nav>
    <div class="card shadow my-3">
        <div class="card-body position-relative">
            <div class="row">
                <div class="col-md-3">
                     <img class="w-100" src="<%= subject["logo_src"] != DBNull.Value ? subject["logo_src"] : "/Images/question.png"   %>" />
                </div>
                <div class="col-md-9">
                    <h1 class="font-weight-bold"><%=subject["title"] %></h1>
                    <hr />
                    <div class="tinymcelongtext">
                        <%=subject["description"] %>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-10 offset-md-1">
            <div class="d-md-flex">
                <h2>Subject Topics</h2>
            </div>

            <table class="table table-striped">
                <thead>
                    <tr>
                        <td>Image</td>
                        <td>Title</td>
                        <td>Action</td>
                    </tr>
                </thead>
                <tbody>
                    <% foreach (var topic in topics)
                        { %>
                    <tr>
                        <td> <img class="img-fluid" style="max-width: 10rem;" src="<%= topic["logo_src"] != DBNull.Value ? topic["logo_src"] : "/Images/question.png"   %>" /></td>
                        <td><%=topic["title"] %></td>
                        <td>
                            <a href="TopicViewer?topic_uuid=<%=topic["topic_uuid"] %>" class="btn btn-primary">View Topic</a>
                            <a href="TopicViewer?topic_uuid=<%=topic["topic_uuid"] %>#QuizzesTable" class="btn btn-info">View Quizzes</a>
                        </td>
                    </tr>
                    <%} %>
                </tbody>
            </table>
        </div> 
    </div>
    <% }
        else
        { %>
    <h1>Subject not found!</h1>
    <%} %>
</asp:Content>
