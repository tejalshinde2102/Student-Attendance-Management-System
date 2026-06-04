<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - Smart Attendance System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .about-container {
            max-width: 900px;
            margin: 50px auto;
            background: white;
            padding: 30px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }
        .header {
            text-align: center;
            margin-bottom: 30px;
        }
        .section {
            display: flex;
            align-items: center;
            margin: 20px 0;
        }
        .icon {
            width: 150px;
            height: 110px;
            margin-right: 15px;
        }
        .values {
            display: flex;
            justify-content: space-between;
        }
        .value-box {
            width: 30%;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 5px;
            text-align: center;
            box-shadow: 2px 2px 5px rgba(0,0,0,0.1);
        }
    </style>
</head>
<%@include file="WEB-INF/Header.jsp" %>

<body class="bg-light">
    <div class="container about-container">
        <div class="header">
            <h2 class="fw-bold">About Us</h2>
            <p class="text-muted">We are a team dedicated to simplifying attendance management using smart solutions.</p>
        </div>
        <div class="section">
            <img src="Images/Vision.png" alt="Vision" class="icon">
            <div>
                <h4 class="fw-bold">Vision</h4>
                <p>Our vision is to revolutionize attendance tracking with accuracy, efficiency, and ease.</p>
            </div>
        </div>
        <div class="section">
            <img src="Images/whoweare.jpg" alt="Who we are" class="icon">
            <div>
                <h4 class="fw-bold">Who We Are?</h4>
                <p>We are a passionate team of developers creating smart solutions for attendance management.</p>
            </div>
        </div>
        <div class="section">
            <img src="Images/WhyUs.png" alt="Why us" class="icon">
            <div>
                <h4 class="fw-bold">Why Us?</h4>
                <p>We combine expertise, innovation, and commitment to provide the best attendance tracking system.</p>
            </div>
        </div>
        <h3 class="fw-bold">Our Values</h3>
        <div class="values">
            <div class="value-box">
                <h5 class="fw-bold">Customer-first</h5>
                <p>We prioritize user experience and trust.</p>
            </div>
            <div class="value-box">
                <h5 class="fw-bold">Passion</h5>
                <p>We innovate to enhance efficiency.</p>
            </div>
            <div class="value-box">
                <h5 class="fw-bold">Speed & Innovation</h5>
                <p>We constantly improve for better results.</p>
            </div>
        </div>
    </div>
    <%@include file="WEB-INF/Footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
