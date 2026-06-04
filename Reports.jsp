<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Reports Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <style>
        .card {
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
            transition: transform 0.2s;
        }
        .card:hover {
            transform: scale(1.05);
        }
        .card-title {
            font-weight: bold;
        }
        .btn-report {
            width: 100%;
        }
        .icon {
            font-size: 50px;
            color: #007bff;
            margin-bottom: 15px;
        }
          .navbar {
            background: #343a40;
            padding: 15px;
            color: white;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .navbar a {
            color: white;
            margin-right: 20px;
            text-decoration: none;
            font-size: 16px;
        }

        .navbar a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

 <div class="navbar">
    <div>
        <b>Admin Dashboard</b>
    </div>

    <div>
        <a href="AdminDashboard.jsp">Home</a>
        <a href="Reports.jsp">Reports</a>
        <a href="ManageSubjects.jsp">Subjects</a>
        <a href="ReportStaffDetails.jsp">Staff Details</a>
        <a href="../AdminLogout.jsp">Logout</a>
    </div>
</div>
        
    <div class="container mt-5">
        <h2 class="text-center mb-4">📊 Reports Dashboard</h2>
        <p class="text-center text-muted">Select a report below to view details.</p>
        
        <div class="row">
            <!-- Attendance Report -->
            <div class="col-md-6 mb-4">
                <div class="card text-center p-3">
                    <i class="fas fa-user-check icon"></i>
                    <div class="card-body">
                        <h5 class="card-title">Attendance Report</h5>
                        <p class="card-text">View attendance report by selecting a subject and date.</p>
                        <a href="ReportAttendance.jsp" class="btn btn-primary btn-report">View Report</a>
                    </div>
                </div>
            </div>
            
            <!-- Contact Us Messages Report -->
            <div class="col-md-6 mb-4">
                <div class="card text-center p-3">
                    <i class="fas fa-envelope icon"></i>
                    <div class="card-body">
                        <h5 class="card-title">Contact Us Messages</h5>
                        <p class="card-text">View all messages submitted via the contact form.</p>
                        <a href="ReportContactUs.jsp" class="btn btn-primary btn-report">View Report</a>
                    </div>
                </div>
            </div>
            
            <!-- Staff Details Report -->
            <div class="col-md-6 mb-4">
                <div class="card text-center p-3">
                    <i class="fas fa-chalkboard-teacher icon"></i>
                    <div class="card-body">
                        <h5 class="card-title">Staff Details Report</h5>
                        <p class="card-text">View staff details along with their subjects.</p>
                        <a href="ReportStaffDetails.jsp" class="btn btn-primary btn-report">View Report</a>
                    </div>
                </div>
            </div>
            
            <!-- Student Report -->
            <div class="col-md-6 mb-4">
                <div class="card text-center p-3">
                    <i class="fas fa-user-graduate icon"></i>
                    <div class="card-body">
                        <h5 class="card-title">Student Attendance Report</h5>
                        <p class="card-text">Generate a report for a specific student within a date range.</p>
                        <a href="ReportStudentTotalAttendance.jsp" class="btn btn-primary btn-report">View Report</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
