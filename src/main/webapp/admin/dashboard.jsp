<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>

	    <meta charset="UTF-8">
	
	    <title>MediTrack - Admin Dashboard</title>
	
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
	            margin-bottom: 25px;
	        }
	
	        .welcome h1 {
	            margin-bottom: 5px;
	        }
	
	        .cards {
	            display: flex;
	            gap: 20px;
	        }
	
	        .card {
	            background-color: white;
	            width: 220px;
	            padding: 25px;
	            border-radius: 8px;
	            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
	        }
	
	        .card h3 {
	            margin-top: 0;
	        }
	
	        .card a {
	            text-decoration: none;
	            color: #2c3e50;
	            font-weight: bold;
	        }
	
	    </style>
	
	</head>
	<body>
		<%@ include file="../navbar.jsp" %>

	    <div class="container">
	
	        <div class="welcome">
	
	            <h1>Admin Dashboard</h1>
	
	            <p>Welcome to MediTrack Admin Panel.</p>
	
	        </div>
	
	
	        <div class="cards">
	
	            <div class="card">
	
	                <h3>Doctors</h3>
	
	                <p>Manage doctors</p>
	
	                <a href="manage-doctors.jsp">Manage Doctors</a>
	
	            </div>
	
	
	            <div class="card">
	
	                <h3>Patients</h3>
	
	                <p>View and manage patients</p>
	
	                <a href="#">Manage Patients</a>
	
	            </div>
	
	
	            <div class="card">
	
	                <h3>Appointments</h3>
	
	                <p>View appointments</p>
	
	                <a href="#">View Appointments</a>
	
	            </div>
	
	
	            <div class="card">
	
	                <h3>Medical Records</h3>
	
	                <p>View patient medical records</p>
	
	                <a href="#">View Records</a>
	
	            </div>
	
	        </div>
	
	    	</div>
	
	</body>
</html>