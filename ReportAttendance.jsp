<%@page import="java.sql.Connection"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="com.sohel.smartattendencesystem.AttendanceReportDAO" %>
<%@ page import="com.sohel.smartattendencesystem.DataAccess" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String deleteId = request.getParameter("deleteId");
    if (deleteId != null) {
        try {
            int attendanceId = Integer.parseInt(deleteId);
            boolean deleted = AttendanceReportDAO.deleteAttendance(attendanceId);
            if (deleted) {
                out.println("<script>alert('Attendance record deleted successfully!');</script>");
            } else {
                out.println("<script>alert('Failed to delete attendance record.');</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Attendance Report</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <%@include file="WEB-INF/Header.jsp" %>
    <div class="container mt-5">
        <h2 class="text-center mb-4">Attendance Report</h2>

       <div class="container mt-5 d-flex justify-content-center">
    <div class="card shadow p-3 mb-4" style="width: 450px;"> <!-- Card width set between 400-500px -->
        <div class="card-body">
            <h5 class="card-title text-center mb-3">Generate Attendance Report</h5>
            <form method="GET">
                <div class="mb-3">
                    <label class="form-label">Select Date:</label>
                    <input type="date" class="form-control" name="attendanceDate" 
                           value="<%= request.getParameter("attendanceDate") != null ? request.getParameter("attendanceDate") : "" %>" required>
                </div>
                <div class="mb-3">
                    <label class="form-label">Select Subject:</label>
                    <select class="form-control" name="subjectId" required>
                        <option value="">Select Subject</option>
                        <%
                            Connection con = null;
                            ResultSet subjectRs = null;
                            try {
                                con = DataAccess.getConnection();
                                subjectRs = con .createStatement().executeQuery("SELECT subject_id, subject_name FROM tbl_subjects");

                                while (subjectRs.next()) {
                                    int subjectId = subjectRs.getInt("subject_id");
                                    String subjectName = subjectRs.getString("subject_name");
                                    String selected = request.getParameter("subjectId") != null && request.getParameter("subjectId").equals(String.valueOf(subjectId)) ? "selected" : "";
                        %>
                        <option value="<%= subjectId %>" <%= selected %>><%= subjectName %></option>
                        <% 
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            } finally {
                                if (subjectRs != null) subjectRs.close();
                                if (con != null) con.close();
                            }
                        %>
                    </select>
                </div>
                <div class="text-center">
                    <button type="submit" class="btn btn-primary w-100">Generate Report</button>
                </div>
            </form>
        </div>
    </div>
</div>


        <%
            String date = request.getParameter("attendanceDate");
            String subjectIdParam = request.getParameter("subjectId");

            if (date != null && subjectIdParam != null && !subjectIdParam.isEmpty()) {
                int subjectId = Integer.parseInt(subjectIdParam);

                System.out.println("DEBUG: Selected Date = " + date);
                System.out.println("DEBUG: Selected Subject ID = " + subjectId);

                ResultSet reportRs = null;
                try {
                    reportRs = AttendanceReportDAO.getAttendanceReport(date, subjectId);
        %>

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
    %>
    <tr>
        <td><%= attendanceId %></td>
        <td><%= reportRs.getString("student_name") %></td>
        <td><%= reportRs.getInt("roll_no") %></td>
        <td><%= reportRs.getString("subject_name") %></td>
        <td><%= reportRs.getString("attendance_date") %></td>
        <td>
            <a href="ReportAttendance.jsp?deleteId=<%= attendanceId %>" 
               class="btn btn-danger btn-sm" 
               onclick="return confirm('Are you sure you want to delete this attendance record?');">
               Delete
            </a>
        </td>
    </tr>
    <% } %>

    <% if (!hasData) { %>
        <tr>
            <td colspan="6" class="text-center">No records found for the selected date and subject.</td>
        </tr>
    <% } %>
</tbody>

        </table>

        <% 
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (reportRs != null) reportRs.close();
                }
            }
        %>
    </div>
        <%@include file="../WEB-INF/ReportFooter.jsp" %>
</body>
</html>
