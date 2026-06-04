<%@page import="java.util.List"%>
<%@page import="com.sohel.smartattendencesystem.SubjectDAO"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.sohel.smartattendencesystem.DataAccess" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String message = "";
    if (request.getParameter("registerBtn") != null) { // Check if the button is clicked

        // Retrieve form parameters
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String subject = request.getParameter("subject");
        String designation = request.getParameter("designation");
        String password = request.getParameter("password");

        // Validate required fields
        if (fullName == null || fullName.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            phone == null || phone.trim().isEmpty() ||
            subject == null || subject.trim().isEmpty() ||
            designation == null || designation.trim().isEmpty() ||
            password == null || password.trim().isEmpty()) {
            
            message = "All fields are required.";
        }
        // Validate email format
        else if (!email.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$")) {
            message = "Invalid email format.";
        }
        // Validate phone number (10-digit numeric)
        else if (!phone.matches("^\\d{10}$")) {
            message = "Phone number must be 10 digits.";
        }
        // Validate password (minimum 6 characters)
        else if (password.length() < 6) {
            message = "Password must be at least 6 characters.";
        } 
        else {
            Connection conn = null;
            PreparedStatement pstmt = null;
            PreparedStatement checkEmailStmt = null;
            ResultSet rs = null;

            try {
                conn = DataAccess.getConnection();
                if (conn != null) {

                    // Check if the email already exists
                    String checkEmailQuery = "SELECT email FROM tbl_staff WHERE email = ?";
                    checkEmailStmt = conn.prepareStatement(checkEmailQuery);
                    checkEmailStmt.setString(1, email);
                    rs = checkEmailStmt.executeQuery();

                    if (rs.next()) {
                        message = "Alert: Email already exists. Please use another email.";
                    } else {
                        // Insert new user if email doesn't exist
                        String sql = "INSERT INTO tbl_staff (full_name, email, phone, subject, designation, password) VALUES (?, ?, ?, ?, ?, ?)";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, fullName);
                        pstmt.setString(2, email);
                        pstmt.setString(3, phone);
                        pstmt.setString(4, subject);
                        pstmt.setString(5, designation);
                        pstmt.setString(6, password); // Plain text (consider hashing)

                        int rowsInserted = pstmt.executeUpdate();
                        if (rowsInserted > 0) {
                            message = "Registration successful!";
                        } else {
                            message = "Error: Registration failed.";
                        }
                    }
                } else {
                    message = "Database connection failed.";
                }
            } catch (SQLException e) {
                message = "Error: " + e.getMessage();
            } finally {
                try {
                    if (rs != null) rs.close();
                    if (checkEmailStmt != null) checkEmailStmt.close();
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    }
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Teacher/Staff Registration</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
        }
        .register-container {
            max-width: 600px;
            background: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.1);
            margin: 50px auto;
        }
        .register-header {
            background-color: #343a40;
            color: white;
            padding: 15px;
            border-radius: 8px 8px 0 0;
            text-align: center;
            font-weight: bold;
        }
        .register-form label {
            font-weight: bold;
        }
        .error-message {
            color: red;
            font-size: 14px;
        }
        .success-message {
            color: green;
            text-align: center;
            font-size: 16px;
        }
    </style>
</head>
<body>

    <%@include file="WEB-INF/Header.jsp" %>

    <div class="container">
        <div class="register-container">
            <h2 class="register-header mb-4">Teacher/Staff Registration</h2>

            <% if (message != null && !message.isEmpty()) { %>
                <p class="<%= message.contains("successful") ? "success-message" : "error-message" %>">
                    <%= message %>
                </p>
            <% } %>

            <form method="post" class="register-form" onsubmit="return validateForm()">
                <div class="mb-3">
                    <label>Full Name</label>
                    <input type="text" class="form-control" name="fullName" id="fullName">
                    <span class="error-message" id="nameError"></span>
                </div>
                <div class="mb-3">
                    <label>Email</label>
                    <input type="email" class="form-control" name="email" id="email">
                    <span class="error-message" id="emailError"></span>
                </div>
                <div class="mb-3">
                    <label>Phone Number</label>
                    <input type="tel" class="form-control" name="phone" id="phone">
                    <span class="error-message" id="phoneError"></span>
                </div>
               <div class="mb-3">
    <label>Subject</label>
    <select class="form-control" name="subject" id="subject">
        <option value="">Select Subject</option>
        <%
            List<SubjectDAO> subjects = SubjectDAO.getSubjects();
            for (SubjectDAO Subject : subjects) {
        %>
            <option value="<%= Subject.getSubjectId() %>"><%= Subject.getSubjectName() %></option>
        <% } %>
    </select>
    <span class="error-message" id="subjectError"></span>
</div>
                <div class="mb-3">
                    <label>Designation</label>
                    <input type="text" class="form-control" name="designation" id="designation">
                    <span class="error-message" id="designationError"></span>
                </div>
                <div class="mb-3">
                    <label>Password</label>
                    <input type="password" class="form-control" name="password" id="password">
                    <span class="error-message" id="passwordError"></span>
                </div>
                <div class="sub-content">
                        <div class="s-part">
                            Already have an account? <a href="StaffLogin.jsp">Login</a>
                        </div>
                    </div>
                <div class="text-center mt-3">
                    <button type="submit" name="registerBtn" class="btn btn-dark">Register</button>
                </div>
            </form>
        </div>
    </div>

    <%@include file="WEB-INF/Footer.jsp" %>

    <script>
        function validateForm() {
            let isValid = true;

            let fullName = document.getElementById("fullName").value.trim();
            let email = document.getElementById("email").value.trim();
            let phone = document.getElementById("phone").value.trim();
            let subject = document.getElementById("subject").value;
            let designation = document.getElementById("designation").value.trim();
            let password = document.getElementById("password").value.trim();

            document.querySelectorAll(".error-message").forEach(e => e.innerHTML = "");

            if (fullName === "") { document.getElementById("nameError").innerText = "Full Name is required."; isValid = false; }
            if (!email.match(/^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$/)) { document.getElementById("emailError").innerText = "Invalid email."; isValid = false; }
            if (!phone.match(/^\d{10}$/)) { document.getElementById("phoneError").innerText = "Phone must be 10 digits."; isValid = false; }
            if (subject === "") { document.getElementById("subjectError").innerText = "Please select a subject."; isValid = false; }
            if (password.length < 6) { document.getElementById("passwordError").innerText = "Password must be at least 6 characters."; isValid = false; }

            return isValid;
        }
    </script>

</body>
</html>
