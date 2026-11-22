<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

	<head>
	
	    <meta charset="UTF-8">
	
	    <title>MediTrack - Add Patient</title>
	
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
	
	        input,
	        select,
	        textarea {
	            width: 100%;
	            padding: 10px;
	            box-sizing: border-box;
	            border: 1px solid #ccc;
	            border-radius: 4px;
	        }
	
	        textarea {
	            height: 80px;
	            resize: vertical;
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
	
	    <%@ include file="../navbar.jsp" %>
	
	    <div class="container">
	
	        <h1>Add Patient</h1>
	
	        <form action="../add-patient" method="post">
	
	            <div class="form-group">
	
	                <label>Patient Code</label>
	
	                <input type="text"
	                       name="patientCode"
	                       placeholder="Example: P001"
	                       required>
	
	            </div>
	
	
	            <div class="form-group">
	
	                <label>Patient Name</label>
	
	                <input type="text"
	                       name="name"
	                       placeholder="Enter patient name"
	                       required>
	
	            </div>
	
	
	            <div class="form-group">
	
	                <label>Date of Birth</label>
	
	                <input type="date"
	                       name="dateOfBirth">
	
	            </div>
	
	
	            <div class="form-group">
	
	                <label>Gender</label>
	
	                <select name="gender" required>
	
	                    <option value="">Select Gender</option>
	
	                    <option value="Male">
	                        Male
	                    </option>
	
	                    <option value="Female">
	                        Female
	                    </option>
	
	                    <option value="Other">
	                        Other
	                    </option>
	
	                </select>
	
	            </div>
	
	
	            <div class="form-group">
	
	                <label>Phone</label>
	
	                <input type="text"
	                       name="phone"
	                       placeholder="Enter phone number"
	                       required>
	
	            </div>
	
	
	            <div class="form-group">
	
	                <label>Email</label>
	
	                <input type="email"
	                       name="email"
	                       placeholder="Enter email">
	
	            </div>
	
	
	            <div class="form-group">
	
	                <label>Address</label>
	
	                <textarea name="address"
	                          placeholder="Enter address"></textarea>
	
	            </div>
	
	
	            <div class="form-group">
	
	                <label>Blood Group</label>
	
	                <select name="bloodGroup">
	
	                    <option value="">Select Blood Group</option>
	
	                    <option value="A+">A+</option>
	                    <option value="A-">A-</option>
	                    <option value="B+">B+</option>
	                    <option value="B-">B-</option>
	                    <option value="AB+">AB+</option>
	                    <option value="AB-">AB-</option>
	                    <option value="O+">O+</option>
	                    <option value="O-">O-</option>
	
	                </select>
	
	            </div>
	
	
	            <div class="buttons">
	
	                <button type="submit">
	                    Add Patient
	                </button>
	
	                <a href="patients.jsp"
	                   class="back">
	                    Cancel
	                </a>
	
	            </div>
	
	        </form>
	
	    </div>
	
	</body>

</html>