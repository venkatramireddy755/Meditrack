
package com.meditrack.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private static final String URL = System.getenv("MEDTRACK_DB_URL");
    private static final String USERNAME = System.getenv("MEDTRACK_DB_USERNAME");
    private static final String PASSWORD = System.getenv("MEDTRACK_DB_PASSWORD");

    public static Connection getConnection() {
        Connection connection = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);

            System.out.println("Database connected successfully!");

        } catch (Exception e) {
            e.printStackTrace();
        }

        return connection;
    }
}
