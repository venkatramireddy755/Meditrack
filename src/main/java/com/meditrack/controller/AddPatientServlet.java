package com.meditrack.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.meditrack.util.DBConnection;

@WebServlet("/add-patient")
public class AddPatientServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String patientCode = request.getParameter("patientCode");

		String name = request.getParameter("name");

		String dateOfBirth = request.getParameter("dateOfBirth");

		String gender = request.getParameter("gender");

		String phone = request.getParameter("phone");

		String email = request.getParameter("email");

		String address = request.getParameter("address");

		String bloodGroup = request.getParameter("bloodGroup");

		String sql = "INSERT INTO patients "
				+ "(patient_code, name, date_of_birth, gender, phone, email, address, blood_group) "
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

		try {

			Connection connection = DBConnection.getConnection();

			PreparedStatement ps = connection.prepareStatement(sql);

			ps.setString(1, patientCode);

			ps.setString(2, name);

			if (dateOfBirth == null || dateOfBirth.isEmpty()) {

				ps.setNull(3, java.sql.Types.DATE);

			} else {

				ps.setDate(3, java.sql.Date.valueOf(dateOfBirth));
			}

			ps.setString(4, gender);

			ps.setString(5, phone);

			ps.setString(6, email);

			ps.setString(7, address);

			ps.setString(8, bloodGroup);

			ps.executeUpdate();

			ps.close();

			connection.close();

			response.sendRedirect("doctor/patients.jsp?success=added");

		} catch (Exception e) {

			e.printStackTrace();

			response.sendRedirect("doctor/add-patient.jsp?error=server");
		}
	}

}


