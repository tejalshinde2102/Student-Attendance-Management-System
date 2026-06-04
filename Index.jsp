<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String sEmailId = (String) session.getAttribute("staffEmail");
    if (sEmailId == null) {
        response.sendRedirect("StaffLogin.jsp");
        return;
    }
    boolean IsLoggedIn = (sEmailId != null);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Smart Attendance System - Home</title>

    <!-- Bootstrap (Only for Grid & JS) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <style>
        /* Global Styles */
        body {
            font-family: Arial, sans-serif;
            background-color: #fdfdfd;
            color: #4a4a4a;
            margin: 0;
            padding: 0;
        }

        /* Hero Section */
        .hero-section {
            background: linear-gradient(135deg, #e6e9f0, #eef1f5);
            text-align: center;
            padding: 60px 20px;
            color: #333;
        }
        .hero-title {
            font-size: 2.5rem;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .hero-text {
            font-size: 1.2rem;
            opacity: 0.9;
        }

        /* Carousel */
        .carousel-item img {
            height: 450px;
            object-fit: cover;
            border-radius: 10px;
        }

        /* Features Section */
        .features-section {
            padding: 60px 20px;
            text-align: center;
            border-bottom: 2px solid darkseagreen;
        }
        .feature-card {
            background: #ffffff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            max-width: 350px;
            margin: 20px auto;
        }
        .feature-card:hover {
            transform: translateY(-5px);
            box-shadow: 0px 8px 20px rgba(0, 0, 0, 0.15);
        }
        .feature-icon {
            font-size: 50px;
            color: #b2d8d8;
        }
        .feature-title {
            font-size: 1.5rem;
            margin-top: 15px;
            font-weight: bold;
        }
        .feature-text {
            font-size: 1rem;
            color: #666;
        }
          /* Call to Action */
        .cta-section {
            text-align: center;
            padding: 50px 20px;
            background-color: #e6e9f0;
            color: #333;
        }
        .cta-title {
            font-size: 2rem;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .cta-text {
            font-size: 1.2rem;
            opacity: 0.9;
        }
    </style>
</head>
<body>

    <%@include file="WEB-INF/Header.jsp" %>

<!-- Hero Section -->
<section class="hero-section">
    <h1 class="hero-title">Welcome to Smart Attendance System</h1>
    <p class="hero-text">Effortless, Secure, and Smart Attendance Management for Institutions</p>
</section>

<!-- Carousel Section -->
<div id="featuresCarousel" class="carousel slide container mt-4" data-bs-ride="carousel">
    <div class="carousel-inner">
        <div class="carousel-item active">
            <img src="Images/CarouselMain.png" class="d-block w-100" alt="WelCome">
            <div class="carousel-caption d-none d-md-block">
                <h4 class="bg-white text-dark">SMART ATTENDANCE SYSTEM</h4>
                <p class="bg-white text-dark">Welcome to the Smart World..!!</p>
            </div>
        </div>
        <div class="carousel-item">
            <img src="Images/Carousel1.png" class="d-block w-100" alt="Easy Attendance">
            <div class="carousel-caption d-none d-md-block">
                <h4 class="bg-white text-dark">Easy Attendance</h4>
                <p class="bg-white text-dark">Mark attendance quickly and efficiently.</p>
            </div>
        </div>
        <div class="carousel-item">
            <img src="Images/Carousel2.png" class="d-block w-100" alt="Detailed Reports">
            <div class="carousel-caption d-none d-md-block">
                <h5 class="bg-white text-dark">Detailed Reports</h5>
                <p class="bg-white text-dark">Get insightful reports with real-time data.</p>
            </div>
        </div>
        <div class="carousel-item">
            <img src="Images/Carousel3.png" class="d-block w-100" alt="Secure System">
            <div class="carousel-caption d-none d-md-block">
                <h5 class="bg-white text-dark">Secure System</h5>
                <p class="bg-white text-dark">Ensure privacy and security of attendance data.</p>
            </div>
        </div>
    </div>
    <button class="carousel-control-prev" type="button" data-bs-target="#featuresCarousel" data-bs-slide="prev">
        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    </button>
    <button class="carousel-control-next" type="button" data-bs-target="#featuresCarousel" data-bs-slide="next">
        <span class="carousel-control-next-icon" aria-hidden="true"></span>
    </button>
</div>
<!-- How It Works -->
<section class="features-section" >
    <div class="container">
        <h2 class="text-center mb-4">How It Works</h2>
        <div class="row">
            <div class="col-md-3">
                <div class="feature-card">
                    <i class="fa fa-user-plus feature-icon"></i>
                    <h4 class="feature-title">Register</h4>
                    <p class="feature-text">Staff can register easily using their credentials.</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="feature-card">
                    <i class="fa fa-book feature-icon"></i>
                    <h4 class="feature-title">Go To Attendence page</h4>
                    <p class="feature-text">Choose the class or lecture for marking attendance.</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="feature-card">
                    <i class="fa fa-check-square feature-icon"></i>
                    <h4 class="feature-title">Mark Attendance</h4>
                    <p class="feature-text">Enter Student Name choose Subject and Submit.</p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="feature-card">
                    <i class="fa fa-download feature-icon"></i>
                    <h4 class="feature-title">Check Report</h4>
                    <p class="feature-text">Generate attendance reports anytime in Reports Section.</p>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Features Section -->
<section class="features-section">
    <div class="container">
        <h2 class="text-center mb-4">Why Choose Smart Attendance?</h2>
        <div class="row">
            <div class="col-md-4">
                <div class="feature-card">
                    <i class="fa fa-user-check feature-icon"></i>
                    <h4 class="feature-title">Real-Time Tracking</h4>
                    <p class="feature-text">Monitor attendance instantly with live data.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-card">
                    <i class="fa fa-user-shield feature-icon"></i>
                    <h4 class="feature-title">Duplicate Attendance</h4>
                    <p class="feature-text">It eliminates fake attendance.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-card">
                    <i class="fa fa-file-alt feature-icon"></i>
                    <h4 class="feature-title">Custom Attendance Reports</h4>
                    <p class="feature-text">Generate reports based on date, subject, and student.</p>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Features Section -->
<section class="features-section">
    <div class="container">
        <h2 class="text-center mb-4">Features</h2>
        <div class="row">
            <div class="col-md-4">
                <div class="feature-card">
                    <i class="fa fa-user-check feature-icon"></i>
                    <h4 class="feature-title">Easy Attendance</h4>
                    <p class="feature-text">Mark attendance in just a few clicks with a streamlined interface.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-card">
                    <i class="fa fa-chart-bar feature-icon"></i>
                    <h4 class="feature-title">Detailed Reports</h4>
                    <p class="feature-text">Generate attendance reports with real-time insights.</p>
                </div>
            </div>
            <div class="col-md-4">
                <div class="feature-card">
                    <i class="fa fa-lock feature-icon"></i>
                    <h4 class="feature-title">Secure System</h4>
                    <p class="feature-text">Ensures data privacy and security for all attendance records.</p>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- Testimonials -->
<section class="cta-section">
    <h2 class="cta-title">What Our Users Say</h2>
    <p class="cta-text"><i class="fa fa-quote-left"></i> The Smart Attendance System has made our institution's attendance tracking seamless and efficient. Highly recommend it! <i class="fa fa-quote-right"></i></p>
<!--    <p class="cta-text"><strong>- Prof. A. Sharma, Principal</strong></p>-->
</section>

<!-- Call to Action -->
<section class="cta-section">
    <h2 class="cta-title">Start Managing Attendance Today!</h2>
    <p class="cta-text">Join us and make attendance tracking easier than ever.</p>
</section>

<%@include file="WEB-INF/Footer.jsp" %>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
