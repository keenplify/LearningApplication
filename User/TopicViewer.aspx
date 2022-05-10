<%@ Page Language="C#" AutoEventWireup="true" Title="Topic" MasterPageFile="~/Site.Master" CodeBehind="TopicViewer.aspx.cs" Inherits="LearningApplication.User.TopicViewer" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
  
    <% if (topic != null)
        { %>
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="/">Home</a></li>
        <li class="breadcrumb-item"><a href="/User/Subjects">Subjects</a></li>
        <li class="breadcrumb-item"><a href="/User/SubjectViewer?subject_uuid=<%=topic["subject_uuid"] %>"><%=topic["s_title"] %></a></li>
        <li class="breadcrumb-item active" aria-current="page"><%=topic["title"] %></li>
      </ol>
    </nav>
    <div class="card shadow my-3">
        <div class="card-body position-relative">
            <div class="row">
                <img class="w-100" src="<%= topic["logo_src"] != DBNull.Value ? topic["logo_src"] : "/Images/question.png"   %>" />
            </div>
        </div>
       
    </div>
    <div class="row">
        <div class="col-md-10 offset-md-1">
            <h2><%=topic["title"] %></h2>
            <div class="tinymcelongtext">
                <%=topic["description"] %>
            </div>
            <hr />
            <div class="d-md-flex">
                <h2>This Topic's Quizzes</h2>
            </div>
            <table class="table table-striped" id="QuizzesTable">
                <thead>
                    <tr>
                        <td>Title</td>
                        <td>Total Score</td>
                        <td>Action</td>
                    </tr>
                </thead>
                <tbody>
                    <% foreach (var quiz in quizzes)
                        { %>
                    <tr>
                        <td><%=quiz["title"] %></td>
                        <% if (quiz["total_score"].GetType().ToString() != "System.DBNull") {%>
                        <td>
                            <%=quiz["total_score"] %> / <%=quiz["max_score"] %>
                        </td>
                        <td>
                            <div class="btn btn-primary disabled" disabled="true">Already Taken</div>
                        </td>
                        <%} else { %>
                        <td>
                            Not yet taken
                        </td>
                        <td>
                            <a href="QuizTaker?quiz_uuid=<%=quiz["quiz_uuid"] %>" class="btn btn-primary">Take Quiz</a>
                        </td>
                        <%} %>
                    </tr>
                    <%} %>
                </tbody>
            </table>
        </div>
    </div>
    <% }
        else
        { %>
    <h1>Topic not found!</h1>
    <%} %>
</asp:Content>
