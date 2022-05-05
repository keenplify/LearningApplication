<%@ Page Language="C#" AutoEventWireup="true" Title="Subjects Viewer" MasterPageFile="~/Site.Master" CodeBehind="Subjects.aspx.cs" Inherits="LearningApplication.Admin.Subjects" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="d-flex mt-3">
        <h1>Subjects</h1>
        <div class="ml-auto">
            <!-- Button trigger modal -->
            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
              Add Subject
            </button>

            <!-- Modal -->
            <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
              <div class="modal-dialog" role="document">
                <div class="modal-content">
                  <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Add Subject</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                      <span aria-hidden="true">&times;</span>
                    </button>
                  </div>
                  <asp:Panel runat="server" ID="AddSubjectPnl" DefaultButton="AddSubjectBtn" ValidateRequestMode="Disabled">
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
                        <asp:Button runat="server" ID="AddSubjectBtn" OnClick="AddSubjectBtn_Click" Text="Submit" CssClass="btn btn-success"/>
                    </div>
                  </asp:Panel>
                </div>
              </div>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="card-columns">
            <% foreach( var subject in subjects ) { %>
                <a href="./SubjectViewer?subject_uuid=<%= subject["subject_uuid"] %>" class="card">
                    <img class="card-img-top" src="<%= subject["logo_src"] != DBNull.Value ? subject["logo_src"] : "/Images/question.png"   %>" />
                    <div class="card-body text-center">
                        <h6 class="card-title"><%=subject["title"] %></h6>
                    </div>
                </a>
            <%} %>
        </div>
    </div>
</asp:Content>
