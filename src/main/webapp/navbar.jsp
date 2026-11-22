<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<style>

    .navbar {
        width: 100%;
        height: 60px;
        background-color: #2c3e50;

        display: flex;
        align-items: center;
        justify-content: space-between;

        padding: 0 30px;
        box-sizing: border-box;
    }

    .logo {
        color: white;
        font-size: 22px;
        font-weight: bold;
    }

    .nav-links {
        display: flex;
        gap: 25px;
    }

    .nav-links a {
        color: white;
        text-decoration: none;
        font-size: 16px;
    }

    .nav-links a:hover {
        color: #1abc9c;
    }

</style>
	</head>
	<body>
		
<nav class="navbar">

    <div class="logo">
        🏥 MediTrack
    </div>

    <div class="nav-links">
        <a href="dashboard.jsp">Dashboard</a>
        <a href="patients.jsp">Patients</a>
        <a href="appointments.jsp">Appointments</a>
        <a href="medical-records.jsp">Medical Records</a>
        <a href="logout">Logout</a>
    </div>

</nav>

	</body>
</html>