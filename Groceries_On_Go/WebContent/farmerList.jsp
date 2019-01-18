<%@page import="com.sun.javafx.collections.ArrayListenerHelper"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>


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
			
			ArrayList<Integer> fId = new ArrayList<>();
			ArrayList<String> uName = new ArrayList<>();
			ArrayList<String> companyName = new ArrayList<>();
			ArrayList<String> address = new ArrayList<>();
			
			String utype = request.getParameter("type");
			
			String loggername = request.getParameter("loggername");
			
			
			

try{
		
		
		
		con = DriverManager.getConnection(url, uid, pw);
		
		
		
		PreparedStatement pst = con.prepareStatement("SELECT fid, f.username, address, companyName FROM Farmer f, Users u WHERE f.username=u.username");
		
		
		ResultSet rs = pst.executeQuery();
		
		
		
		
		
		while(rs.next()){
			
			fId.add(rs.getInt(1));
			uName.add(rs.getString(2));
			address.add(rs.getString(3));
			companyName.add(rs.getString(4));
			
			
		}
		
		
		}
		catch(SQLException e){
			
			out.println("Exception");
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
 
 
 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>






<div class="container">
    <div class="well well-sm">
        <strong>Farmers List</strong>
        
    </div>
    
   				
			

	<% 
	
		for(int i = 0; i < fId.size(); i++){
	
     %>
     <div class="item  col-xs-4 col-lg-4">
            <div class="thumbnail">
                <img class="group list-group-image" src="http://placehold.it/400x250/000/fff" alt="" />
                <div class="caption">
                    <h4 class="group inner list-group-item-heading">
                        <%=companyName.get(i) %></h4>
                    <p class="group inner list-group-item-text">
                       <%=address.get(i) %>.</p>
                    <div class="row">
                        <div class="col-xs-12 col-md-6">
                            <p class="lead">
                               <%%> </p>
                        </div>
                        <div class="col-xs-12 col-md-6">
                            <a class="btn btn-success" href="plist.jsp?id=<%=fId.get(i) %>&utype=<%=utype%>&loggername=<%=loggername%>">Shop</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        
        <%
		}
        %>
        
 </div>
 </body>
</html>
 
 
			
   


    


