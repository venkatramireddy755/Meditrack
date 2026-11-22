<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>MediTrack - Add Doctor</title>

    <style>

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
        }

        .container {
            width: 600px;
            margin: 40px auto;
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }

        h1 {
            margin-top: 0;
            margin-bottom: 25px;
        }

        .form-group {
            margin-bottom: 18px;
        }

        label {
            display: block;
            margin-bottom: 6px;
            font-weight: bold;
        }

        input {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .buttons {
            margin-top: 25px;
        }

        button {
            background-color: #2c3e50;
            color: white;
            border: none;
            padding: 11px 20px;
            border-radius: 5px;
            cursor: pointer;
        }

        .back {
            margin-left: 10px;
            text-decoration: none;
            color: #2c3e50;
        }

    </style>

</head>

<body>
	<%
        String error = request.getParameter("error");
    %>

    <% if ("email".equals(error)) { %>

        <p style="color: red;">
            Email already exists.
        </p>

    <% } else if ("doctorCode".equals(error)) { %>

        <p style="color: red;">
            Doctor code already exists.
        </p>

    <% } else if ("server".equals(error)) { %>

        <p style="color: red;">
            Something went wrong. Please try again.
        </p>

    <% } %>

    <%@ include file="../navbar.jsp" %>

    <div class="container">

        <h1>Add Doctor</h1>

        <form action="../add-doctor" method="post">

            <div class="form-group">

                <label>Email</label>

                <input type="email"
                       name="email"
                       placeholder="Enter doctor email"
                       required>

            </div>


            <div class="form-group">

                <label>Password</label>

                <input type="password"
                       name="password"
                       placeholder="Enter password"
                       required>

            </div>


            <div class="form-group">

                <label>Doctor Code</label>

                <input type="text"
                       name="doctorCode"
                       placeholder="Example: D006"
                       required>

            </div>


            <div class="form-group">

                <label>Doctor Name</label>

                <input type="text"
                       name="name"
                       placeholder="Enter doctor name"
                       required>

            </div>


            <div class="form-group">

                <label>Specialization</label>

                <input type="text"
                       name="specialization"
                       placeholder="Example: Cardiologist"
                       required>

            </div>


            <div class="form-group">

                <label>Phone</label>

                <input type="text"
                       name="phone"
                       placeholder="Enter phone number"
                       required>

            </div>


            <div class="form-group">

                <label>Qualification</label>

                <input type="text"
                       name="qualification"
                       placeholder="Example: MBBS, MD"
                       required>

            </div>


            <div class="buttons">

                <button type="submit">
                    Add Doctor
                </button>

                <a href="manage-doctors.jsp" class="back">
                    Cancel
                </a>

            </div>

        </form>

    </div>

</body>

</html>