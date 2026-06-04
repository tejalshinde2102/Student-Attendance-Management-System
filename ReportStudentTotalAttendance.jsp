<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.sohel.smartattendencesystem.AttendanceReportDAO"%>
<%@page import="com.sohel.smartattendencesystem.DataAccess"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Attendance Report</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .report-card {
            max-width: 500px;
            padding: 20px;
            border-radius: 10px;
            background-color: #f8f9fa;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
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
    <h2 class="text-center mb-4">Student Attendance Report</h2>

    <!-- Handle Attendance Deletion -->
    <%
        String deleteId = request.getParameter("deleteId");
        if (deleteId != null) {
            try {
                int attendanceId = Integer.parseInt(deleteId);
                boolean deleted = AttendanceReportDAO.deleteAttendance(attendanceId);
                if (deleted) {
                    out.println("<script>alert('Attendance record deleted successfully!'); window.location='ReportStudentTotalAttendance.jsp';</script>");
                } else {
                    out.println("<script>alert('Failed to delete attendance record.');</script>");
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    %>

    <!-- Report Filter Form -->
    <div class="mx-auto report-card">
        <h5 class="text-center">Filter Attendance Report</h5>
        <form method="GET">
            <div class="mb-3">
                <label><strong>Enter Student Name:</strong></label>
                <input type="text" class="form-control" name="studentName" required>
            </div>

            <div class="mb-3">
                <label><strong>Select Subject:</strong></label>
                <select class="form-control" name="subjectId" required>
                    <option value="">Select Subject</option>
                    <%
                        Connection connn = DataAccess.getConnection();
                        ResultSet subjectRs = connn.createStatement().executeQuery("SELECT subject_id, subject_name FROM tbl_subjects");

                        while (subjectRs.next()) {
                    %>
                    <option value="<%= subjectRs.getInt("subject_id") %>"><%= subjectRs.getString("subject_name") %></option>
                    <% } %>
                </select>
            </div>

            <div class="mb-3">
                <label><strong>Start Date:</strong></label>
                <input type="date" class="form-control" name="startDate" required>
            </div>

            <div class="mb-3">
                <label><strong>End Date:</strong></label>
                <input type="date" class="form-control" name="endDate" required>
            </div>

            <button type="submit" class="btn btn-primary w-100">Generate Report</button>
        </form>
    </div>

    <%
        String studentName = request.getParameter("studentName");
        String subjectIdParam = request.getParameter("subjectId");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");

        if (studentName != null && subjectIdParam != null && startDate != null && endDate != null
            && !subjectIdParam.isEmpty() && !startDate.isEmpty() && !endDate.isEmpty()) {

            int subjectId = Integer.parseInt(subjectIdParam);
            ResultSet reportRs = AttendanceReportDAO.getAttendanceReportByStudent(studentName, subjectId, startDate, endDate);

            int totalAttendance = 0;
    %>

    <!-- Attendance Report Table -->
    <div class="mt-4">
        <h4 class="text-center">Attendance Report for <%= studentName %></h4>
        <table class="table table-bordered mt-3">
            <thead class="table-dark">
                <tr>
                    <th>Attendance ID</th>
                    <th>Student Name</th>
                    <th>Roll No</th>
                    <th>Subject</th>
                    <th>Date</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    boolean hasData = false;
                    while (reportRs.next()) { 
                        hasData = true;
                        int attendanceId = reportRs.getInt("attendance_id");
                        totalAttendance++; 
                %>
                <tr>
                    <td><%= attendanceId %></td>
                    <td><%= reportRs.getString("student_name") %></td>
                    <td><%= reportRs.getInt("roll_no") %></td>
                    <td><%= reportRs.getString("subject_name") %></td>
                    <td><%= reportRs.getString("attendance_date") %></td>
                    <td>
                        <a href="ReportStudentTotalAttendance.jsp?deleteId=<%= attendanceId %>" 
                           class="btn btn-danger btn-sm"
                           onclick="return confirm('Are you sure you want to delete this record?');">
                           Delete
                        </a>
                    </td>
                </tr>
                <% } %>

                <% if (!hasData) { %>
                    <tr>
                        <td colspan="6" class="text-center">No records found for the selected filters.</td>
                    </tr>
                <% } %>
            </tbody>
        </table>

        <!-- Total Attendance Display -->
        <div class="alert alert-success text-center">
            <strong>Total Attendance Count:</strong> <%= totalAttendance %>
        </div>
    </div>

    <% } %>

</div>


</body>
</html>
