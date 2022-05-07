<%@ Page Language="C#" AutoEventWireup="true" Title="Subject" MasterPageFile="~/Site.Master" CodeBehind="SubjectViewer.aspx.cs" Inherits="LearningApplication.Admin.SubjectViewer" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
  
    <% if (subject != null)
        { %>
    <nav aria-label="breadcrumb">
      <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="/">Home</a></li>
        <li class="breadcrumb-item"><a href="/Admin/Subjects">Subjects</a></li>
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
                    <%=subject["description"] %>
                </div>
            </div>
        </div>
        <div class="position-absolute" style="top: 1em; right: 1em;">
            <!-- Button trigger modal -->
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#editSubjectModal">
              Edit Subject
            </button>

            <!-- Modal -->
            <div class="modal fade" id="editSubjectModal" tabindex="-1" role="dialog" aria-labelledby="editSubjectModalLabel" aria-hidden="true">
              <div class="modal-dialog" role="document">
                <div class="modal-content">
                  <div class="modal-header">
                    <h5 class="modal-title" id="editSubjectModalLabel">Edit Subject</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                    </button>
                  </div>
                  <asp:Panel runat="server" ID="EditSubjectPnl" DefaultButton="EditSubjectBtn" ValidateRequestMode="Disabled">
                    <div class="modal-body">
                        <div class="form-group">
                            <label class="form-label">Subject Title</label>
                            <asp:TextBox runat="server" ID="title" CssClass="form-control"/>
                        </div>
                        <div calss="form-group">
                            <label class="form-label">Subject Description</label>
                            <asp:TextBox runat="server" TextMode="MultiLine" ID="SubjectDescription" CausesValidation="false">
                            </asp:TextBox>
                            <script defer>
                                tinymce.init({
                                    selector: 'textarea#MainContent_SubjectDescription'
                                });
                            </script>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <asp:Button runat="server" ID="EditSubjectBtn" OnClick="EditSubjectBtn_Click" Text="Submit" CssClass="btn btn-success"/>
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
                            <label class="form-label">Subject Image</label>
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
    <div class="row">
        <div class="col-md-10 offset-md-1">
            <div class="d-md-flex">
                <h2>Subject Topics</h2>
                <div class="ml-auto">
                    <!-- Button trigger modal -->
                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addTopicModal">
                      Add Topic
                    </button>

                    <!-- Modal -->
                    <div class="modal fade" id="addTopicModal" tabindex="-1" role="dialog" aria-labelledby="addTopicModalLabel" aria-hidden="true">
                      <div class="modal-dialog" role="document">
                        <div class="modal-content">
                          <div class="modal-header">
                            <h5 class="modal-title" id="addTopicModalLabel">Add Topic</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                              <span aria-hidden="true">&times;</span>
                            </button>
                          </div>
                          <asp:Panel runat="server" ID="AddTopicPnl" DefaultButton="AddTopicBtn" ValidateRequestMode="Disabled">
                            <div class="modal-body">
                                <div class="form-group">
                                    <label class="form-label">Topic Image</label>
                                    <asp:FileUpload runat="server" ID="TopicImageUpl" CssClass="form-control"/>
                                </div>
                                <div class="form-group">
                                    <label class="form-label">Topic Title</label>
                                    <asp:TextBox runat="server" ID="TopicTitleTbx" CssClass="form-control"/>
                                </div>
                                <div calss="form-group">
                                    <label class="form-label">Topic Description</label>
                                    <asp:TextBox runat="server" TextMode="MultiLine" ID="TopicDescriptionTbx" CausesValidation="false">
                                    </asp:TextBox>
                                    <script defer>
                                        tinymce.init({
                                            selector: 'textarea#MainContent_TopicDescriptionTbx'
                                        });
                                    </script>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                <asp:Button runat="server" ID="AddTopicBtn" OnClick="AddTopicBtn_Click" Text="Submit" CssClass="btn btn-success"/>
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
                            <a href="TopicViewer?topic_uuid=<%=topic["topic_uuid"] %>" class="btn btn-primary">View</a>
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
