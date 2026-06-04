<%@ page import="java.sql.*, com.sohel.smartattendencesystem.DataAccess" %>

<%
    String staffEmailId = (String) session.getAttribute("staffEmail");
    
    boolean isLoggedIn = (staffEmailId != null);
    
%>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
    .navbar {
        background-color: #007bff;
    }
    .navbar-brand {
        font-size: 1.5rem;
        font-weight: bold;
        color: white;
    }
    .nav-link {
        color: white !important;
        font-weight: 500;
        transition: 0.3s;
    }
    .nav-link:hover {
        color: #0056b3 !important;
    }
    .navbar-toggler {
        border-color: white;
    }
    .navbar-toggler-icon {
        background-color: white;
    }
    .user-info {
        display: flex;
        align-items: center;
        gap: 8px;
        cursor: pointer;
        font-weight: bold;
        color: white;
    }
    .user-icon {
        font-size: 1.2rem;
        color: white;
    }
    .modal-content {
        border-radius: 10px;
    }
</style>

<!-- Navigation Bar -->
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="">SmartAttendanceSystem</a>

        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <% if (isLoggedIn) {%>
                <li class="nav-item"><a class="nav-link" href="Index.jsp"><i class="fa fa-home"></i> Home</a></li>
                <li class="nav-item"><a class="nav-link" href="Attendance.jsp"><i class="fa fa-check-circle"></i> Attendance</a></li>
                <li class="nav-item"><a class="nav-link" href="ReportAttendance.jsp"><i class="fa fa-file-alt"></i> Reports</a></li>

                <!-- Show Logged-in Staff Email as a Clickable Link -->
                <li class="nav-item">
                    <span class="nav-link user-info" data-bs-toggle="modal" data-bs-target="#profileModal">
                        <i class="fa fa-user user-icon"></i> <%= staffEmailId%>
                    </span>
                </li>

                <li class="nav-item"><a href="Logout.jsp" class="btn btn-danger ms-2">Logout</a></li>
                    <% } else { %>
                <li class="nav-item"><a class="nav-link" href="StaffRegister.jsp"><i class="fa fa-user-plus"></i> Register</a></li>
                <li class="nav-item"><a class="nav-link" href="StaffLogin.jsp"><i class="fa fa-sign-in-alt"></i> Login</a></li>
                    <% } %>
            </ul>
        </div>
    </div>
</nav>

<!-- Profile Modal (Popup) -->
<div class="modal fade" id="profileModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header bg-primary text-white">
                <h5 class="modal-title"><i class="fa fa-user-circle"></i> My Profile</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <%
                    Connection Headerconn = null;
                    PreparedStatement stmt = null;
                    ResultSet Headerrs = null;

                    int staffId = 0;
                    String fullName = "", email = "", phone = "", subject = "", designation = "";

                    try {
                        Headerconn = DataAccess.getConnection();
                        String sql = "SELECT s.staff_id, s.full_name, s.email, s.phone, sub.subject_name, s.designation "
                                + "FROM tbl_staff s JOIN tbl_subjects sub ON s.subject = sub.subject_id WHERE s.email = ?";

                        stmt = Headerconn.prepareStatement(sql);
                        stmt.setString(1, staffEmailId);
                        Headerrs = stmt.executeQuery();

                        if (Headerrs.next()) {
                            staffId = Headerrs.getInt("staff_id");
                            fullName = Headerrs.getString("full_name");
                            email = Headerrs.getString("email");
                            phone = Headerrs.getString("phone");
                            subject = Headerrs.getString("subject_name");
                            designation = Headerrs.getString("designation");
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    } finally {
                        if (Headerrs != null) {
                            Headerrs.close();
                        }
                        if (stmt != null) {
                            stmt.close();
                        }
                        if (Headerconn != null) {
                            Headerconn.close();
                        }
                    }
                %>
                <div class="mb-3">
                    <strong>Full Name:</strong> <%= fullName%>
                </div>
                <div class="mb-3">
                    <strong>Email:</strong> <%= email%>
                </div>
                <div class="mb-3">
                    <strong>Phone:</strong> <%= phone%>
                </div>
                <div class="mb-3">
                    <strong>Subject:</strong> <%= subject%>
                </div>
                <div class="mb-3">
                    <strong>Designation:</strong> <%= designation%>
                </div>
            </div>
            <div class="modal-footer">
                <a href="UpdateProfile.jsp" class="btn btn-warning"><i class="fa fa-edit"></i> Edit Profile</a>
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
