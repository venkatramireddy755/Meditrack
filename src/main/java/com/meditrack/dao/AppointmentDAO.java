
package com.meditrack.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.meditrack.model.Appointment;
import com.meditrack.util.DBConnection;

public class AppointmentDAO {

	public boolean addAppointment(Appointment appointment) throws SQLException {

		String sql = "INSERT INTO appointments " + "(patient_id, doctor_id, appointment_date, "
				+ "appointment_time, reason, status) " + "VALUES (?, ?, ?, ?, ?, ?)";

		try (Connection connection = DBConnection.getConnection()) {

			if (connection == null) {
				throw new SQLException("Database connection failed.");
			}

			try (PreparedStatement ps = connection.prepareStatement(sql)) {

				ps.setInt(1, appointment.getPatientId());
				ps.setInt(2, appointment.getDoctorId());
				ps.setDate(3, appointment.getAppointmentDate());
				ps.setTime(4, appointment.getAppointmentTime());
				ps.setString(5, appointment.getReason());
				ps.setString(6, "SCHEDULED");

				return ps.executeUpdate() == 1;
			}
		}
	}

	public List<Appointment> getAllAppointments() throws SQLException {

		List<Appointment> appointments = new ArrayList<>();

		String sql = "SELECT a.*, p.name AS patient_name, d.name AS doctor_name " + "FROM appointments a "
				+ "JOIN patients p ON a.patient_id = p.id " + "JOIN doctors d ON a.doctor_id = d.id "
				+ "ORDER BY a.appointment_date DESC, a.appointment_time DESC";

		try (Connection connection = DBConnection.getConnection();
				PreparedStatement ps = connection.prepareStatement(sql);
				ResultSet rs = ps.executeQuery()) {

			while (rs.next()) {

				Appointment appointment = new Appointment();

				appointment.setId(rs.getInt("id"));
				appointment.setPatientId(rs.getInt("patient_id"));
				appointment.setDoctorId(rs.getInt("doctor_id"));
				appointment.setAppointmentDate(rs.getDate("appointment_date"));
				appointment.setAppointmentTime(rs.getTime("appointment_time"));
				appointment.setReason(rs.getString("reason"));
				appointment.setStatus(rs.getString("status"));

				appointment.setPatientName(rs.getString("patient_name"));
				appointment.setDoctorName(rs.getString("doctor_name"));

				appointments.add(appointment);
			}
		}

		return appointments;
	}

	public List<Appointment> getAppointmentsByDoctorId(int doctorId) throws SQLException {

		List<Appointment> appointments = new ArrayList<>();

		String sql = "SELECT a.*, p.name AS patient_name, d.name AS doctor_name " + "FROM appointments a "
				+ "JOIN patients p ON a.patient_id = p.id " + "JOIN doctors d ON a.doctor_id = d.id "
				+ "WHERE a.doctor_id = ? " + "ORDER BY a.appointment_date DESC, a.appointment_time DESC";

		try (Connection connection = DBConnection.getConnection();
				PreparedStatement ps = connection.prepareStatement(sql)) {

			ps.setInt(1, doctorId);

			try (ResultSet rs = ps.executeQuery()) {

				while (rs.next()) {

					Appointment appointment = new Appointment();

					appointment.setId(rs.getInt("id"));
					appointment.setPatientId(rs.getInt("patient_id"));
					appointment.setDoctorId(rs.getInt("doctor_id"));
					appointment.setAppointmentDate(rs.getDate("appointment_date"));
					appointment.setAppointmentTime(rs.getTime("appointment_time"));
					appointment.setReason(rs.getString("reason"));
					appointment.setStatus(rs.getString("status"));

					appointment.setPatientName(rs.getString("patient_name"));
					appointment.setDoctorName(rs.getString("doctor_name"));

					appointments.add(appointment);
				}
			}
		}

		return appointments;
	}

