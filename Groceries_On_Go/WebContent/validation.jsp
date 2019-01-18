<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Validation Page</title>
</head>
<body>

<%
	out.println("HERE");
	try { // Load driver class
		Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
	} catch (java.lang.ClassNotFoundException e) {
		out.println("ClassNotFoundException: " + e);
	}
	out.println("HERE2");
				String url = "jdbc:sqlserver://sql04.ok.ubc.ca:1433;DatabaseName=db_psingh;";
				String uid = "psingh";
				String pw = "71364251";

				Connection con = null;

try{
			
			System.out.println("Connecting to database.");
			
			con = DriverManager.getConnection(url, uid, pw);
			
			
			String uname = request.getParameter("uname");
			
			String psw = request.getParameter("psw");
			
			
			PreparedStatement pst = con.prepareStatement("SELECT username, password FROM Users WHERE username = ? AND password = ?");
			
			pst.setString(1, uname);
			pst.setString(2, psw);
			
			ResultSet rs = pst.executeQuery();
			
			int count = 0;
			
			if(rs.next()){
				count++;
				//response.sendRedirect("listprod.jsp");
			}
			
			else{
				 %>
				 
				<center><h1>Invalid Username or Password! Try Again! <br> Redirecting to Login Page...</h1></center> 
				<meta http-equiv="Refresh" content="3; url= home.html"> 
				<%
			}
			
			
			if(count>0){
				
				
				
				PreparedStatement pst2 = con.prepareStatement("SELECT fId FROM Farmer WHERE username = ? ");
				pst2.setString(1, uname);
				
				ResultSet rs2 = pst2.executeQuery();
				
				if(rs2.next()){
					String utype = "farmer";
					response.sendRedirect("farmerList.jsp?type="+utype+"&loggername="+uname);
				}
				
				
				
				PreparedStatement pst3 = con.prepareStatement("SELECT cId FROM Customers WHERE username = ? ");
				pst3.setString(1, uname);
				
				ResultSet rs3 = pst3.executeQuery();
				
				if(rs3.next()){
					String utype = "customer";
					response.sendRedirect("farmerList.jsp?type="+utype+"&loggername="+uname);
				}
				
				PreparedStatement pst4 = con.prepareStatement("SELECT dId FROM Driver WHERE username = ? ");
				pst4.setString(1, uname);
				
				ResultSet rs4 = pst4.executeQuery();
				
				
				if(rs4.next()){
					String utype = "driver";
					response.sendRedirect("farmerList.jsp?type="+utype+"&loggername="+uname);
				}
				
				
				
				
			}
			
			
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

</body>
</html>