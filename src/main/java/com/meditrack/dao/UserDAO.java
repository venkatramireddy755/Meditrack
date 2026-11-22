package com.meditrack.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.meditrack.model.User;
import com.meditrack.util.DBConnection;

public class UserDAO {

    public User login(String email, String password) {

        User user = null;

        String sql = "SELECT * FROM users WHERE email = ? AND password = ?";

        try {

            Connection connection = DBConnection.getConnection();

            PreparedStatement ps = connection.prepareStatement(sql);

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                user = new User();

                user.setId(rs.getInt("id"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
            }

            rs.close();
            ps.close();
            connection.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        return user;
    }
}