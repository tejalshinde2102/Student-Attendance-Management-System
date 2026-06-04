<%@page import="java.util.List"%>
<%@page import="com.sohel.smartattendencesystem.SubjectDAO"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Manage Subjects</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    <style>
        .form-container {
            max-width: 500px;
            padding: 20px;
            border-radius: 10px;
            background-color: #f8f9fa;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        .table-container {
            max-width: 800px;
            margin: auto;
        }
        body { margin: 0; font-family: Arial; background: #f8f9fa; }

        .navbar {
            background: #343a40;
            padding: 15px;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar a {
            color: white;
            margin-right: 20px;
            text-decoration: none;
            font-size: 16px;
        }

        .navbar a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="navbar">
    <div>
        <b>Admin Dashboard</b>
    </div>

    <div>
        <a href="AdminDashboard.jsp">Home</a>
        <a href="Reports.jsp">Reports</a>
        <a href="ManageSubjects.jsp">Subjects</a>
        <a href="ReportStaffDetails.jsp">Staff Details</a>
        <a href="../AdminLogout.jsp">Logout</a>
    </div>
</div>
<div class="container mt-5">
    <h2 class="text-center mb-4">Manage Subjects</h2>

    <!-- Add / Update Subject Form -->
    <div class="mx-auto form-container">
        <h5 class="text-center" id="formTitle">Add New Subject</h5>
        <form method="GET" action="ManageSubjects.jsp">
            <input type="hidden" name="action" id="formAction" value="add">
            <input type="hidden" name="subjectId" id="subjectId">
            <div class="mb-3">
                <label><strong>Subject Name:</strong></label>
                <input type="text" class="form-control" name="subjectName" id="subjectName" required>
            </div>
            <button type="submit" class="btn btn-primary w-100" id="submitButton">Add Subject</button>
        </form>
    </div>

    <%
        // Handle Insert, Update, and Delete
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            String subjectName = request.getParameter("subjectName");
            if (subjectName != null && !subjectName.isEmpty()) {
                SubjectDAO.addSubject(subjectName);
                response.sendRedirect("ManageSubjects.jsp");
            }
        }

        if ("delete".equals(action)) {
            int subjectId = Integer.parseInt(request.getParameter("id"));
            SubjectDAO.deleteSubject(subjectId);
            response.sendRedirect("ManageSubjects.jsp");
        }

        if ("update".equals(action)) {
            int subjectId = Integer.parseInt(request.getParameter("subjectId"));
            String subjectName = request.getParameter("subjectName");
            if (subjectName != null && !subjectName.isEmpty()) {
                SubjectDAO.updateSubject(subjectId, subjectName);
                response.sendRedirect("ManageSubjects.jsp");
            }
        }
    %>

    <!-- Subject List -->
    <div class="table-container mt-4">
        <h5 class="text-center">Subject List</h5>
        <table class="table table-bordered">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Subject Name</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<SubjectDAO> subjects = SubjectDAO.getSubjects();
                    for (SubjectDAO Subject : subjects) {
                %>
                <tr>
                    <td><%= Subject.getSubjectId() %></td>
                    <td><%= Subject.getSubjectName() %></td>
                    <td>
                        <!-- Edit Button -->
                        <button class="btn btn-warning btn-sm edit-btn" 
                                data-id="<%= Subject.getSubjectId() %>" 
                                data-name="<%= Subject.getSubjectName() %>">
                            Edit
                        </button>

                        <!-- Delete Button -->
                        <a href="ManageSubjects.jsp?action=delete&id=<%= Subject.getSubjectId() %>" 
                            class="btn btn-danger btn-sm"
                            onclick="return confirm('Are you sure you want to delete this subject?');">
                            Delete
                        </a>
                    </td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>
</div>


<script>
    document.addEventListener("DOMContentLoaded", function() {
        // Handle Edit Button Click
        document.querySelectorAll(".edit-btn").forEach(button => {
            button.addEventListener("click", function() {
                document.getElementById("formTitle").textContent = "Update Subject";
                document.getElementById("formAction").value = "update";
                document.getElementById("subjectId").value = this.dataset.id;
                document.getElementById("subjectName").value = this.dataset.name;
                document.getElementById("submitButton").textContent = "Update Subject";
            });
        });
    });
</script>

</body>
</html>
