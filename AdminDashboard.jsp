<%@page import="java.sql.*"%>
<%@page import="com.sohel.smartattendencesystem.DataAccess"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    if (session.getAttribute("admin") == null) {
        response.sendRedirect("../AdminLogin.jsp");
        return;
    }

    int totalStaff = 0;
    int totalSubjects = 0;

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        con = DataAccess.getConnection();

        // Fetch total staff
        ps = con.prepareStatement("SELECT COUNT(*) AS total_staff FROM tbl_staff");
        rs = ps.executeQuery();
        if (rs.next()) {
            totalStaff = rs.getInt("total_staff");
        }
        rs.close();
        ps.close();

        // Fetch total subjects
        ps = con.prepareStatement("SELECT COUNT(*) AS total_subjects FROM tbl_subjects");
        rs = ps.executeQuery();
        if (rs.next()) {
            totalSubjects = rs.getInt("total_subjects");
        }

    } catch (Exception e) {
        out.println("ERROR: " + e.getMessage());
    } finally {
        try { if(rs != null) rs.close(); } catch(Exception e){}
        try { if(ps != null) ps.close(); } catch(Exception e){}
        try { if(con != null) con.close(); } catch(Exception e){}
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        body { margin: 0; font-family: Arial; background: #eef1f5; }

        .navbar {
            background: #2c3e50;
            padding: 15px 25px;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 3px 8px rgba(0,0,0,0.3);
        }

        .navbar a {
            color: white;
            margin-left: 20px;
            text-decoration: none;
            font-size: 16px;
            font-weight: bold;
            transition: 0.3s;
        }

        .navbar a:hover {
            color: #f39c12;
        }

        .content {
            padding: 40px;
        }

        .dashboard-cards {
            display: flex;
            justify-content: flex-start;
            gap: 30px;
            margin-top: 20px;
        }

        .card {
            width: 280px;
            padding: 30px;
            background: white;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
            transition: transform 0.2s;
        }

        .card:hover {
            transform: translateY(-5px);
        }

        .card h3 {
            font-size: 22px;
            color: #34495e;
            margin-bottom: 10px;
        }

        .card p {
            font-size: 36px;
            font-weight: bold;
            color: #2c3e50;
            margin: 0;
        }
    </style>
</head>
<body>

<div class="navbar">
    <div><b style="font-size: 20px;">Admin Dashboard</b></div>
    <div>
        <a href="AdminDashboard.jsp">Home</a>
        <a href="Reports.jsp">Reports</a>
        <a href="ManageSubjects.jsp">Subjects</a>
        <a href="ReportStaffDetails.jsp">Staff Details</a>
        <a href="../AdminLogout.jsp">Logout</a>
    </div>
</div>

<div class="content">
    <h2>Welcome, <%= session.getAttribute("admin") %> 👋</h2>

    <div class="dashboard-cards">
        
        <!-- Staff Card -->
        <div class="card">
            <h3>Total Staff</h3>
            <p><%= totalStaff %></p>
        </div>

        <!-- Subjects Card -->
        <div class="card">
            <h3>Total Subjects</h3>
            <p><%= totalSubjects %></p>
        </div>

    </div>
</div>

</body>
</html>
