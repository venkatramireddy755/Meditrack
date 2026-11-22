
package com.meditrack.controller;

import java.io.IOException;
import java.sql.SQLException;

import com.meditrack.dao.AppointmentDAO;
import com.meditrack.dao.DoctorDAO;
import com.meditrack.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/update-appointment-status")
public class UpdateAppointmentStatusServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private AppointmentDAO appointmentDAO;
    private DoctorDAO doctorDAO;

    @Override
    public void init() throws ServletException {
        appointmentDAO = new AppointmentDAO();
        doctorDAO = new DoctorDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            !(session.getAttribute("user") instanceof User)) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        if (!"DOCTOR".equals(user.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        try {
            int appointmentId = Integer.parseInt(
                request.getParameter("appointmentId"));

            String status = request.getParameter("status");

            if (!"SCHEDULED".equals(status) &&
                !"COMPLETED".equals(status) &&
                !"CANCELLED".equals(status)) {
                response.sendRedirect("doctor/appointments.jsp?error=invalid");
                return;
            }

            int doctorId = doctorDAO.getDoctorIdByUserId(user.getId());

            if (doctorId <= 0) {
                response.sendRedirect("doctor/appointments.jsp?error=doctor");
                return;
            }

            boolean updated = appointmentDAO.updateAppointmentStatus(
                appointmentId, doctorId, status);

            if (updated) {
                response.sendRedirect("doctor/appointments.jsp?success=updated");
            } else {
                response.sendRedirect("doctor/appointments.jsp?error=update");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect("doctor/appointments.jsp?error=invalid");
        } catch (SQLException e) {
            log("Unable to update appointment status.", e);
            response.sendRedirect("doctor/appointments.jsp?error=server");
        }
    }
}
