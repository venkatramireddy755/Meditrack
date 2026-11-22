<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.meditrack.model.Patient" %>
<%@ page import="com.meditrack.dao.PatientDAO" %>

<%
    String keyword = request.getParameter("keyword");

    PatientDAO patientDAO = new PatientDAO();

    List<Patient> patients;

    if (keyword != null && !keyword.trim().isEmpty()) {

        patients = patientDAO.searchPatients(keyword);

    } else {

        patients = patientDAO.getAllPatients();
    }
%>

<!DOCTYPE html>
<html>

	<head>
	
	    <meta charset="UTF-8">
	
	    <title>MediTrack - Patients</title>
	
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
	
	        th,
	        td {
	            padding: 12px;
	            border-bottom: 1px solid #ddd;
	            text-align: left;
	        }
	
	        th {
	            background-color: #2c3e50;
	            color: white;
	        }
	
	        .view {
	            color: #2980b9;
	            text-decoration: none;
	            font-weight: bold;
	        }
	
	    </style>
	
	</head>
	
	<body>
		<%
		    String success = request.getParameter("success");
		%>
		
		<% if ("added".equals(success)) { %>
		
		    <p style="color: green;">
		        Patient added successfully!
		    </p>
		
		<% } %>
	
	    <%@ include file="../navbar.jsp" %>
	
	
	    <div class="container">
	
	        <div class="header">
	
	            <h1>Patients</h1>
	
	            <a href="add-patient.jsp"
	               class="add-button">
	                + Add Patient
	            </a>
	
	        </div>
	        
	        
			<form action="patients.jsp" method="get"
			      style="margin-bottom: 20px;">
			
			    <input type="text"
			           name="keyword"
			           placeholder="Search by patient code, name or phone"
			           value="<%= keyword != null ? keyword : "" %>"
			           style="width: 350px; padding: 10px;">
			
			    <button type="submit"
			            style="padding: 10px 18px;">
			        Search
			    </button>
			
			    <a href="patients.jsp"
			       style="margin-left: 10px;">
			        Clear
			    </a>
			
			</form>

	
	
	        <table>
	
	            <thead>
	
	                <tr>
	
	                    <th>ID</th>
	                    <th>Patient Code</th>
	                    <th>Name</th>
	                    <th>Gender</th>
	                    <th>Phone</th>
	                    <th>Blood Group</th>
	                    <th>Action</th>
	
	                </tr>
	
	            </thead>
	
	
	            <tbody>
	
	                <% for (Patient patient : patients) { %>
	
	                    <tr>
	
	                        <td>
	                            <%= patient.getId() %>
	                        </td>
	
	                        <td>
	                            <%= patient.getPatientCode() %>
	                        </td>
	
	                        <td>
	                            <%= patient.getName() %>
	                        </td>
	
	                        <td>
	                            <%= patient.getGender() %>
	                        </td>
	
	                        <td>
	                            <%= patient.getPhone() %>
	                        </td>
	
	                        <td>
	                            <%= patient.getBloodGroup() %>
	                        </td>
	
	                        <td>
	
	                            
								<a href="patient-details.jsp?id=<%= patient.getId() %>"
								   class="view">
								    View
								</a>

	
	                        </td>
	
	                    </tr>
	
	                <% } %>
	
	            </tbody>
	
	        </table>
	
	    </div>
	
	</body>

</html>
