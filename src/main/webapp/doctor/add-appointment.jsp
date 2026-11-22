<%@ page import="java.util.List" %>
<%@ page import="com.meditrack.model.Patient" %>
<%@ page import="com.meditrack.model.Doctor" %>
<%@ page import="com.meditrack.dao.PatientDAO" %>
<%@ page import="com.meditrack.dao.DoctorDAO" %>

<%
    PatientDAO patientDAO = new PatientDAO();
    DoctorDAO doctorDAO = new DoctorDAO();

    List<Patient> patients = patientDAO.getAllPatients();
    List<Doctor> doctors = doctorDAO.getAllDoctors();
%>

<!DOCTYPE html>
<html>
<head>
    <title>Add Appointment - MediTrack</title>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f5f7fb;
            color: #2c3e50;
        }

        .container {
            max-width: 850px;
            width: 85%;
            margin: 35px auto;
        }

        h2 {
            margin-bottom: 25px;
            font-size: 28px;
        }

        .card {
            background: white;
            padding: 30px;
            border-radius: 12px;
            border: 1px solid #e8edf3;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.07);
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
        }

        input, select, textarea {
            width: 100%;
            padding: 12px;
            box-sizing: border-box;
            border: 1px solid #d9dee5;
            border-radius: 6px;
            font-family: Arial, sans-serif;
            font-size: 14px;
        }

        input:focus, select:focus, textarea:focus {
            outline: none;
            border-color: #1abc9c;
            box-shadow: 0 0 0 2px rgba(26, 188, 156, 0.12);
        }

        textarea {
            min-height: 90px;
            resize: vertical;
        }

        .save-button, .back-button {
            display: inline-block;
            padding: 11px 20px;
            border: none;
            border-radius: 6px;
            font-size: 14px;
            text-decoration: none;
            cursor: pointer;
        }

        .save-button {
            background: #1abc9c;
            color: white;
            font-weight: 600;
        }

        .save-button:hover {
            background: #16a085;
        }

        .back-button {
            background: #2c3e50;
            color: white;
            margin-left: 8px;
        }

        .message {
            padding: 12px;
            margin-bottom: 18px;
            border-radius: 6px;
            background: #fdecea;
            color: #c0392b;
        }
    </style>
</head>

<body>

    <%@ include file="../navbar.jsp" %>

    <div class="container">

        <h2>Add Appointment</h2>

        <% if ("server".equals(request.getParameter("error"))) { %>
            <div class="message">
                Unable to save appointment. Please check the server console.
            </div>
        <% } else if ("invalid".equals(request.getParameter("error"))) { %>
            <div class="message">
                Please enter valid appointment details.
            </div>
        <% } %>

        <div class="card">

            <form action="../add-appointment" method="post">

                <div class="form-group">
                    <label for="patientId">Select Patient</label>

                    <select name="patientId" id="patientId" required>
                        <option value="">-- Select Patient --</option>

                        <% for (Patient patient : patients) { %>
                            <option value="<%= patient.getId() %>">
                                <%= patient.getPatientCode() %> -
                                <%= patient.getName() %>
                            </option>
                        <% } %>
                    </select>
                </div>

                <div class="form-group">
                    <label for="doctorId">Select Doctor</label>

                    <select name="doctorId" id="doctorId" required>
                        <option value="">-- Select Doctor --</option>

                        <% for (Doctor doctor : doctors) { %>
                            <option value="<%= doctor.getId() %>">
                                <%= doctor.getName() %> -
                                <%= doctor.getSpecialization() %>
                            </option>
                        <% } %>
                    </select>
                </div>

                <div class="form-group">
                    <label for="appointmentDate">Appointment Date</label>

                    <input type="date"
                           name="appointmentDate"
                           id="appointmentDate"
                           required>
                </div>

                <div class="form-group">
                    <label for="appointmentTime">Appointment Time</label>

                    <input type="time"
                           name="appointmentTime"
                           id="appointmentTime"
                           required>
                </div>

                <div class="form-group">
                    <label for="reason">Reason for Visit</label>

                    <textarea name="reason"
                              id="reason"
                              placeholder="Enter the reason for the appointment"
                              required></textarea>
                </div>

                <button type="submit" class="save-button">
                    Save Appointment
                </button>

                <a href="appointments.jsp" class="back-button">
                    Cancel
                </a>

            </form>

        </div>
    </div>

</body>
</html>
