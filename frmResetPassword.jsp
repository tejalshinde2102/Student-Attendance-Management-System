<%@page import="com.sohel.smartattendencesystem.DataAccess"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Reset Password</title>

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">

        <style>
            body {
                font-family: 'Poppins', sans-serif;
                background-color: #f4f4f4;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }

            .container {
                background: white;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
                text-align: center;
                width: 400px;
            }

            h2 {
                color: black;
                font-weight: 600;
                margin-bottom: 20px;
            }

            .form-control {
                margin: 10px 0;
            }

            .btn-custom {
                background-color: #4eb060;
                color: white;
                width: 100%;
                padding: 12px;
                border-radius: 5px;
                font-size: 16px;
            }

            .btn-custom:hover {
                background-color: #218838;
            }

            .message {
                margin-top: 15px;
                padding: 10px;
                border-radius: 5px;
                font-size: 14px;
            }

            .success {
                background: #d4edda;
                color: #155724;
                border: 1px solid #c3e6cb;
            }

            .error {
                background: #f8d7da;
                color: #721c24;
                border: 1px solid #f5c6cb;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Reset Password</h2>

            <form method="post" onsubmit="return validatePassword()">
                <input type="password" id="password" class="form-control" name="password" placeholder="Enter New Password" required>
                <p id="passwordError" class="text-danger"></p> <!-- Error message display -->
                <button type="submit" class="btn btn-custom">Update Password</button>
            </form>

            <%
                if (request.getMethod().equalsIgnoreCase("post")) {
                    String newPassword = request.getParameter("password");
                    String sEmailId = (String) session.getAttribute("sEmailId");

                    if (sEmailId == null) {
                        response.sendRedirect("frmForgotPassword.jsp");
                        return;
                    }

                    Connection con = null;
                    try {
                        con = DataAccess.getConnection();
                        if (con != null) {
                            PreparedStatement ps = con.prepareStatement("UPDATE tbl_staff SET password = ? WHERE email = ?");
                            ps.setString(1, newPassword);
                            ps.setString(2, sEmailId);
                            int rowsUpdated = ps.executeUpdate();

                            if (rowsUpdated > 0) {
                                out.println("<p class='message success'>Password updated successfully! <br> <a href='StaffLogin.jsp'>Login Now</a></p>");
                                session.invalidate();
                            } else {
                                out.println("<p class='message error'>Error updating password!</p>");
                            }
                        } else {
                            out.println("<p class='message error'>Database connection failed!</p>");
                        }
                    } catch (Exception e) {
                        out.println("<p class='message error'>Error: " + e.getMessage() + "</p>");
                    } finally {
                        if (con != null) {
                            con.close();
                        }
                    }
                }
            %>
        </div>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
    </body>
</html>
<script>
    function validatePassword() {
        let password = document.getElementById("password").value;
        let errorMsg = document.getElementById("passwordError");

        if (password.length < 6) {
            errorMsg.textContent = "Password must be at least 6 characters long!";
            return false; // Prevent form submission
        } else {
            errorMsg.textContent = ""; // Clear error message
            return true;
        }
    }
</script>