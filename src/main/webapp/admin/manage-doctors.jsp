<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.meditrack.model.Doctor" %>
<%@ page import="com.meditrack.dao.DoctorDAO" %>

<%
    DoctorDAO doctorDAO = new DoctorDAO();

    List<Doctor> doctors = doctorDAO.getAllDoctors();
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>MediTrack - Manage Doctors</title>

    <style>

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
        }

        .container {
            padding: 30px;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .header h1 {
            margin: 0;
        }

        .add-button {
            background-color: #2c3e50;
            color: white;
            padding: 10px 18px;
            text-decoration: none;
            border-radius: 5px;
        }

        table {
            width: 100%;
            background-color: white;
            border-collapse: collapse;
        }

        th, td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }

        th {
            background-color: #2c3e50;
            color: white;
        }

        .edit {
            color: #2980b9;
            text-decoration: none;
            margin-right: 10px;
        }

        .delete {
            color: #c0392b;
            text-decoration: none;
        }

    </style>

</head>

<body>
		<%
	    String success = request.getParameter("success");
	%>
	
	<% if ("added".equals(success)) { %>
	
	    <p style="color: green;">
	        Doctor added successfully!
	    </p>
	
	<% } %>

    <%@ include file="../navbar.jsp" %>

    <div class="container">

        <div class="header">

            <h1>Manage Doctors</h1>

            <a href="add-doctor.jsp" class="add-button">
                + Add Doctor
            </a>

        </div>


        <table>

            <thead>

                <tr>
                    <th>ID</th>
                    <th>Doctor Code</th>
                    <th>Name</th>
                    <th>Specialization</th>
                    <th>Phone</th>
                    <th>Qualification</th>
                    <th>Action</th>
                </tr>

            </thead>

            <tbody>

			    <% for (Doctor doctor : doctors) { %>
			
			        <tr>
			
			            <td><%= doctor.getId() %></td>
			
			            <td><%= doctor.getDoctorCode() %></td>
			
			            <td><%= doctor.getName() %></td>
			
			            <td><%= doctor.getSpecialization() %></td>
			
			            <td><%= doctor.getPhone() %></td>
			
			            <td><%= doctor.getQualification() %></td>
			
			            <td>
			                <a href="#" class="edit">Edit</a>
			
			                <a href="#" class="delete">Delete</a>
			            </td>
			
			        </tr>
			
			    <% } %>
			
			</tbody>

        </table>

    </div>

</body>

</html>
