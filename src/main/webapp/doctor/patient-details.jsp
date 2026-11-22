<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="com.meditrack.model.Patient"%>
<%@ page import="com.meditrack.dao.PatientDAO"%>
<%@ page import="java.util.List"%>
<%@ page import="com.meditrack.model.MedicalRecord"%>
<%@ page import="com.meditrack.dao.MedicalRecordDAO"%>

<%
String idParameter = request.getParameter("id");

Patient patient = null;
List<MedicalRecord> records = null;

if (idParameter != null && !idParameter.isEmpty()) {

	int id = Integer.parseInt(idParameter);

	PatientDAO patientDAO = new PatientDAO();

	patient = patientDAO.getPatientById(id);

	MedicalRecordDAO medicalRecordDAO = new MedicalRecordDAO();

	records = medicalRecordDAO.getRecordsByPatientId(id);
}
%>

<!DOCTYPE html>
<html>

<head>

<title>Patient Details - MediTrack</title>


<style>
body {
	margin: 0;
	font-family: Arial, sans-serif;
	background: #f5f7fb;
	color: #2c3e50;
}

.container {
	width: 85%;
	max-width: 1000px;
	margin: 40px auto;
}

.title {
	margin-bottom: 25px;
	font-size: 28px;
	color: #2c3e50;
	font-weight: 600;
}

.card {
	background: #ffffff;
	padding: 30px 35px;
	border-radius: 12px;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
	border: 1px solid #e8edf3;
}

.row {
	display: flex;
	align-items: center;
	min-height: 50px;
	margin-bottom: 8px;
	padding: 8px 12px;
	border-bottom: 1px solid #eef1f5;
	transition: background-color 0.2s ease;
}

.row:last-child {
	border-bottom: none;
}

.row:hover {
	background-color: #f8fafc;
	border-radius: 6px;
}

.label {
	width: 200px;
	font-weight: 600;
	color: #34495e;
	font-size: 15px;
}

.value {
	color: #5f6b7a;
	font-size: 15px;
	flex: 1;
}

.back-button {
	display: inline-block;
	margin-top: 25px;
	padding: 11px 20px;
	background-color: #2c3e50;
	color: white;
	text-decoration: none;
	border-radius: 6px;
	font-size: 14px;
	font-weight: 500;
	transition: background-color 0.2s ease, transform 0.2s ease;
}

.back-button:hover {
	background-color: #1abc9c;
	transform: translateY(-1px);
}

.not-found {
	background-color: #ffffff;
	padding: 25px;
	border-radius: 10px;
	color: #e74c3c;
	border: 1px solid #f5c6cb;
	box-shadow: 0 3px 10px rgba(0, 0, 0, 0.06);
	font-weight: 500;
}

.medical-history {
    display: flex;
    flex-direction: column;
    gap: 20px;
}

.history-card {
    background: #ffffff;
    padding: 25px;
    border-radius: 10px;
    border: 1px solid #e8edf3;
    box-shadow: 0 3px 12px rgba(0, 0, 0, 0.06);
}

.history-header {
    padding-bottom: 15px;
    margin-bottom: 15px;
    border-bottom: 2px solid #eef1f5;
    color: #2c3e50;
}

.history-row {
    display: flex;
    gap: 20px;
    padding: 10px 0;
    border-bottom: 1px solid #f0f2f5;
    color: #5f6b7a;
    line-height: 1.5;
}

.history-row:last-child {
    border-bottom: none;
}

.history-label {
    width: 150px;
    flex-shrink: 0;
    font-weight: 600;
    color: #34495e;
}

</style>


</head>

<body>

	<%@ include file="../navbar.jsp"%>

	<div class="container">

		<h2 class="title">Patient Details</h2>
	
		<a href="add-medical-record.jsp?patientId=<%= patient.getId() %>"
		   style="
		       display: inline-block;
		       margin-bottom: 20px;
		       padding: 11px 20px;
		       background-color: #1abc9c;
		       color: white;
		       text-decoration: none;
		       border-radius: 6px;
		       font-size: 14px;
		       font-weight: 600;
		   ">
		    + Add Medical Record
		</a>


		<%
		if (patient != null) {
		%>

		<div class="card">

			<div class="row">
				<div class="label">Patient ID</div>
				<div class="value">
					<%=patient.getId()%>
				</div>
			</div>

			<div class="row">
				<div class="label">Patient Code</div>
				<div class="value">
					<%=patient.getPatientCode()%>
				</div>
			</div>

			<div class="row">
				<div class="label">Name</div>
				<div class="value">
					<%=patient.getName()%>
				</div>
			</div>

			<div class="row">
				<div class="label">Date of Birth</div>
				<div class="value">
					<%=patient.getDateOfBirth()%>
				</div>
			</div>

			<div class="row">
				<div class="label">Gender</div>
				<div class="value">
					<%=patient.getGender()%>
				</div>
			</div>

			<div class="row">
				<div class="label">Phone</div>
				<div class="value">
					<%=patient.getPhone()%>
				</div>
			</div>

			<div class="row">
				<div class="label">Email</div>
				<div class="value">
					<%=patient.getEmail()%>
				</div>
			</div>

			<div class="row">
				<div class="label">Address</div>
				<div class="value">
					<%=patient.getAddress()%>
				</div>
			</div>

			<div class="row">
				<div class="label">Blood Group</div>
				<div class="value">
					<%=patient.getBloodGroup()%>
				</div>
			</div>

		</div>


		<h2 class="title" style="margin-top: 40px;">Medical History</h2>

		<%
		if (records != null && !records.isEmpty()) {
		%>

		<div class="medical-history">

			<%
			for (MedicalRecord record : records) {
			%>

			<div class="history-card">

				<div class="history-header">

					<div>
						<strong style="padding-right:85px"> Visit Date: </strong>

						<%=record.getVisitDate()%>
					</div>
					<div class="history-row">
					    <span class="history-label">Doctor</span>
					    <span style="color:green;  font-weight:bold"><%= record.getDoctorName() %></span>
					</div>
					
					

				</div>

				<div class="history-row">

					<span class="history-label"> Symptoms </span> <span> <%=record.getSymptoms()%>
					</span>

				</div>

				<div class="history-row">

					<span class="history-label"> Diagnosis </span> <span> <%=record.getDiagnosis()%>
					</span>

				</div>

				<div class="history-row">

					<span class="history-label"> Medicines </span> <span> <%=record.getMedicines()%>
					</span>

				</div>

				<div class="history-row">

					<span class="history-label"> Tests </span> <span> <%=record.getTests()%>
					</span>

				</div>

				<div class="history-row">

					<span class="history-label"> Doctor Notes </span> <span> <%=record.getDoctorNotes()%>
					</span>

				</div>

				<div class="history-row">

					<span class="history-label"> Follow-up Date </span> <span> <%=record.getFollowUpDate()%>
					</span>

				</div>

			</div>

			<%
			}
			%>

		</div>

		<%
		} else {
		%>

		<div class="not-found">No medical history found for this
			patient.</div>

		<%
		}
		%>

		<%
		} else {
		%>

		<div class="not-found">Patient not found.</div>

		<%
		}
		%>

		<a href="patients.jsp" class="back-button"> ← Back to Patients </a>

	</div>

</body>

</html>
