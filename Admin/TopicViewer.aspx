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
                <div class="col">
                     <img class="w-100" src="<%= topic["logo_src"] != DBNull.Value ? topic["logo_src"] : "/Images/question.png"   %>" />
                </div>
                <div class="col">
                    <h1 class="font-weight-bold"><%=topic["title"] %></h1>
                    <hr />
                    <%=topic["description"] %>
                </div>
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
        </div>
    </div>
    <% }
        else
        { %>
    <h1>Topic not found!</h1>
    <%} %>
</asp:Content>
