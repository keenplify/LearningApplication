<%@ Page Language="C#" AutoEventWireup="true" Title="Topic" MasterPageFile="~/Site.Master" CodeBehind="TopicViewer.aspx.cs" Inherits="LearningApplication.Admin.TopicViewer" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
  
    <% if (topic != null)
        { %>
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="/">Home</a></li>
        <li class="breadcrumb-item"><a href="/Admin/Subjects">Subjects</a></li>
        <li class="breadcrumb-item"><a href="/Admin/SubjectViewer?subject_uuid=<%=topic["subject_uuid"] %>"><%=topic["s_title"] %></a></li>
        <li class="breadcrumb-item active" aria-current="page"><%=topic["title"] %></li>
      </ol>
    </nav>
    <div class="card shadow my-3">
        <div class="card-body position-relative">
            <div class="row">
                <img class="w-100" src="<%= topic["logo_src"] != DBNull.Value ? topic["logo_src"] : "/Images/question.png"   %>" />
            </div>
        </div>
        <div class="position-absolute" style="top: 1em; right: 1em;">
            <!-- Button trigger modal -->
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#editTopicModal">
              Edit Topic
            </button>

            <!-- Modal -->
            <div class="modal fade" id="editTopicModal" tabindex="-1" role="dialog" aria-labelledby="editTopicModalLabel" aria-hidden="true">
              <div class="modal-dialog" role="document">
                <div class="modal-content">
                  <div class="modal-header">
                    <h5 class="modal-title" id="editTopicModalLabel">Edit Topic</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                    </button>
                  </div>
                  <asp:Panel runat="server" ID="EditTopicPnl" DefaultButton="EditTopicBtn" ValidateRequestMode="Disabled">
                    <div class="modal-body">
                        <div class="form-group">
                            <label class="form-label">Topic Title</label>
                            <asp:TextBox runat="server" ID="title" CssClass="form-control"/>
                        </div>
                        <div calss="form-group">
                            <label class="form-label">Topic Description</label>
                            <asp:TextBox runat="server" TextMode="MultiLine" ID="TopicDescription" CausesValidation="false">
                            </asp:TextBox>
                            <script defer>
                                tinymce.init({
                                    selector: 'textarea#MainContent_TopicDescription'
                                });
                            </script>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <asp:Button runat="server" ID="EditTopicBtn" OnClick="EditTopicBtn_Click" Text="Submit" CssClass="btn btn-success"/>
                    </div>
                  </asp:Panel>
                </div>
              </div>
            </div>
            <!-- Change image Button trigger modal -->
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#changeImageModal">
              Change Image
            </button>

            <!-- Modal -->
            <div class="modal fade" id="changeImageModal" tabindex="-1" role="dialog" aria-labelledby="changeImageModalLabel" aria-hidden="true">
              <div class="modal-dialog" role="document">
                <div class="modal-content">
                  <div class="modal-header">
                    <h5 class="modal-title" id="changeImageModalLabel">Change Image</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                    </button>
                  </div>
                  <asp:Panel runat="server" ID="ChangeImagePnl" DefaultButton="ChangeImageBtn" ValidateRequestMode="Disabled">
                    <div class="modal-body">
                        <div class="form-group">
                            <label class="form-label">Topic Image</label>
                            <asp:FileUpload runat="server" ID="image" CssClass="form-control"/>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <asp:Button runat="server" ID="ChangeImageBtn" OnClick="ChangeImageBtn_Click" Text="Submit" CssClass="btn btn-success"/>
                    </div>
                  </asp:Panel>
                </div>
              </div>
            </div>
            <!-- Button trigger modal -->
            <button type="button" class="btn btn-danger" data-toggle="modal" data-target="#deleteTopicModal">
                Delete
            </button>

            <!-- Modal -->
            <div class="modal fade" id="deleteTopicModal" tabindex="-1" role="dialog" aria-labelledby="deleteTopicModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                        <h5 class="modal-title" id="deleteTopicModalLabel">Delete This Topic</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        </div>
                        <div class="modal-body">
                        This will delete this topic. Are you sure to delete this topic?
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                            <asp:Button runat="server" CssClass="btn btn-danger" Text="Delete Subject" ID="DeleteBtn" OnClick="DeleteBtn_Click"/>
                        </div>
                    </div>
                </div>
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
                <div class="ml-auto">
                    <!-- Button trigger modal -->
                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addQuizModal">
                      Add Quiz
                    </button>

                    <!-- Modal -->
                    <div class="modal fade" id="addQuizModal" tabindex="-1" role="dialog" aria-labelledby="addQuizModalLabel" aria-hidden="true">
                      <div class="modal-dialog" role="document">
                        <div class="modal-content">
                          <div class="modal-header">
                            <h5 class="modal-title" id="addQuizModalLabel">Add Quiz</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                              <span aria-hidden="true">&times;</span>
                            </button>
                          </div>
                          <asp:Panel runat="server" ID="addQuizPnl" DefaultButton="addQuizBtn" ValidateRequestMode="Disabled">
                            <div class="modal-body">
                                <div class="form-group">
                                    <label class="form-label">Quiz Title</label>
                                    <asp:TextBox runat="server" ID="TopicTitleTbx" CssClass="form-control"/>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                <asp:Button runat="server" ID="AddQuizBtn" Text="Submit" CssClass="btn btn-success" OnClick="AddQuizBtn_Click"/>
                            </div>
                          </asp:Panel>
                        </div>
                      </div>
                    </div>
                </div>
            </div>
            <table class="table table-striped">
                <thead>
                    <tr>
                        <td>Title</td>
                        <td>Action</td>
                    </tr>
                </thead>
                <tbody>
                    <% foreach (var quiz in quizzes)
                        { %>
                    <tr>
                        <td><%=quiz["title"] %></td>
                        <td>
                            <a href="QuizViewer?quiz_uuid=<%=quiz["quiz_uuid"] %>" class="btn btn-primary">View Quiz</a>
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
    <h1>Topic not found!</h1>
    <%} %>
</asp:Content>
