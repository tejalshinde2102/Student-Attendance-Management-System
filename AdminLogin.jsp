<%@page import="java.sql.*"%>
<%@page import="com.sohel.smartattendencesystem.DataAccess"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String msg = "";

    if (request.getParameter("btnLogin") != null) {

        String uname = request.getParameter("username");
        String pass = request.getParameter("password");

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DataAccess.getConnection();
            String sql = "SELECT * FROM tbl_users WHERE username=? AND password=? AND role='admin'";

            ps = con.prepareStatement(sql);
            ps.setString(1, uname);
            ps.setString(2, pass);

            rs = ps.executeQuery();

            if (rs.next()) {
                session.setAttribute("admin", uname);
                response.sendRedirect("Reports/AdminDashboard.jsp");
                return;
            } else {
                msg = "Invalid username or password!";
            }

        } catch (Exception e) {
            msg = "Error: " + e.getMessage();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
            } catch (Exception e) {
            }
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
        <title>Admin Login</title>
        <style>
            body {
                font-family: Arial;
                background: #f0f0f0;
            }
            .box {
                width: 350px;
                margin: 200px auto;
                background: #fff;
                padding: 25px;
                border-radius: 10px;
                box-shadow: 0 0 10px #ccc;
            }
            input[type=text], input[type=password] {
                width: 90%;
                padding: 10px;
                margin-top: 10px;
                border-radius: 5px;
                border: 1px solid #ccc;
            }
            input[type=submit] {
                width: 50%;
                padding: 10px;
                background: #007bff;
                border: none;
                color: white;
                margin-top: 15px;
                font-size: 16px;
                border-radius: 5px;
                cursor: pointer;
                margin-left: 90px;
            }
            .error {
                color: red;
                text-align: center;
                margin-top: 10px;
            }
        </style>
    </head>
    <body>

        <div class="box">
            <h2 style="text-align:center;">Admin Login</h2>

            <form method="post">
                <input type="text" name="username" placeholder="Enter Username" required>
                <input class="mb-2" type="password" name="password" placeholder="Enter Password" required>
                <div class="s-part mb-2 mt-2">
                    Don't have an account? <a href="AdminRegister.jsp">Register</a>
                </div>
                <input type="submit" name="btnLogin" value="Login">
                
                <div class="error"><%= msg%></div>
            </form>
        </div>

    </body>
</html>
