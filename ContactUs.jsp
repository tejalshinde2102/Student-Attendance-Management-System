<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="com.sohel.smartattendencesystem.ContactUs" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Contact Us - Smart Attendance System</title>

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #fdfdfd;
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
            }

            /* Contact Section */
            .contact-section {
                padding: 60px 20px;
            }
            .contact-card {
                background: #ffffff;
                padding: 30px;
                border-radius: 10px;
                box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.1);
            }
            .contact-info {
                font-size: 1.1rem;
                color: #555;
            }
            .form-control {
                border-radius: 5px;
            }
            .btn-custom {
                background-color: #b2d8d8;
                color: #333;
                font-size: 1.1rem;
                padding: 10px 20px;
                border-radius: 5px;
                font-weight: bold;
                border: none;
                transition: 0.3s ease-in-out;
            }
            .btn-custom:hover {
                background-color: #a0c4c4;
            }

            /* Google Map */
            .map-container {
                width: 100%;
                height: 300px;
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.1);
            }

            /* Contact Image */
            .contact-image-container {
                text-align: center;
                margin-top: 30px;
            }
            .contact-image {
                max-width: 100%;
                height: auto;
                border-radius: 10px;
                box-shadow: 0px 5px 15px rgba(0, 0, 0, 0.1);
            }
            .contact-card.contact-info-card {
                background: url('Images/contact-us.jpg') no-repeat center center;
                background-size: cover;
                color: white;
                position: relative;
                overflow: hidden;
            }

            .contact-card.contact-info-card::before {
                content: "";
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0, 0, 0, 0.6); /* Dark overlay for readability */
                border-radius: 10px;
            }

            .contact-card.contact-info-card * {
                position: relative;
                z-index: 1;
            }

        </style>
    </head>
    <body>

        <%@include file="WEB-INF/Header.jsp" %>

        <!-- Process Contact Form Submission -->
        <%
            if (request.getMethod().equalsIgnoreCase("POST")) {
                String name = request.getParameter("name");
                String emailid = request.getParameter("email");
                String message = request.getParameter("message");

                ContactUs contact = new ContactUs(name, emailid, message);
                boolean isSaved = contact.saveMessage();

                if (isSaved) {
        %>
        <script>
            alert("Your message has been sent successfully!");
            window.location.href = "ContactUs.jsp";
        </script>
        <%
        } else {
        %>
        <script>
            alert("An error occurred. Please try again.");
        </script>
        <%
                }
            }
        %>

        <!-- Hero Section -->
        <section class="hero-section">
            <h1 class="hero-title">Get in Touch</h1>
            <p>We’d love to hear from you! Feel free to reach out to us.</p>
        </section>

        <!-- Contact Section -->
        <section class="contact-section">
            <div class="container">
                <div class="row">
                    <!-- Contact Info -->
                    <div class="col-md-5">
                        <div class="contact-card contact-info-card">
                            <h3 class="text-center mb-3"><i class="fa fa-phone"></i> Contact Info</h3>
                            <p class="contact-info text-white"><i class="fa fa-map-marker-alt"></i> Shivraj College, Gadhinglaj, Maharashtra, India</p>
                            <p class="contact-info text-white""><i class="fa fa-envelope"></i> support@smartattendance.com</p>
                            <p class="contact-info text-white""><i class="fa fa-phone"></i> +91 98765 43210</p>
                            <p class="contact-info text-white""><i class="fa fa-clock"></i> Mon - Fri: 9:00 AM - 6:00 PM</p>
                        </div>
                    </div>


                    <!-- Contact Form -->
                    <div class="col-md-7">
                        <div class="contact-card">
                            <h3 class="text-center mb-3"><i class="fa fa-envelope"></i> Send a Message</h3>
                            <form action="ContactUs.jsp" method="post">
                                <div class="mb-3">
                                    <label class="form-label">Your Name</label>
                                    <input type="text" class="form-control" name="name" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Your Email</label>
                                    <input type="email" class="form-control" name="email" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Your Message</label>
                                    <textarea class="form-control" name="message" rows="4" required></textarea>
                                </div>
                                <button type="submit" class="btn btn-success btn-custom w-100">Send Message</button>
                            </form>
                        </div>
                    </div>
                </div>

                <!-- Google Map -->
                <!-- Google Map -->
                <div class="row mt-5">
                    <div class="col-md-12">
                        <div class="map-container">
                             <iframe 
                src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3876.2452782386554!2d74.34355617591774!3d16.224892184469595!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3bc098d86ec7d43f%3A0x9e7d2c29113464a!2sShivraj%20College%20Of%20Arts%2C%20Commerce%20%26%20DS%2C%20Gadhinglaj!5e0!3m2!1sen!2sin!4v1709386001234!5m2!1sen!2sin"
                width="100%" 
                height="400" 
                style="border:0;" 
                allowfullscreen="" 
                loading="lazy" 
                referrerpolicy="no-referrer-when-downgrade">
            </iframe>
                        </div>
                    </div>
                </div>

            </div>
        </section>

        <%@include file="WEB-INF/Footer.jsp" %>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

    </body>
</html>