	public boolean updateAppointmentStatus(int appointmentId, int doctorId, String status) throws SQLException {

		String sql = "UPDATE appointments SET status = ? " + "WHERE id = ? AND doctor_id = ?";

		try (Connection connection = DBConnection.getConnection()) {

			if (connection == null) {
				throw new SQLException("Database connection failed.");
			}

			try (PreparedStatement ps = connection.prepareStatement(sql)) {

				ps.setString(1, status);
				ps.setInt(2, appointmentId);
				ps.setInt(3, doctorId);

				return ps.executeUpdate() == 1;
			}
		}
	}
	public List<Appointment> searchAppointments(int doctorId, String keyword)
	        throws SQLException {

	    List<Appointment> appointments = new ArrayList<>();

	    String sql =
	        "SELECT a.*, p.name AS patient_name, d.name AS doctor_name " +
	        "FROM appointments a " +
	        "JOIN patients p ON a.patient_id = p.id " +
	        "JOIN doctors d ON a.doctor_id = d.id " +
	        "WHERE a.doctor_id = ? " +
	        "AND (p.name LIKE ? OR p.phone LIKE ? OR a.status LIKE ?) " +
	        "ORDER BY a.appointment_date DESC, a.appointment_time DESC";

	    try (Connection connection = DBConnection.getConnection()) {

	        if (connection == null) {
	            throw new SQLException("Database connection failed.");
	        }

	        try (PreparedStatement ps = connection.prepareStatement(sql)) {

	            String searchValue = "%" + keyword.trim() + "%";

	            ps.setInt(1, doctorId);
	            ps.setString(2, searchValue);
	            ps.setString(3, searchValue);
	            ps.setString(4, searchValue);

	            try (ResultSet rs = ps.executeQuery()) {

	                while (rs.next()) {

	                    Appointment appointment = new Appointment();

	                    appointment.setId(rs.getInt("id"));
	                    appointment.setPatientId(rs.getInt("patient_id"));
	                    appointment.setDoctorId(rs.getInt("doctor_id"));
	                    appointment.setAppointmentDate(
	                        rs.getDate("appointment_date"));
	                    appointment.setAppointmentTime(
	                        rs.getTime("appointment_time"));
	                    appointment.setReason(rs.getString("reason"));
	                    appointment.setStatus(rs.getString("status"));
	                    appointment.setPatientName(
	                        rs.getString("patient_name"));
	                    appointment.setDoctorName(
	                        rs.getString("doctor_name"));

	                    appointments.add(appointment);
	                }
	            }
	        }
	    }

	    return appointments;
	}
	public List<Appointment> filterAppointments(
	        int doctorId, String keyword, String date, String status)
	        throws SQLException {

	    List<Appointment> appointments = new ArrayList<>();

	    StringBuilder sql = new StringBuilder(
	        "SELECT a.*, p.name AS patient_name, d.name AS doctor_name " +
	        "FROM appointments a " +
	        "JOIN patients p ON a.patient_id = p.id " +
	        "JOIN doctors d ON a.doctor_id = d.id " +
	        "WHERE a.doctor_id = ? "
	    );

	    if (keyword != null && !keyword.trim().isEmpty()) {
	        sql.append(
	            "AND (p.name LIKE ? OR p.phone LIKE ? OR a.status LIKE ?) "
	        );
	    }

	    if (date != null && !date.trim().isEmpty()) {
	        sql.append("AND a.appointment_date = ? ");
	    }

	    if (status != null && !status.trim().isEmpty()) {
	        sql.append("AND a.status = ? ");
	    }

	    sql.append(
	        "ORDER BY a.appointment_date DESC, a.appointment_time DESC"
	    );

	    try (Connection connection = DBConnection.getConnection()) {

	        if (connection == null) {
	            throw new SQLException("Database connection failed.");
	        }

	        try (PreparedStatement ps =
	                 connection.prepareStatement(sql.toString())) {

	            int index = 1;

	            ps.setInt(index++, doctorId);

	            if (keyword != null && !keyword.trim().isEmpty()) {
	                String searchValue = "%" + keyword.trim() + "%";

	                ps.setString(index++, searchValue);
	                ps.setString(index++, searchValue);
	                ps.setString(index++, searchValue);
	            }

	            if (date != null && !date.trim().isEmpty()) {
	                ps.setDate(index++, java.sql.Date.valueOf(date));
	            }

	            if (status != null && !status.trim().isEmpty()) {
	                ps.setString(index++, status);
	            }

	            try (ResultSet rs = ps.executeQuery()) {

	                while (rs.next()) {

	                    Appointment appointment = new Appointment();

	                    appointment.setId(rs.getInt("id"));
	                    appointment.setPatientId(rs.getInt("patient_id"));
	                    appointment.setDoctorId(rs.getInt("doctor_id"));
	                    appointment.setAppointmentDate(
	                        rs.getDate("appointment_date"));
	                    appointment.setAppointmentTime(
	                        rs.getTime("appointment_time"));
	                    appointment.setReason(rs.getString("reason"));
	                    appointment.setStatus(rs.getString("status"));
	                    appointment.setPatientName(
	                        rs.getString("patient_name"));
	                    appointment.setDoctorName(
	                        rs.getString("doctor_name"));

	                    appointments.add(appointment);
	                }
	            }
	        }
	    }

	    return appointments;
	}

}
