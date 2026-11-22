package com.meditrack.model;

import java.sql.Date;

public class MedicalRecord {

    private int id;
    private int patientId;
    private int doctorId;
    private Date visitDate;
    private String symptoms;
    private String diagnosis;
    private String medicines;
    private String tests;
    private String doctorNotes;
    private Date followUpDate;
    private String doctorName;

    public MedicalRecord() {
    }

    public MedicalRecord(int id, int patientId, int doctorId,
                         Date visitDate, String symptoms,
                         String diagnosis, String medicines,
                         String tests, String doctorNotes,
                         Date followUpDate) {

        this.id = id;
        this.patientId = patientId;
        this.doctorId = doctorId;
        this.visitDate = visitDate;
        this.symptoms = symptoms;
        this.diagnosis = diagnosis;
        this.medicines = medicines;
        this.tests = tests;
        this.doctorNotes = doctorNotes;
        this.followUpDate = followUpDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getPatientId() {
        return patientId;
    }

    public void setPatientId(int patientId) {
        this.patientId = patientId;
    }

    public int getDoctorId() {
        return doctorId;
    }

    public void setDoctorId(int doctorId) {
        this.doctorId = doctorId;
    }

    public Date getVisitDate() {
        return visitDate;
    }

    public void setVisitDate(Date visitDate) {
        this.visitDate = visitDate;
    }

    public String getSymptoms() {
        return symptoms;
    }

    public void setSymptoms(String symptoms) {
        this.symptoms = symptoms;
    }

    public String getDiagnosis() {
        return diagnosis;
    }

    public void setDiagnosis(String diagnosis) {
        this.diagnosis = diagnosis;
    }

    public String getMedicines() {
        return medicines;
    }

    public void setMedicines(String medicines) {
        this.medicines = medicines;
    }

    public String getTests() {
        return tests;
    }

    public void setTests(String tests) {
        this.tests = tests;
    }

    public String getDoctorNotes() {
        return doctorNotes;
    }

    public void setDoctorNotes(String doctorNotes) {
        this.doctorNotes = doctorNotes;
    }

    public Date getFollowUpDate() {
        return followUpDate;
    }

    public void setFollowUpDate(Date followUpDate) {
        this.followUpDate = followUpDate;
    }
    public String getDoctorName() {
        return doctorName;
    }

    public void setDoctorName(String doctorName) {
        this.doctorName = doctorName;
    }
}