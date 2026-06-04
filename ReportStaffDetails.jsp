<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="com.sohel.smartattendencesystem.DataAccess"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Staff & Subjects Report</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .report-card {
            max-width: 500px;
            padding: 20px;
            border-radius: 10px;
            background-color: #f8f9fa;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
        }
        .table-container {
            max-width: 900px;
            margin: auto;
        }
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

    <div>        <a href="AdminDashboard.jsp">Home</a>

        <a href="Reports.jsp">Reports</a>
        <a href="ManageSubjects.jsp">Subjects</a>
        <a href="Reports/ReportStaffDetails.jsp">Staff Details</a>
        <a href="../AdminLogout.jsp">Logout</a>
    </div>
</div>

<div class="container mt-5">
    <h2 class="text-center mb-4">Staff & Subjects Report</h2>

    <!-- Instructions Card -->
    <div class="mx-auto report-card">
        <h5 class="text-center">Report Overview</h5>
        <p class="text-muted text-center">This report provides details of all staff members and their assigned subjects.</p>

        <div class="alert alert-info p-2">
            <strong>Instructions:</strong>
            <ul class="mb-0">
                <li>This report lists staff members along with their assigned subjects.</li>
                <li>Ensure that staff and subjects are properly assigned.</li>
            </ul>
        </div>
    </div>

    <%
        // Database variables (declared once)
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        PreparedStatement countStmt = null;
        ResultSet countRs = null;
        int ReportTotalStaff = 0;

        try {
            // Establish connection
            conn = DataAccess.getConnection();

            // Query to fetch staff details with subjects
            String sql = "SELECT s.staff_id, s.full_name, s.email, s.phone, sub.subject_name, s.designation " +
                         "FROM tbl_staff s " +
                         "LEFT JOIN tbl_subjects sub ON s.subject = sub.subject_id";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();

            // Query to count total staff members
            String countQuery = "SELECT COUNT(*) AS total_staff FROM tbl_staff";
            countStmt = conn.prepareStatement(countQuery);
            countRs = countStmt.executeQuery();

            if (countRs.next()) {
                ReportTotalStaff = countRs.getInt("total_staff");
            }
    %>

    <!-- Total Staff Count -->
    <div class="alert alert-success text-center mt-3">
        <strong>Total Staff Members:</strong> <%= ReportTotalStaff %>
    </div>

    <!-- Staff & Subjects Report Table -->
    <div class="table-container">
        <table class="table table-bordered">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Subject</th>
                    <th>Designation</th>
                </tr>
            </thead>
            <tbody>
                <%
                    while (rs.next()) {
                %>
                <tr>
                    <td><%= rs.getInt("staff_id") %></td>
                    <td><%= rs.getString("full_name") %></td>
                    <td><%= rs.getString("email") %></td>
                    <td><%= rs.getString("phone") %></td>
                    <td><%= (rs.getString("subject_name") != null) ? rs.getString("subject_name") : "Not Assigned" %></td>
                    <td><%= rs.getString("designation") %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <%
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // Close resources in reverse order
            try { if (countRs != null) countRs.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (countStmt != null) countStmt.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (rs != null) rs.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (pstmt != null) pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
            try { if (conn != null) conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    %>

</div>

</body>
</html>
