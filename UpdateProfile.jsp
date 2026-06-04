<%@ page import="java.sql.*, com.sohel.smartattendencesystem.DataAccess" %> 
<%@ page contentType="text/html; charset=UTF-8" %>

<%
    String staffEmail = (String) session.getAttribute("staffEmail");

    if (staffEmail == null) {
        response.sendRedirect("StaffLogin.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    int staffId = 0;
    String fullName = "", email = "", phone = "", subject = "", designation = "";
    int subjectId = 0;

    try {
        conn = DataAccess.getConnection();
        String sql = "SELECT s.staff_id, s.full_name, s.email, s.phone, sub.subject_id, sub.subject_name, s.designation " +
                     "FROM tbl_staff s JOIN tbl_subjects sub ON s.subject = sub.subject_id WHERE s.email = ?";

        stmt = conn.prepareStatement(sql);
        stmt.setString(1, staffEmail);
        rs = stmt.executeQuery();

        if (rs.next()) {
            staffId = rs.getInt("staff_id");
            fullName = rs.getString("full_name");
            email = rs.getString("email");
            phone = rs.getString("phone");
            subjectId = rs.getInt("subject_id");
            subject = rs.getString("subject_name");
            designation = rs.getString("designation");
        }
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }

    if (request.getMethod().equalsIgnoreCase("POST")) {
        try {
            conn = DataAccess.getConnection();

            staffId = Integer.parseInt(request.getParameter("staff_id"));
            fullName = request.getParameter("full_name");
            phone = request.getParameter("phone");
            subjectId = Integer.parseInt(request.getParameter("subject"));
            designation = request.getParameter("designation");

            String updateSQL = "UPDATE tbl_staff SET full_name=?, phone=?, subject=?, designation=? WHERE staff_id=?";
            stmt = conn.prepareStatement(updateSQL);
            stmt.setString(1, fullName);
            stmt.setString(2, phone);
            stmt.setInt(3, subjectId);
            stmt.setString(4, designation);
            stmt.setInt(5, staffId);

            int rowsUpdated = stmt.executeUpdate();

            if (rowsUpdated > 0) {
                response.sendRedirect("UpdateProfile.jsp?success=true");
            } else {
                response.sendRedirect("UpdateProfile.jsp?error=true");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            if (stmt != null) stmt.close();
            if (conn != null) conn.close();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Staff Profile</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <style>
        .profile-card {
            max-width: 500px;
            margin: auto;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
        }
        .profile-card-header {
            background-color: #007bff;
            color: white;
            text-align: center;
            padding: 15px;
            font-size: 1.3rem;
            font-weight: bold;
            border-top-left-radius: 10px;
            border-top-right-radius: 10px;
        }
        .profile-card-body {
            padding: 20px;
        }
        .form-label {
            font-weight: bold;
        }
        .btn-save {
            width: 100%;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="card profile-card">
            <div class="profile-card-header">
                <i class="fa fa-user-circle"></i> Staff Profile
            </div>
            <div class="card-body profile-card-body">
                <%
                    if (request.getParameter("success") != null) {
                        out.println("<div class='alert alert-success'>Profile updated successfully!</div>");
                    }
                    if (request.getParameter("error") != null) {
                        out.println("<div class='alert alert-danger'>Failed to update profile. Try again!</div>");
                    }
                %>

                <form action="UpdateProfile.jsp" method="post">
                    <input type="hidden" name="staff_id" value="<%= staffId %>">

                    <div class="mb-3">
                        <label class="form-label">Full Name</label>
                        <input type="text" name="full_name" class="form-control" value="<%= fullName %>" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" name="email" class="form-control" value="<%= email %>" readonly>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Phone</label>
                        <input type="text" name="phone" class="form-control" value="<%= phone %>" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Subject</label>
                        <select name="subject" class="form-control" required>
                            <%
                                Connection conn2 = null;
                                PreparedStatement stmt2 = null;
                                ResultSet rs2 = null;

                                try {
                                    conn2 = DataAccess.getConnection();
                                    String subjectQuery = "SELECT subject_id, subject_name FROM tbl_subjects";
                                    stmt2 = conn2.prepareStatement(subjectQuery);
                                    rs2 = stmt2.executeQuery();

                                    while (rs2.next()) {
                                        int subId = rs2.getInt("subject_id");
                                        String subName = rs2.getString("subject_name");
                                        String selected = (subId == subjectId) ? "selected" : "";
                            %>
                            <option value="<%= subId %>" <%= selected %>><%= subName %></option>
                            <%
                                    }
                                } catch (SQLException e) {
                                    e.printStackTrace();
                                } finally {
                                    if (rs2 != null) rs2.close();
                                    if (stmt2 != null) stmt2.close();
                                    if (conn2 != null) conn2.close();
                                }
                            %>
                        </select>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Designation</label>
                        <input type="text" name="designation" class="form-control" value="<%= designation %>" required>
                    </div>

                    <button type="submit" class="btn btn-success btn-save">Save Changes</button>
                    
                    <!-- Back to Profile Button -->
                    <button type="button" class="btn btn-secondary mt-2" onclick="window.location.href='Index.jsp'">
                        <i class="fa fa-arrow-left"></i> Back to Home
                    </button>

                </form>
            </div>
        </div>
    </div>
</body>
</html>
