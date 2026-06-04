<%@page import="com.sohel.smartattendencesystem.DataAccess"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password</title>

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">

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
            border-radius: 8px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 100%;
            max-width: 400px;
        }

        h2 {
            color: #333;
            margin-bottom: 20px;
        }

        input {
            width: 100%;
            padding: 12px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
        }

        button {
            width: 100%;
            padding: 12px;
            background: #4eb060;
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: 0.3s;
        }

        button:hover {
            background: #3b8c49;
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

        .sub-content {
            margin-top: 10px;
        }

        .sub-content a {
            color: #4eb060;
            font-weight: 500;
        }
    </style>
</head>
<body>

    <div class="container">
        <h2>Forgot Password</h2>
        <p>Enter your Email Id to reset your password.</p>

        <form method="post">
            <input type="email" name="txtEmail" placeholder="Enter Email Id" required>
            <button type="submit">Reset Password</button>
        </form>

        <div class="sub-content">
            <a href="StaffLogin.jsp">Back to Sign In</a>
        </div>

        <%
            if (request.getMethod().equalsIgnoreCase("post")) {
                String UserInput = request.getParameter("txtEmail");
                Connection con = null;

                try {
                    con = DataAccess.getConnection();
                    PreparedStatement ps = con.prepareStatement("SELECT * FROM tbl_staff WHERE email = ?");
                    ps.setString(1, UserInput);
                    ResultSet rs = ps.executeQuery();
                         
                    if (rs.next()) {
                        session.setAttribute("sEmailId", UserInput);
                        response.sendRedirect("frmResetPassword.jsp");
                    } else {
                        out.println("<p class='message error'>Email Id not found!</p>");
                    }
                } catch (Exception e) {
                    out.println("<p class='message error'>Error: " + e.getMessage() + "</p>");
                } finally {
                    if (con != null) con.close();
                }
            }
        %>
    </div>

</body>
</html>
