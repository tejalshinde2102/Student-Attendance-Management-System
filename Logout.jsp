<%-- 
    Document   : Logout
    Created on : 01-Mar-2025, 4:36:31 pm
    Author     : VICTUS
--%>
<%
    session.invalidate(); // Destroy session
    response.sendRedirect("StaffLogin.jsp"); // Redirect to login page
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
