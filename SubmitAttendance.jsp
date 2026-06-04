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
    String message = "";
    boolean success = false;

    if (request.getMethod().equalsIgnoreCase("post")) {
        String studentName = request.getParameter("studentName");
        String rollNo = request.getParameter("rollNo");
        int subjectId = Integer.parseInt(request.getParameter("subjectId"));
        
        try {
            conn = DataAccess.getConnection();

            // Fetch staff ID based on session email
            int staffId = -1;
            pstmt = conn.prepareStatement("SELECT staff_id FROM tbl_staff WHERE email = ?");
            pstmt.setString(1, staffEmail);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                staffId = rs.getInt("staff_id");
            }
            rs.close();
            pstmt.close();

            if (staffId != -1) {
                // Check if attendance already exists for today
                String checkQuery = "SELECT COUNT(*) FROM tbl_attendance WHERE roll_no = ? AND subject_id = ? AND DATE(attendance_date) = CURDATE()";
                pstmt = conn.prepareStatement(checkQuery);
                pstmt.setString(1, rollNo);
                pstmt.setInt(2, subjectId);
                rs = pstmt.executeQuery();

                rs.next();
                int count = rs.getInt(1);
                rs.close();
                pstmt.close();

                if (count > 0) {
                    message = "🚫 Attendance already recorded for this student in this subject today.";
                } else {
                    // Insert attendance record
                    String sql = "INSERT INTO tbl_attendance (student_name, roll_no, subject_id, staff_id, attendance_date) VALUES (?, ?, ?, ?, NOW())";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, studentName);
                    pstmt.setString(2, rollNo);
                    pstmt.setInt(3, subjectId);
                    pstmt.setInt(4, staffId);

                    int rowsInserted = pstmt.executeUpdate();
                    if (rowsInserted > 0) {
                        message = "✅ Attendance recorded successfully!";
                        success = true;
                    } else {
                        message = "❌ Failed to record attendance.";
                    }
                }
            } else {
                message = "⚠️ Staff ID not found.";
            }
        } catch (SQLException e) {
            message = "❌ Error: " + e.getMessage();
        } finally {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Attendance Submission</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        .message-box {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            border-radius: 10px;
            text-align: center;
            font-size: 1.2rem;
            font-weight: bold;
        }
        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }
        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
        .icon {
            font-size: 50px;
            margin-bottom: 10px;
        }
        .btn-back {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
            display: inline-block;
            margin-top: 20px;   
        }
        .btn-back:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

    <%@include file="WEB-INF/Header.jsp" %>

    <div class="container">
        <div class="message-box <%= success ? "success" : "error" %>">
            <i class="icon <%= success ? "fa fa-check-circle" : "fa fa-times-circle" %>"></i>
            <p><%= message %></p>
            <a href="Attendance.jsp" class="btn-back">Back to Attendance</a>
        </div>
    </div>

    <%@include file="WEB-INF/Footer.jsp" %>

</body>
</html>
