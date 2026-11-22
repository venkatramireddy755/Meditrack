package com.meditrack.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.meditrack.model.Doctor;
import com.meditrack.util.DBConnection;

public class DoctorDAO {

    public List<Doctor> getAllDoctors() {

        List<Doctor> doctors = new ArrayList<>();

        String sql = "SELECT * FROM doctors";

        try {

            Connection connection = DBConnection.getConnection();

            PreparedStatement ps = connection.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Doctor doctor = new Doctor();

                doctor.setId(rs.getInt("id"));
                doctor.setUserId(rs.getInt("user_id"));
                doctor.setDoctorCode(rs.getString("doctor_code"));
                doctor.setName(rs.getString("name"));
                doctor.setSpecialization(rs.getString("specialization"));
                doctor.setPhone(rs.getString("phone"));
                doctor.setQualification(rs.getString("qualification"));

                doctors.add(doctor);
            }

            rs.close();
            ps.close();
            connection.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return doctors;
    }
    public int getDoctorIdByUserId(int userId) {

        int doctorId = -1;

        String sql = "SELECT id FROM doctors WHERE user_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    doctorId = rs.getInt("id");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return doctorId;
    }
}

