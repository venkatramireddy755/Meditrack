
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="com.meditrack.model.User"%>
<%@ page import="com.meditrack.model.Appointment"%>
<%@ page import="com.meditrack.dao.AppointmentDAO"%>
<%@ page import="com.meditrack.dao.DoctorDAO"%>

<%
User user = (User) session.getAttribute("user");

if (user == null) {
	response.sendRedirect("../login.jsp");
	return;
}
%>

<%
String keyword = request.getParameter("keyword");
String date = request.getParameter("date");
String status = request.getParameter("status");

List<Appointment> appointments = null;
String errorMessage = null;

try {

	AppointmentDAO appointmentDAO = new AppointmentDAO();
	DoctorDAO doctorDAO = new DoctorDAO();

	int doctorId = doctorDAO.getDoctorIdByUserId(user.getId());

	if (doctorId <= 0) {
		throw new Exception("Doctor profile not found.");
	}

	appointments = appointmentDAO.filterAppointments(doctorId, keyword, date, status);

} catch (Exception e) {

	e.printStackTrace();
	errorMessage = "Unable to load appointments.";
}
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MediTrack - Appointments</title>

<style>
body {
	margin: 0;
	font-family: Arial, sans-serif;
	background: #f4f6f8;
}

.container {
	padding: 30px;
}

.header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 20px;
}

.header a {
	background: #2c7be5;
	color: white;
	padding: 10px 16px;
	text-decoration: none;
	border-radius: 5px;
}

.message {
	background: #d4edda;
	color: #155724;
	padding: 12px;
	border-radius: 5px;
	margin-bottom: 15px;
}

.error {
	background: #f8d7da;
	color: #721c24;
	padding: 12px;
	border-radius: 5px;
	margin-bottom: 15px;
}

.table-container {
	background: white;
	padding: 20px;
	border-radius: 8px;
	overflow-x: auto;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.08);
}

table {
	width: 100%;
	border-collapse: collapse;
}

th, td {
	padding: 13px;
	text-align: left;
	border-bottom: 1px solid #ddd;
}

th {
	background: #2c3e50;
	color: white;
}

.status {
	color: #198754;
	font-weight: bold;
}

.empty {
	text-align: center;
	padding: 25px;
	color: #777;
}
</style>
</head>

<body>

	<%@ include file="../navbar.jsp"%>

	<div class="container">

		<div class="header">
			<h2>Appointment Management</h2>
			<a href="add-appointment.jsp">+ Add Appointment</a>
		</div>

		<div class="search-container">

			<form action="appointments.jsp" method="get">

				<!-- Search by patient name or phone -->
				<input type="text" name="keyword"
					placeholder="Patient name or phone"
					value="<%=keyword == null ? "" : keyword%>"
					style="padding: 10px; margin: 5px;">

				<!-- Filter by appointment date -->
				<input type="date" name="date"
					value="<%=date == null ? "" : date%>"
					style="padding: 10px; margin: 5px;">

				<!-- Filter by appointment status -->
				<select name="status" style="padding: 10px; margin: 5px;">

					<option value="">All Statuses</option>

					<option value="SCHEDULED"
						<%="SCHEDULED".equals(status) ? "selected" : ""%>>
						Scheduled</option>

					<option value="COMPLETED"
						<%="COMPLETED".equals(status) ? "selected" : ""%>>
						Completed</option>

					<option value="CANCELLED"
						<%="CANCELLED".equals(status) ? "selected" : ""%>>
						Cancelled</option>

				</select>

				<button type="submit"
					style="padding: 10px 18px; background: #2c7be5; color: white; border: none; border-radius: 5px;">
					Apply Filters</button>

				<a href="appointments.jsp"
					style="margin-left: 10px; text-decoration: none;"> Clear
					Filters </a>

			</form>

		</div>


		<%
		if ("added".equals(request.getParameter("success"))) {
		%>
		<div class="message">Appointment added successfully!</div>
		<%
		}
		%>
		<%
		if ("updated".equals(request.getParameter("success"))) {
		%>
		<div class="message">Appointment status updated successfully!</div>
		<%
		}
		%>

		<%
		if (request.getParameter("error") != null) {
		%>
		<div class="error">Unable to update appointment. Please try
			again.</div>
		<%
		}
		%>

		<%
		if (errorMessage != null) {
		%>
		<div class="error">
			<%=errorMessage%>
		</div>
		<%
		} else {
		%>

		<div class="table-container">

			<table>
				<tr>
					<th>ID</th>
					<th>Patient</th>
					<th>Doctor</th>
					<th>Date</th>
					<th>Time</th>
					<th>Reason</th>
					<th>Status</th>
					<th>Update Status</th>
				</tr>

				<%
				if (appointments.isEmpty()) {
				%>
				<tr>
					<td colspan="8" class="empty">No appointments found.</td>
				</tr>
				<%
				} else {
				for (Appointment appointment : appointments) {
				%>

				<tr>
					<td><%=appointment.getId()%></td>
					<td><%=appointment.getPatientName()%></td>
					<td><%=appointment.getDoctorName()%></td>
					<td><%=appointment.getAppointmentDate()%></td>
					<td><%=appointment.getAppointmentTime()%></td>
					<td><%=appointment.getReason()%></td>
					<td class="status"><%=appointment.getStatus()%></td>


					<td>
						<form action="../update-appointment-status" method="post">

							<input type="hidden" name="appointmentId"
								value="<%=appointment.getId()%>"> <select name="status"
								required>
								<option value="SCHEDULED"
									<%="SCHEDULED".equals(appointment.getStatus()) ? "selected" : ""%>>
									Scheduled</option>

								<option value="COMPLETED"
									<%="COMPLETED".equals(appointment.getStatus()) ? "selected" : ""%>>
									Completed</option>

								<option value="CANCELLED"
									<%="CANCELLED".equals(appointment.getStatus()) ? "selected" : ""%>>
									Cancelled</option>
							</select>

							<button type="submit">Update</button>

						</form> <%
 if ("SCHEDULED".equals(appointment.getStatus())) {
 %>

						<form action="../update-appointment-status" method="post"
							onsubmit="return confirm('Are you sure you want to cancel this appointment?');">

							<input type="hidden" name="appointmentId"
								value="<%=appointment.getId()%>"> <input type="hidden"
								name="status" value="CANCELLED">

							<button type="submit"
								style="background: #dc3545; color: white; border: none; padding: 8px 12px; border-radius: 5px; cursor: pointer; margin-top: 5px;">
								Cancel Appointment</button>

						</form> <%
 }
 %>
					</td>

				</tr>

				<%
				}
				}
				%>

			</table>

		</div>

		<%
		}
		%>

	</div>

</body>
</html>
