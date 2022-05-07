<%@ Page Language="C#" AutoEventWireup="true" Title="Add Quiz Question" MasterPageFile="~/Site.Master" CodeBehind="AddQuizQuestion.aspx.cs" Inherits="LearningApplication.Admin.AddQuizQuestion" validateRequest="false"  %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
  
    <% if (quiz != null)
        { %>
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="/">Home</a></li>
        <li class="breadcrumb-item"><a href="/Admin/Subjects">Subjects</a></li>
        <li class="breadcrumb-item"><a href="/Admin/SubjectViewer?subject_id=<%=quiz["subject_uuid"] %>"><%=quiz["s_title"] %></a></li>
        <li class="breadcrumb-item"><a href="/Admin/TopicViewer?topic_uuid=<%=quiz["topic_uuid"] %>"><%=quiz["t_title"] %></a></li>
        <li class="breadcrumb-item"><a href="/Admin/QuizViewer?quiz_uuid=<%=quiz["quiz_uuid"] %>"><%=quiz["title"] %></a></li>
        <li class="breadcrumb-item active" aria-current="page">Add Quiz Question</li>
      </ol>
    </nav>
    <div class="card shadow my-3">
        <div class="card-body position-relative">
            <div class="row">
                <div class="col mt-2">
                    <div calss="form-group">
                        <label class="form-label">Question Text</label>
                        <asp:TextBox runat="server" TextMode="MultiLine" ID="QuestionTextTbx" CausesValidation="false">
                        </asp:TextBox>
                        <script defer>
                            tinymce.init({
                                selector: 'textarea#MainContent_QuestionTextTbx'
                            });
                        </script>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <h2>Choices</h2>
    <div class="row">
        <div class="col-md-10 offset-md-1">
            <asp:RadioButtonList runat="server" ID="ChoicesRadios" />
        </div>
    </div>
    <hr />
    <div class="row">
        <div class="col-md-10 offset-md-1">
            
            <div class="d-flex justify-content-center align-items-center flex-column">
                <div class="input-group align-self-center justify-self-center w-auto">
                    <asp:TextBox TextMode="MultiLine" runat="server" ID="AddChoiceTbx" CssClass="form-control flex-grow-1" />
                    <div class="input-group-append">
                        <asp:Button runat="server" ID="AddChoiceBtn" OnClick="AddChoiceBtn_Click" CssClass="btn btn-success" Text="Add Choice" />
                        <asp:Button runat="server" ID="ResetChoicesBtn" OnClick="ResetChoicesBtn_Click" CssClass="btn btn-danger" Text="Reset Choices" />
                    </div>
                </div>
                <asp:Button runat="server" ID="SubmitBtn" CssClass="btn btn-primary w-100 m-2" Text="Add Question"  OnClick="SubmitBtn_Click"/>
            </div>
        </div>
    </div>
    <% }
        else
        { %>
    <h1>Quiz not found!</h1>
    <%} %>
</asp:Content>
