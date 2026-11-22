
package com.meditrack.controller;

import java.io.IOException;
import java.sql.SQLException;

import com.meditrack.dao.AppointmentDAO;
import com.meditrack.model.Appointment;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/add-appointment")
public class AddAppointmentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private AppointmentDAO appointmentDAO;

    @Override
    public void init() throws ServletException {
        appointmentDAO = new AppointmentDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String patientId = request.getParameter("patientId");
        String doctorId = request.getParameter("doctorId");
        String date = request.getParameter("appointmentDate");
        String time = request.getParameter("appointmentTime");
        String reason = request.getParameter("reason");

        try {
            if (patientId == null || doctorId == null ||
                date == null || time == null || reason == null ||
                patientId.isBlank() || doctorId.isBlank() ||
                date.isBlank() || time.isBlank() ||
                reason.isBlank()) {

                response.sendRedirect(
                        "doctor/add-appointment.jsp?error=invalid");
                return;
            }

            Appointment appointment = new Appointment();

            appointment.setPatientId(Integer.parseInt(patientId));
            appointment.setDoctorId(Integer.parseInt(doctorId));

            appointment.setAppointmentDate(
                    java.sql.Date.valueOf(date));

            appointment.setAppointmentTime(
                    java.sql.Time.valueOf(time + ":00"));

            appointment.setReason(reason.trim());

            boolean saved = appointmentDAO.addAppointment(appointment);

            if (saved) {
                response.sendRedirect(
                        "doctor/appointments.jsp?success=added");
            } else {
                response.sendRedirect(
                        "doctor/add-appointment.jsp?error=server");
            }

        } catch (IllegalArgumentException e) {

            response.sendRedirect(
                    "doctor/add-appointment.jsp?error=invalid");

        } catch (SQLException e) {

            log("Unable to save appointment.", e);

            response.sendRedirect(
                    "doctor/add-appointment.jsp?error=server");
        }
    }
}