<%@page import="org.apache.jasper.tagplugins.jstl.core.Catch"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Confirmation Page</title>
</head>
<body>

	<%
	try { // Load driver class
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	} catch (java.lang.ClassNotFoundException e) {
		out.println("ClassNotFoundException: " + e);
	}

				String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_psingh;";
				String uid = "psingh";
				String pw = "71364251";

				Connection con = null;

try{
			
			System.out.println("Connecting to database.");
			
			con = DriverManager.getConnection(url, uid, pw);
			
			String fname = request.getParameter("fname");
			
			String lname = request.getParameter("lname");
			
			String address = request.getParameter("address");
			
			String email = request.getParameter("emailid");
			
			String phone = request.getParameter("phno");
			
			String uName = request.getParameter("uName");
			
			String psw = request.getParameter("psw");
			
			String companyName = request.getParameter("companyName");
			
				
				
			PreparedStatement pst = con.prepareStatement("INSERT INTO Users VALUES (?,?,?,?,?,?,?)");
				
			pst.setString(1, uName);
			pst.setString(2, psw);	
			pst.setString(3, fname);
			pst.setString(4, lname);
			pst.setString(5, address);
			pst.setString(6, email);
			pst.setString(7, phone);
				
				
			pst.executeUpdate();
			
			PreparedStatement pst2 = con.prepareStatement("SELECT COUNT(*) FROM Farmer");
				
			ResultSet rs = pst2.executeQuery();
				
			int fid = 1;
				
			if(rs.next()){
				fid = fid + rs.getInt(1);
			}
				
			PreparedStatement pst3 = null;
				
				
			pst3 = con.prepareStatement("INSERT INTO Farmer VALUES (?,?,?)");
				
			
			pst3.setInt(1, fid);
			pst3.setString(2, uName);
			pst3.setString(3, companyName);
				
			pst3.executeUpdate();
			
				
}
catch(SQLException e){
	out.print(e);
}
finally{
	try{
		if(con != null)
			con.close();
	}catch(SQLException e){
		out.print(e);
	}
}



%>

	<h1>Thanks for registering!</h1>
	<br>
	<a href="home.html"> Click here to Login! </a>

</body>
</html>