<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="com.meditrack.model.Patient" %>
<%@ page import="com.meditrack.dao.PatientDAO" %>

<%
    String patientIdParameter =
            request.getParameter("patientId");

    Patient patient = null;

    if (patientIdParameter != null &&
        !patientIdParameter.isEmpty()) {

        int patientId =
                Integer.parseInt(patientIdParameter);

        PatientDAO patientDAO =
                new PatientDAO();

        patient =
                patientDAO.getPatientById(patientId);
    }
%>

<!DOCTYPE html>
<html>

<head>

    <title>Add Medical Record - MediTrack</title>

    <style>

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f5f7fb;
            color: #2c3e50;
        }

        .container {
            width: 80%;
            max-width: 900px;
            margin: 40px auto;
        }

        .title {
            font-size: 28px;
            margin-bottom: 25px;
        }

        .patient-info {
            background-color: #eaf7f5;
            border-left: 5px solid #1abc9c;
            padding: 15px 20px;
            margin-bottom: 25px;
            border-radius: 6px;
        }

        .patient-info strong {
            color: #2c3e50;
        }

        .card {
            background-color: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            border: 1px solid #e8edf3;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #34495e;
        }

        textarea {
            width: 100%;
            min-height: 90px;
            padding: 12px;
            border: 1px solid #d9dee5;
            border-radius: 6px;
            box-sizing: border-box;
            font-family: Arial, sans-serif;
            font-size: 14px;
            resize: vertical;
        }

        input[type="date"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #d9dee5;
            border-radius: 6px;
            box-sizing: border-box;
            font-size: 14px;
        }

        textarea:focus,
        input[type="date"]:focus {
            outline: none;
            border-color: #1abc9c;
            box-shadow: 0 0 0 2px rgba(26, 188, 156, 0.12);
        }

        .button-group {
            margin-top: 25px;
        }

        .save-button {
            padding: 11px 22px;
            background-color: #1abc9c;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 14px;
            font-weight: 600;
        }

        .save-button:hover {
            background-color: #16a085;
        }

        .cancel-button {
            display: inline-block;
            margin-left: 10px;
            padding: 10px 20px;
            background-color: #2c3e50;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-size: 14px;
        }

        .cancel-button:hover {
            background-color: #34495e;
        }

        .error {
            background-color: #fdecea;
            color: #c0392b;
            padding: 12px 15px;
            border-radius: 6px;
            margin-bottom: 20px;
        }

    </style>

</head>

<body>

    <%@ include file="../navbar.jsp" %>

    <div class="container">

        <h2 class="title">
            Add Medical Record
        </h2>

        <%
            if (patient != null) {
        %>

        <div class="patient-info">

            <strong>Patient:</strong>
            <%= patient.getName() %>

            &nbsp;&nbsp; | &nbsp;&nbsp;

            <strong>Patient Code:</strong>
            <%= patient.getPatientCode() %>

        </div>

        <div class="card">

            <form action="../add-medical-record"
                  method="post">

                <input type="hidden"
                       name="patientId"
                       value="<%= patient.getId() %>">

                <div class="form-group">

                    <label>
                        Visit Date
                    </label>

                    <input type="date"
                           name="visitDate"
                           required>

                </div>

                <div class="form-group">

                    <label>
                        Symptoms
                    </label>

                    <textarea
                        name="symptoms"
                        placeholder="Enter patient's symptoms"
                        required></textarea>

                </div>

                <div class="form-group">

                    <label>
                        Diagnosis
                    </label>

                    <textarea
                        name="diagnosis"
                        placeholder="Enter diagnosis"
                        required></textarea>

                </div>

                <div class="form-group">

                    <label>
                        Medicines
                    </label>

                    <textarea
                        name="medicines"
                        placeholder="Enter prescribed medicines"></textarea>

                </div>

                <div class="form-group">

                    <label>
                        Tests
                    </label>

                    <textarea
                        name="tests"
                        placeholder="Enter tests recommended or performed"></textarea>

                </div>

                <div class="form-group">

                    <label>
                        Doctor Notes
                    </label>

                    <textarea
                        name="doctorNotes"
                        placeholder="Enter additional notes"></textarea>

                </div>

                <div class="form-group">

                    <label>
                        Follow-up Date
                    </label>

                    <input type="date"
                           name="followUpDate">

                </div>

                <div class="button-group">

                    <button type="submit"
                            class="save-button">
                        Save Medical Record
                    </button>

                    <a href="patient-details.jsp?id=<%= patient.getId() %>"
                       class="cancel-button">
                        Cancel
                    </a>

                </div>

            </form>

        </div>

        <%
            } else {
        %>

        <div class="error">

            Patient not found.

        </div>

        <%
            }
        %>

    </div>

</body>

</html>
