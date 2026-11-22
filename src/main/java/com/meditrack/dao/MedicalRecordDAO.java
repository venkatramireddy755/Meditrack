
package com.meditrack.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.meditrack.model.MedicalRecord;
import com.meditrack.util.DBConnection;

public class MedicalRecordDAO {

    public List<MedicalRecord> getRecordsByPatientId(int patientId) {

        List<MedicalRecord> records = new ArrayList<>();

        String sql =
                "SELECT mr.*, d.name AS doctor_name " +
                "FROM medical_records mr " +
                "JOIN doctors d ON mr.doctor_id = d.id " +
                "WHERE mr.patient_id = ? " +
                "ORDER BY mr.visit_date DESC";

        try {

            Connection connection =
                    DBConnection.getConnection();

            PreparedStatement ps =
                    connection.prepareStatement(sql);

            ps.setInt(1, patientId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {

                MedicalRecord record =
                        new MedicalRecord();
                record.setDoctorName(
                        rs.getString("doctor_name")
                );

                record.setId(
                        rs.getInt("id")
                );

                record.setPatientId(
                        rs.getInt("patient_id")
                );

                record.setDoctorId(
                        rs.getInt("doctor_id")
                );

                record.setVisitDate(
                        rs.getDate("visit_date")
                );

                record.setSymptoms(
                        rs.getString("symptoms")
                );

                record.setDiagnosis(
                        rs.getString("diagnosis")
                );

                record.setMedicines(
                        rs.getString("medicines")
                );

                record.setTests(
                        rs.getString("tests")
                );

                record.setDoctorNotes(
                        rs.getString("doctor_notes")
                );

                record.setFollowUpDate(
                        rs.getDate("follow_up_date")
                );

                records.add(record);
            }

            rs.close();
            ps.close();
            connection.close();

        } catch (Exception e) {

            e.printStackTrace();
        }

        return records;
    }
}
