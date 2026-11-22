package com.meditrack.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.meditrack.model.Patient;
import com.meditrack.util.DBConnection;

public class PatientDAO {

    public List<Patient> getAllPatients() {

        List<Patient> patients = new ArrayList<>();

        String sql = "SELECT * FROM patients";

        try {

            Connection connection = DBConnection.getConnection();

            PreparedStatement ps =
                    connection.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Patient patient = new Patient();

                patient.setId(rs.getInt("id"));
                patient.setPatientCode(
                        rs.getString("patient_code")
                );
                patient.setName(
                        rs.getString("name")
                );
                patient.setDateOfBirth(
                        rs.getDate("date_of_birth")
                );
                patient.setGender(
                        rs.getString("gender")
                );
                patient.setPhone(
                        rs.getString("phone")
                );
                patient.setEmail(
                        rs.getString("email")
                );
                patient.setAddress(
                        rs.getString("address")
                );
                patient.setBloodGroup(
                        rs.getString("blood_group")
                );

                patients.add(patient);
            }

            rs.close();
            ps.close();
            connection.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return patients;
    }
    
    
    public List<Patient> searchPatients(String keyword) {

        List<Patient> patients = new ArrayList<>();

        String sql =
                "SELECT * FROM patients " +
                "WHERE patient_code LIKE ? " +
                "OR name LIKE ? " +
                "OR phone LIKE ?";

        try {

            Connection connection =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    connection.prepareStatement(sql);

            String searchValue = "%" + keyword + "%";

            ps.setString(1, searchValue);
            ps.setString(2, searchValue);
            ps.setString(3, searchValue);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                Patient patient = new Patient();

                patient.setId(
                        rs.getInt("id")
                );

                patient.setPatientCode(
                        rs.getString("patient_code")
                );

                patient.setName(
                        rs.getString("name")
                );

                patient.setDateOfBirth(
                        rs.getDate("date_of_birth")
                );

                patient.setGender(
                        rs.getString("gender")
                );

                patient.setPhone(
                        rs.getString("phone")
                );

                patient.setEmail(
                        rs.getString("email")
                );

                patient.setAddress(
                        rs.getString("address")
                );

                patient.setBloodGroup(
                        rs.getString("blood_group")
                );

                patients.add(patient);
            }

            rs.close();
            ps.close();
            connection.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return patients;
    }
    
   
    public Patient getPatientById(int id) {

        Patient patient = null;

        String sql = "SELECT * FROM patients WHERE id = ?";

        try {

            Connection connection =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    connection.prepareStatement(sql);

            ps.setInt(1, id);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                patient = new Patient();

                patient.setId(rs.getInt("id"));
                patient.setPatientCode(
                        rs.getString("patient_code")
                );
                patient.setName(
                        rs.getString("name")
                );
                patient.setDateOfBirth(
                        rs.getDate("date_of_birth")
                );
                patient.setGender(
                        rs.getString("gender")
                );
                patient.setPhone(
                        rs.getString("phone")
                );
                patient.setEmail(
                        rs.getString("email")
                );
                patient.setAddress(
                        rs.getString("address")
                );
                patient.setBloodGroup(
                        rs.getString("blood_group")
                );
            }

            rs.close();
            ps.close();
            connection.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return patient;
    }
   
    
}

