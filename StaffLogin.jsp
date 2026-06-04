<%@ page import="java.sql.*" %>
<%@ page import="com.sohel.smartattendencesystem.DataAccess" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String message = "";
    if (request.getParameter("loginBtn") != null) { // Check if login button is clicked

        // Retrieve login details
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || email.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            message = "Both email and password are required.";
        } else {
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                conn = DataAccess.getConnection();
                if (conn != null) {
                    String sql = "SELECT * FROM tbl_staff WHERE email = ? AND password = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, email);
                    pstmt.setString(2, password);
                    rs = pstmt.executeQuery();

                    if (rs.next()) {
                        session.setAttribute("staffEmail", email); // Store email in session
                        session.setAttribute("staffName", rs.getString("full_name")); // Store name in session
                        response.sendRedirect("Index.jsp"); // Redirect to dashboard
                    } else {
                        message = "Invalid email or password.";
                    }
                } else {
                    message = "Database connection failed.";
                }
            } catch (SQLException e) {
                message = "Error: " + e.getMessage();
            } finally {
                try {
                    if (rs != null) rs.close();
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
    <title>Staff Login</title>

    <!-- Bootstrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #f8f9fa;
            font-family: Arial, sans-serif;
        }
        .login-container {
            max-width: 400px;
            background: #ffffff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.1);
            margin: 50px auto;
        }
        .login-header {
            background-color: #343a40;
            color: white;
            padding: 15px;
            border-radius: 8px 8px 0 0;
            text-align: center;
            font-weight: bold;
        }
        .error-message {
            color: red;
            font-size: 14px;
            text-align: center;
        }
        .btn-dark {
        width: 100%;
        padding: 10px;
    }
    </style>
</head>
<body>

    <%@include file="WEB-INF/Header.jsp" %>

    <div class="container">
        <div class="login-container">
            <h2 class="login-header mb-4">Staff Login</h2>

            <% if (message != null && !message.isEmpty()) { %>
                <p class="error-message"><%= message %></p>
            <% } %>

            <form method="post" class="login-form" onsubmit="return validateLoginForm()">
                <div class="mb-3">
                    <label>Email</label>
                    <input type="email" class="form-control" name="email" id="email">
                    <span class="error-message" id="emailError"></span>
                </div>
                <div class="mb-3">
                    <label>Password</label>
                    <input type="password" class="form-control" name="password" id="password">
                    <span class="error-message" id="passwordError"></span>
                </div>
                <div class="sub-content">
                        <div class="s-part">
                            Forgot Password? <a href="frmForgotPassword.jsp">Reset</a>
                        </div>
                    </div>
                <div class="sub-content">
                        <div class="s-part">
                            Don't have an account? <a href="StaffRegister.jsp">Register</a>
                        </div>
                    </div>
                <div class="text-center mt-3">
                    <button type="submit" name="loginBtn" class="btn btn-dark">Login</button>
                </div>
                
            </form>
        </div>
    </div>

    <%@include file="WEB-INF/Footer.jsp" %>

    <script>
        function validateLoginForm() {
            let isValid = true;

            let email = document.getElementById("email").value.trim();
            let password = document.getElementById("password").value.trim();

            document.querySelectorAll(".error-message").forEach(e => e.innerHTML = "");

            if (!email.match(/^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$/)) { 
                document.getElementById("emailError").innerText = "Invalid email."; 
                isValid = false; 
            }
            if (password.length < 6) { 
                document.getElementById("passwordError").innerText = "Password must be at least 6 characters."; 
                isValid = false; 
            }

            return isValid;
        }
    </script>

</body>
</html>
