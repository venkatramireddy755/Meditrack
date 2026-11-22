<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.meditrack.model.User" %>

<%
    User user = (User) session.getAttribute("user");

    if (user == null) {

        response.sendRedirect("../login.jsp");

        return;
    }
%>

<!DOCTYPE html>
<html>

	<head>
	
	    <meta charset="UTF-8">
	
	    <title>MediTrack - Doctor Dashboard</title>
	
	    <style>
	
	        body {
	            margin: 0;
	            font-family: Arial, sans-serif;
	            background-color: #f4f6f8;
	        }
	
	        .container {
	            padding: 30px;
	        }
	
	        .welcome {
	            background-color: white;
	            padding: 25px;
	            border-radius: 8px;
	            margin-bottom: 25px;
	            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
	        }
	
	        .welcome h1 {
	            margin-top: 0;
	        }
	
	        .cards {
	            display: flex;
	            gap: 20px;
	            flex-wrap: wrap;
	        }
	
	        .card {
	            background-color: white;
	            width: 220px;
	            padding: 25px;
	            border-radius: 8px;
	            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
	        }
	
	        .card h3 {
	            margin-top: 0;
	        }
	
	        .card a {
	            color: #2c3e50;
	            text-decoration: none;
	            font-weight: bold;
	        }
	
	    </style>
	
	</head>
	
	<body>
	
	    <%@ include file="../navbar.jsp" %>
	
	
	    <div class="container">
	
	        <div class="welcome">
	
	            <h1>Doctor Dashboard</h1>
	
	            <p>
	                Welcome, <strong><%= user.getEmail() %></strong>
	            </p>
	
	            <p>
	                Manage your patients and their medical records
	                from here.
	            </p>
	
	        </div>
	
	
	        <div class="cards">
	
	            <div class="card">
	
	                <h3>Patients</h3>
	
	                <p>
	                    Search and view patient information.
	                </p>
	
	                <a href="patients.jsp">
	                    View Patients
	                </a>
	
	            </div>
	
	
	            <div class="card">
	
	                <h3>Medical Records</h3>
	
	                <p>
	                    Add and view patient medical history.
	                </p>
	
	                <a href="#">
	                    Medical Records
	                </a>
	
	            </div>
	
	
	            
				<div class="card">
				
				    <h3>Appointments</h3>
				
				    <p>
				        Schedule new appointments and view your scheduled appointments.
				    </p>
				
				    <a href="add-appointment.jsp">
				        + Add Appointment
				    </a>
				
				    <br><br>
				
				    <a href="appointments.jsp">
				        View Appointments
				    </a>
				
				</div>

	
	        </div>
	
	    </div>
	
	</body>

</html>
