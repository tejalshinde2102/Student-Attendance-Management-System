<%@page import="com.sohel.smartattendencesystem.ContactUs"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Contact Us Report</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

        <style>
            .report-container {
                max-width: 900px;
                margin: auto;
            }
            .table-container {
                overflow-x: auto;
            }
            .message-column {
                max-width: 500px;
                min-width: 400px;
                word-wrap: break-word;
                white-space: normal;
            }
            .report-description {
                max-width: 500px;
                min-width: 400px;
                margin: auto;
            }
            .navbar {
            background: #2c3e50;
            padding: 15px 25px;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 3px 8px rgba(0,0,0,0.3);
        }

        .navbar a {
            color: white;
            margin-left: 20px;
            text-decoration: none;
            font-size: 16px;
            font-weight: bold;
            transition: 0.3s;
        }

        .navbar a:hover {
            color: #f39c12;
        }

        </style>
    </head>
    <body>

<div class="navbar">
    <div><b style="font-size: 20px;">Admin Dashboard</b></div>
    <div>
        <a href="AdminDashboard.jsp">Home</a>
        <a href="Reports.jsp">Reports</a>
        <a href="ManageSubjects.jsp">Subjects</a>
        <a href="ReportStaffDetails.jsp">Staff Details</a>
        <a href="../AdminLogout.jsp">Logout</a>
    </div>
</div>
        <div class="container mt-5">
            <h2 class="text-center mb-4">Contact Us Report</h2>

            <!-- Description Section with Fixed Width -->
            <div class="alert alert-info report-description text-center">
                <strong>Report Description:</strong> This report displays all messages submitted via the Contact Us form, including sender details and timestamps.
            </div>

            <%
                // Pagination Variables
                int currentPage = 1;
                int recordsPerPage = 5;
                if (request.getParameter("currentPage") != null) {
                    currentPage = Integer.parseInt(request.getParameter("currentPage"));
                }

                List<ContactUs> messages = ContactUs.getMessages((currentPage - 1) * recordsPerPage, recordsPerPage);
                int totalRecords = ContactUs.getTotalMessages();
                int totalPages = (int) Math.ceil(totalRecords * 1.0 / recordsPerPage);
            %>

            <!-- Messages Table -->
            <div class="report-container">
                <div class="table-container">
                    <table class="table table-bordered">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Email</th>
                                <th class="message-column">Message</th>
                                <th>Created At</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for (ContactUs message : messages) {
                            %>
                            <tr>
                                <td><%= message.getId()%></td>  <!-- Now ID will be shown -->
                                <td><%= message.getName()%></td>
                                <td><%= message.getEmail()%></td>
                                <td class="message-column"><%= message.getMessage()%></td>
                                <td><%= message.getCreatedAt()%></td>

                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>

                <!-- Pagination -->
                <nav>
                    <ul class="pagination justify-content-center">
                        <% if (currentPage > 1) {%>
                        <li class="page-item">
                            <a class="page-link" href="ReportContactUs.jsp?currentPage=<%= currentPage - 1%>">Previous</a>
                        </li>
                        <% } %>

                        <% for (int i = 1; i <= totalPages; i++) {%>
                        <li class="page-item <%= (i == currentPage) ? "active" : ""%>">
                            <a class="page-link" href="ReportContactUs.jsp?currentPage=<%= i%>"><%= i%></a>
                        </li>
                        <% } %>

                        <% if (currentPage < totalPages) {%>
                        <li class="page-item">
                            <a class="page-link" href="ReportContactUs.jsp?currentPage=<%= currentPage + 1%>">Next</a>
                        </li>
                        <% }%>
                    </ul>
                </nav>
            </div>
        </div>
    </body>
</html>
