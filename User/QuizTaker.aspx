<%@ Page Language="C#" AutoEventWireup="true" Title="Quiz" MasterPageFile="~/Site.Master" CodeBehind="QuizTaker.aspx.cs" Inherits="LearningApplication.User.QuizTaker" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
  
    <% if (quiz != null)
        { %>
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="/">Home</a></li>
        <li class="breadcrumb-item"><a href="/User/Subjects">Subjects</a></li>
        <li class="breadcrumb-item"><a href="/User/SubjectViewer?subject_id=<%=quiz["subject_uuid"] %>"><%=quiz["s_title"] %></a></li>
        <li class="breadcrumb-item"><a href="/User/TopicViewer?topic_uuid=<%=quiz["topic_uuid"] %>"><%=quiz["t_title"] %></a></li>
        <li class="breadcrumb-item active" aria-current="page"><%=quiz["title"] %></li>
      </ol>
    </nav>
    <div class="card shadow my-3">
        <div class="card-body position-relative">
            <div class="row">
                <div class="col-md-9">
                    <h1 class="font-weight-bold"><%=quiz["title"] %></h1>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-10 offset-md-1">
            <h2>Quiz Questions</h2>
            <%foreach (var question in questions)
                { %>
                <div class="card my-2 position-relative">
                    <div class="card-header">
                        <div class="tinymcelongtext">
                            <%=question["text"] %>
                        </div>
                    </div>
                    <div class="card-body">
                        <% foreach (Dictionary<string, object> choice in (List<Dictionary<string, object>>)question["choices"])
                            {%>
                        <div class="form-check">
                          <input class="form-check-input" type="radio" name="<%=question["quiz_question_uuid"] %>" id="<%=choice["quiz_choices_uuid"] %>" value="<%=choice["quiz_choices_uuid"]%>" required="required">
                          <label class="form-check-label" for="<%=choice["quiz_choices_uuid"]%>" >
                            <%=choice["choiceLetter"] %>. <%=choice["text"] %>
                          </label>
                        </div>
                        <%} %>
                    </div>
                </div>
            <%} %>
            <div class="d-flex align-items-center justify-content-center">
                <asp:Button runat="server" ID="SubmitBtn" CssClass="btn btn-success w-100" Text="Submit Quiz" OnClick="SubmitBtn_Click" />
            </div>
        </div> 
    </div>
    
    <% }
        else
        { %>
    <h1>Quiz not found!</h1>
    <%} %>
</asp:Content>
