package com.meditrack.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.meditrack.dao.UserDAO;
import com.meditrack.model.User;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String email = request.getParameter("email");
        String password = request.getParameter("password");

        User user = userDAO.login(email, password);

        if (user != null) {

            HttpSession session = request.getSession();

            session.setAttribute("user", user);

            if ("ADMIN".equals(user.getRole())) {

                response.sendRedirect("admin/dashboard.jsp");

            } else if ("DOCTOR".equals(user.getRole())) {

                response.sendRedirect("doctor/dashboard.jsp");

            }

        } else {

            response.sendRedirect("login.jsp?error=invalid");
        }
	}

}
