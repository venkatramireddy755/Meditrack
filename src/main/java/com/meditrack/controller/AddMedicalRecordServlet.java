//package com.meditrack.controller;
//
//import java.io.IOException;
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//
//import com.meditrack.util.DBConnection;
//
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//
//@WebServlet("/add-medical-record")
//public class AddMedicalRecordServlet extends HttpServlet {
//	private static final long serialVersionUID = 1L;
//
//	
//	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		// TODO Auto-generated method stub
//		
//		 String patientId =
//	                request.getParameter("patientId");
//
//	        String visitDate =
//	                request.getParameter("visitDate");
//
//	        String symptoms =
//	                request.getParameter("symptoms");
//
//	        String diagnosis =
//	                request.getParameter("diagnosis");
//
//	        String medicines =
//	                request.getParameter("medicines");
//
//	        String tests =
//	                request.getParameter("tests");
//
//	        String doctorNotes =
//	                request.getParameter("doctorNotes");
//
//	        String followUpDate =
//	                request.getParameter("followUpDate");
//
//
//	        HttpSession session =
//	                request.getSession();
//
//	        // For now we will use a fixed doctor ID
//	        // temporarily for testing.
//	        int doctorId = 1;
//
//
//	        String sql =
//	                "INSERT INTO medical_records " +
//	                "(patient_id, doctor_id, visit_date, " +
//	                "symptoms, diagnosis, medicines, tests, " +
//	                "doctor_notes, follow_up_date) " +
//	                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
//
//
//	        try {
//
//	            Connection connection =
//	                    DBConnection.getConnection();
//
//	            PreparedStatement ps =
//	                    connection.prepareStatement(sql);
//
//
//	            ps.setInt(
//	                    1,
//	                    Integer.parseInt(patientId)
//	            );
//
//	            ps.setInt(
//	                    2,
//	                    doctorId
//	            );
//
//	            ps.setDate(
//	                    3,
//	                    java.sql.Date.valueOf(visitDate)
//	            );
//
//	            ps.setString(
//	                    4,
//	                    symptoms
//	            );
//
//	            ps.setString(
//	                    5,
//	                    diagnosis
//	            );
//
//	            ps.setString(
//	                    6,
//	                    medicines
//	            );
//
//	            ps.setString(
//	                    7,
//	                    tests
//	            );
//
//	            ps.setString(
//	                    8,
//	                    doctorNotes
//	            );
//
//
//	            if (followUpDate == null ||
//	                followUpDate.isEmpty()) {
//
//	                ps.setNull(
//	                        9,
//	                        java.sql.Types.DATE
//	                );
//
//	            } else {
//
//	                ps.setDate(
//	                        9,
//	                        java.sql.Date.valueOf(followUpDate)
//	                );
//	            }
//
//
//	            ps.executeUpdate();
//
//
//	            ps.close();
//	            connection.close();
//
//
//	            response.sendRedirect(
//	                    "doctor/patient-details.jsp?id="
//	                    + patientId
//	                    + "&success=added"
//	            );
//
//
//	        } catch (Exception e) {
//
//	            e.printStackTrace();
//
//	            response.sendRedirect(
//	                    "doctor/add-medical-record.jsp?patientId="
//	                    + patientId
//	                    + "&error=server"
//	            );
//	        }
//	}
//
//}
//
//
//


package com.meditrack.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.meditrack.model.User;
import com.meditrack.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/add-medical-record")
public class AddMedicalRecordServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        String patientId =
                request.getParameter("patientId");

        String visitDate =
                request.getParameter("visitDate");

        String symptoms =
                request.getParameter("symptoms");

        String diagnosis =
                request.getParameter("diagnosis");

        String medicines =
                request.getParameter("medicines");

        String tests =
                request.getParameter("tests");

        String doctorNotes =
                request.getParameter("doctorNotes");

        String followUpDate =
                request.getParameter("followUpDate");


        // Get logged-in user from session
        HttpSession session =
                request.getSession(false);

        if (session == null ||
            session.getAttribute("user") == null) {

            response.sendRedirect("login.jsp");
            return;
        }


        User user =
                (User) session.getAttribute("user");

        int userId =
                user.getId();


        Connection connection = null;

        try {

            connection =
                    DBConnection.getConnection();


            // Find doctor_id using logged-in user's id
            String doctorSql =
                    "SELECT id FROM doctors WHERE user_id = ?";


            PreparedStatement doctorPs =
                    connection.prepareStatement(doctorSql);

            doctorPs.setInt(1, userId);


            ResultSet doctorRs =
                    doctorPs.executeQuery();


            if (!doctorRs.next()) {

                doctorRs.close();
                doctorPs.close();
                connection.close();

                response.sendRedirect(
                        "doctor/patients.jsp?error=doctor"
                );

                return;
            }


            int doctorId =
                    doctorRs.getInt("id");


            doctorRs.close();
            doctorPs.close();


            // Insert medical record
            String sql =
                    "INSERT INTO medical_records " +
                    "(patient_id, doctor_id, visit_date, " +
                    "symptoms, diagnosis, medicines, tests, " +
                    "doctor_notes, follow_up_date) " +
                    "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";


            PreparedStatement ps =
                    connection.prepareStatement(sql);


            ps.setInt(
                    1,
                    Integer.parseInt(patientId)
            );

            ps.setInt(
                    2,
                    doctorId
            );

            ps.setDate(
                    3,
                    java.sql.Date.valueOf(visitDate)
            );

            ps.setString(
                    4,
                    symptoms
            );

            ps.setString(
                    5,
                    diagnosis
            );

            ps.setString(
                    6,
                    medicines
            );

            ps.setString(
                    7,
                    tests
            );

            ps.setString(
                    8,
                    doctorNotes
            );


            if (followUpDate == null ||
                followUpDate.isEmpty()) {

                ps.setNull(
                        9,
                        java.sql.Types.DATE
                );

            } else {

                ps.setDate(
                        9,
                        java.sql.Date.valueOf(followUpDate)
                );
            }


            ps.executeUpdate();


            ps.close();
            connection.close();


            // Go back to patient details
            response.sendRedirect(
                    "doctor/patient-details.jsp?id="
                    + patientId
                    + "&success=added"
            );


        } catch (Exception e) {

            e.printStackTrace();

            if (connection != null) {

                try {
                    connection.close();
                } catch (Exception ex) {
                    ex.printStackTrace();
                }
            }


            response.sendRedirect(
                    "doctor/add-medical-record.jsp?patientId="
                    + patientId
                    + "&error=server"
            );
        }
    }
}
//Visit Date:       2026-10-05
//Symptoms:         Fever and headache
//Diagnosis:        Viral Fever
//Medicines:        Paracetamol 500mg
//Tests:            Blood Test
//Doctor Notes:     Take rest and drink plenty of water
//Follow-up Date:   2026-10-10


