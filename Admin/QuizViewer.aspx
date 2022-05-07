<%@ Page Language="C#" AutoEventWireup="true" Title="Quiz" MasterPageFile="~/Site.Master" CodeBehind="QuizViewer.aspx.cs" Inherits="LearningApplication.Admin.QuizViewer" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
  
    <% if (quiz != null)
        { %>
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="/">Home</a></li>
        <li class="breadcrumb-item"><a href="/Admin/Subjects">Subjects</a></li>
        <li class="breadcrumb-item"><a href="/Admin/SubjectViewer?subject_id=<%=quiz["subject_uuid"] %>"><%=quiz["s_title"] %></a></li>
        <li class="breadcrumb-item"><a href="/Admin/TopicViewer?topic_uuid=<%=quiz["topic_uuid"] %>"><%=quiz["t_title"] %></a></li>
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
        <div class="position-absolute" style="top: 1em; right: 1em;">
            <!-- Button trigger modal -->
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#editQuizModal">
              Edit Quiz
            </button>

            <!-- Modal -->
            <div class="modal fade" id="editQuizModal" tabindex="-1" role="dialog" aria-labelledby="editQuizModalLabel" aria-hidden="true">
              <div class="modal-dialog" role="document">
                <div class="modal-content">
                  <div class="modal-header">
                    <h5 class="modal-title" id="editQuizModalLabel">Edit Quiz</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                    </button>
                  </div>
                  <asp:Panel runat="server" ID="EditQuizPnl" DefaultButton="EditQuizBtn" ValidateRequestMode="Disabled">
                    <div class="modal-body">
                        <div class="form-group">
                            <label class="form-label">Quiz Title</label>
                            <asp:TextBox runat="server" ID="title" CssClass="form-control"/>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <asp:Button runat="server" ID="EditQuizBtn" OnClick="EditQuizBtn_Click" Text="Submit" CssClass="btn btn-success"/>
                    </div>
                  </asp:Panel>
                </div>
              </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-md-10 offset-md-1">
            <div class="d-md-flex">
                <h2>Quiz Questions</h2>
                <div class="ml-auto">
                    <!-- Button trigger modal -->
                    <a href="AddQuizQuestion?quiz_uuid=<%=quiz_uuid %>" class="btn btn-primary">
                      Add Question
                    </a>
                </div>
            </div>
            <%foreach (var question in questions)
                { %>
                <div class="card my-2 position-relative">
                    <div class="card-header">
                        <%=question["text"] %>
                    </div>
                    <div class="card-body">
                        <% foreach (Dictionary<string, object> choice in (List<Dictionary<string, object>>)question["choices"])
                            {%>
                        <div class="rounded p-2 <%=(bool)choice["is_right"] ? "bg-success text-white font-weight-bold" : ""%>">
                            <%=choice["choiceLetter"] %>. <%=choice["text"] %>
                        </div>
                        <%} %>
                    </div>
                    <div class="position-absolute" style="top: 1em; right: 1em">
                        <!-- Button trigger modal -->
                        <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteQuestion<%=question["quiz_question_uuid"]%>Modal">
                          Delete Question
                        </button>

                        <!-- Modal -->
                        <div class="modal fade" id="deleteQuestion<%=question["quiz_question_uuid"]%>Modal" tabindex="-1" role="dialog" aria-labelledby="deleteQuestion<%=question["quiz_question_uuid"]%>ModalLabel" aria-hidden="true">
                          <div class="modal-dialog" role="document">
                            <div class="modal-content">
                              <div class="modal-header">
                                <h5 class="modal-title" id="deleteQuestion<%=question["quiz_question_uuid"]%>ModalLabel">Delete This Question</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                  <span aria-hidden="true">&times;</span>
                                </button>
                              </div>
                              <div class="modal-body">
                                This will delete this question. Are you sure to delete this question?
                              </div>
                              <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                <a href="DeleteQuestion?quiz_question_uuid=<%=question["quiz_question_uuid"] %>&quiz_uuid=<%=quiz_uuid %>" class="btn btn-danger">Delete Question</a>
                              </div>
                            </div>
                          </div>
                        </div>
                    </div>
                </div>
            <%} %>
        </div> 
    </div>
    
    <% }
        else
        { %>
    <h1>Quiz not found!</h1>
    <%} %>
</asp:Content>
