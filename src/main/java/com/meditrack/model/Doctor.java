package com.meditrack.model;

public class Doctor {

    private int id;
    private int userId;
    private String doctorCode;
    private String name;
    private String specialization;
    private String phone;
    private String qualification;

    public Doctor() {
    }

    public Doctor(int id, int userId, String doctorCode, String name,
                  String specialization, String phone, String qualification) {

        this.id = id;
        this.userId = userId;
        this.doctorCode = doctorCode;
        this.name = name;
        this.specialization = specialization;
        this.phone = phone;
        this.qualification = qualification;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getDoctorCode() {
        return doctorCode;
    }

    public void setDoctorCode(String doctorCode) {
        this.doctorCode = doctorCode;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSpecialization() {
        return specialization;
    }

    public void setSpecialization(String specialization) {
        this.specialization = specialization;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getQualification() {
        return qualification;
    }

    public void setQualification(String qualification) {
        this.qualification = qualification;
    }
}