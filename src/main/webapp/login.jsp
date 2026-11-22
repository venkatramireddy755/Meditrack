<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f4f7fb;

            display: flex;
            justify-content: center;
            align-items: center;

            height: 100vh;
        }

        .login-container {
            width: 380px;
            background: white;

            padding: 35px;

            border-radius: 10px;

            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .logo {
            text-align: center;
            font-size: 28px;
            font-weight: bold;

            color: #1976d2;

            margin-bottom: 10px;
        }

        .subtitle {
            text-align: center;
            color: #666;

            margin-bottom: 30px;
        }

        label {
            display: block;
            margin-bottom: 6px;

            font-weight: bold;
        }

        input {
            width: 100%;

            padding: 11px;

            margin-bottom: 18px;

            border: 1px solid #ccc;

            border-radius: 5px;

            font-size: 14px;
        }

        input:focus {
            outline: none;
            border-color: #1976d2;
        }

        button {
            width: 100%;

            padding: 12px;

            background: #1976d2;

            color: white;

            border: none;

            border-radius: 5px;

            font-size: 16px;

            cursor: pointer;
        }

        button:hover {
            background: #125ca1;
        }

        .error {
            background: #ffe6e6;

            color: #d32f2f;

            padding: 10px;

            margin-bottom: 20px;

            border-radius: 5px;

            text-align: center;
        }

    </style>
	</head>
	<body>
		<div class="login-container">

        <div class="logo">
            🏥 MediTrack
        </div>

        <div class="subtitle">
            Digital Patient Record Management
        </div>


        <% if ("invalid".equals(request.getParameter("error"))) { %>

            <div class="error">
                Invalid email or password
            </div>

        <% } %>


        <form action="login" method="post">

            <label>Email</label>

            <input
                type="email"
                name="email"
                placeholder="Enter your email"
                required
            >


            <label>Password</label>

            <input
                type="password"
                name="password"
                placeholder="Enter your password"
                required
            >


            <button type="submit">
                Login
            </button>

        </form>

    </div>
	</body>
</html>