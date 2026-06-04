<%@ page import="java.sql.*" %>
<%@ page import="com.sohel.smartattendencesystem.DataAccess" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String staffEmail = (String) session.getAttribute("staffEmail");
    if (staffEmail == null) {
        response.sendRedirect("StaffLogin.jsp");
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Mark Attendance</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
        body { background-color: #f8f9fa; font-family: Arial, sans-serif; }
        .Attendance { max-width: 600px; margin-top: 50px; }
        .Attendance-card { width: 100%; max-width: 500px; margin: auto; border-radius: 10px; box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1); padding: 20px; }
        .hidden { display: none; }
        .info-box { background: #e9f7fe; padding: 15px; border-left: 5px solid #007bff; margin-bottom: 20px; }
    </style>
</head>
<body>

    <%@include file="WEB-INF/Header.jsp" %>

    <div class="container Attendance">
        <div class="card Attendance-card">
            <h3 class="text-center mb-3">Mark Attendance</h3>

            <!-- Welcome Message -->
            <div class="info-box">
                <p>Welcome, <strong><%= staffEmail %></strong>! Please select a subject and mark student attendance.</p>
            </div>

            <!-- Instructions -->
            <h5>Instructions:</h5>
            <ul>
                <li>Select the subject from the dropdown.</li>
                <li>Enter student name and roll number.</li>
                <li>Click "Submit" to record attendance.</li>
            </ul>

            <!-- Subject Selection -->
            <label class="fw-bold">Select Subject:</label>
            <select id="subjectDropdown" class="form-select mb-3">
                <option value="">-- Select Subject --</option>
                <%
                    try {
                        conn = DataAccess.getConnection();
                        pstmt = conn.prepareStatement("SELECT subject_id, subject_name FROM tbl_subjects");
                        rs = pstmt.executeQuery();

                        while (rs.next()) {
                %>
                    <option value="<%= rs.getInt("subject_id") %>"><%= rs.getString("subject_name") %></option>
                <%
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) rs.close();
                        if (pstmt != null) pstmt.close();
                        if (conn != null) conn.close();
                    }
                %>
            </select>

            <!-- Attendance Form -->
            <form id="attendanceForm" class="hidden mt-3" method="post" action="SubmitAttendance.jsp">
                <input type="hidden" id="selectedSubjectId" name="subjectId">

                <div class="mb-2">
                    <label class="fw-bold">Student Name:</label>
                    <input type="text" class="form-control" name="studentName" required>
                </div>
                <div class="mb-2">
                    <label class="fw-bold">Roll Number:</label>
                    <input type="text" class="form-control" name="rollNo" required>
                </div>
                <div class="text-center">
                    <button type="submit" class="btn btn-primary w-100">Submit</button>
                </div>
            </form>
        </div>
    </div>

    <%@include file="WEB-INF/Footer.jsp" %>

    <script>
        document.getElementById("subjectDropdown").addEventListener("change", function() {
            let subjectId = this.value;
            let form = document.getElementById("attendanceForm");
            if (subjectId) {
                document.getElementById("selectedSubjectId").value = subjectId;
                form.classList.remove("hidden");
            } else {
                form.classList.add("hidden");
            }
        });
    </script>

</body>
</html>
