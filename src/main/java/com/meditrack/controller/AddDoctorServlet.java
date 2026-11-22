
package com.meditrack.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.meditrack.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/add-doctor")
public class AddDoctorServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String doctorCode = request.getParameter("doctorCode");
        String name = request.getParameter("name");
        String specialization = request.getParameter("specialization");
        String phone = request.getParameter("phone");
        String qualification = request.getParameter("qualification");

        Connection connection = null;

        try {

            connection = DBConnection.getConnection();

            /*
             * Step 1:
             * Check whether email already exists
             */

            String checkEmailSql =
                    "SELECT id FROM users WHERE email = ?";

            PreparedStatement checkEmailPs =
                    connection.prepareStatement(checkEmailSql);

            checkEmailPs.setString(1, email);

            ResultSet emailRs = checkEmailPs.executeQuery();

            if (emailRs.next()) {

                emailRs.close();
                checkEmailPs.close();
                connection.close();

                response.sendRedirect(
                        "admin/add-doctor.jsp?error=email"
                );

                return;
            }

            emailRs.close();
            checkEmailPs.close();


            /*
             * Step 2:
             * Check whether doctor code already exists
             */

            String checkDoctorCodeSql =
                    "SELECT id FROM doctors WHERE doctor_code = ?";

            PreparedStatement checkDoctorCodePs =
                    connection.prepareStatement(checkDoctorCodeSql);

            checkDoctorCodePs.setString(1, doctorCode);

            ResultSet doctorCodeRs =
                    checkDoctorCodePs.executeQuery();

            if (doctorCodeRs.next()) {

                doctorCodeRs.close();
                checkDoctorCodePs.close();
                connection.close();

                response.sendRedirect(
                        "admin/add-doctor.jsp?error=doctorCode"
                );

                return;
            }

            doctorCodeRs.close();
            checkDoctorCodePs.close();


            /*
             * Step 3:
             * Insert user
             */

            String userSql =
                    "INSERT INTO users (email, password, role) " +
                    "VALUES (?, ?, ?)";

            PreparedStatement userPs =
                    connection.prepareStatement(
                            userSql,
                            java.sql.Statement.RETURN_GENERATED_KEYS
                    );

            userPs.setString(1, email);
            userPs.setString(2, password);
            userPs.setString(3, "DOCTOR");

            userPs.executeUpdate();


            /*
             * Step 4:
             * Get generated user ID
             */

            ResultSet generatedKeys =
                    userPs.getGeneratedKeys();

            int userId = 0;

            if (generatedKeys.next()) {

                userId = generatedKeys.getInt(1);
            }


            /*
             * Step 5:
             * Insert doctor
             */

            String doctorSql =
                    "INSERT INTO doctors " +
                    "(user_id, doctor_code, name, specialization, phone, qualification) " +
                    "VALUES (?, ?, ?, ?, ?, ?)";

            PreparedStatement doctorPs =
                    connection.prepareStatement(doctorSql);

            doctorPs.setInt(1, userId);
            doctorPs.setString(2, doctorCode);
            doctorPs.setString(3, name);
            doctorPs.setString(4, specialization);
            doctorPs.setString(5, phone);
            doctorPs.setString(6, qualification);

            doctorPs.executeUpdate();


            /*
             * Step 6:
             * Close resources
             */

            generatedKeys.close();
            userPs.close();
            doctorPs.close();
            connection.close();


            /*
             * Step 7:
             * Success
             */

            response.sendRedirect(
                    "admin/manage-doctors.jsp?success=added"
            );

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect(
                    "admin/add-doctor.jsp?error=server"
            );
        }
    }
}