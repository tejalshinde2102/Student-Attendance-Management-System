<%@page import="java.sql.*"%>
<%@page import="com.sohel.smartattendencesystem.DataAccess"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String msg = "";

    if (request.getParameter("btnRegister") != null) {

        String uname = request.getParameter("username");
        String pass = request.getParameter("password");
        String role = request.getParameter("role");

        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = DataAccess.getConnection();

            String sql = "INSERT INTO tbl_users (username, password, role) VALUES (?, ?, ?)";
            ps = con.prepareStatement(sql);
            ps.setString(1, uname);
            ps.setString(2, pass);
            ps.setString(3, role);

            int row = ps.executeUpdate();

            if (row > 0) {
                msg = "User Registered Successfully!";
            } else {
                msg = "Registration Failed!";
            }

        } catch (Exception e) {
            msg = "Error: " + e.getMessage();
        } finally {
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (Exception e) {
            }
            try {
                if (con != null) {
                    con.close();
                }
            } catch (Exception e) {
            }
        }
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Admin Registration</title>
        <style>
            body {
                font-family: Arial;
                background: #f2f2f2;
            }
            .box {
                width: 380px;
                margin: 200px auto;
                background: #fff;
                padding: 25px;
                border-radius: 10px;
                box-shadow: 0 0 10px #ccc;
            }
            input, select {
                width: 100%;
                padding: 10px;
                margin-top: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
            }
            input[type=submit] {
                background: #28a745;
                color: white;
                font-size: 16px;
                cursor: pointer;
                margin-top: 15px;
            }
            .msg {
                text-align:center;
                margin-top:10px;
                color:green;
            }
        </style>
    </head>
    <body>

        <div class="box">
            <h2 style="text-align:center;">Admin Register</h2>

            <form method="post">
                <input type="text" name="username" placeholder="Enter Username" required>
                <input type="password" name="password" placeholder="Enter Password" required>

                <select name="role">
                    <option value="admin">Admin</option>
                </select>
                <div class="s-part">
                    Already have an account? <a href="AdminLogin.jsp">Login</a>
                </div>
                <input type="submit" name="btnRegister" value="Register User">

                <div class="msg"><%= msg%></div>
            </form>
        </div>

    </body>
</html>
