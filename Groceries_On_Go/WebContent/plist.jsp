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
			
			ArrayList<Integer> pId = new ArrayList<>();
			ArrayList<String> pName = new ArrayList<>();
			ArrayList<String> pDesc = new ArrayList<>();
			ArrayList<Double> stock = new ArrayList<>();
			ArrayList<Double> price = new ArrayList<>();
			ArrayList<String> category = new ArrayList<>();
			
			int fId = Integer.parseInt(request.getParameter("id"));
			
			String utype = request.getParameter("utype");
			
			String custName = request.getParameter("loggername");
			
			
		
			

try{
	
	con = DriverManager.getConnection(url, uid, pw);
	
	
	String pname = request.getParameter("productName");
	
	
	
	ResultSet rs;
	
	if(pname == null || pname == ""){

		PreparedStatement pst = con.prepareStatement("SELECT * FROM Products WHERE fId = ?");
		
		pst.setInt(1, fId);
		
		
		rs = pst.executeQuery();
		
	}else{
		
		
		String q = "SELECT * FROM Products WHERE productName LIKE '%" + pname + "%' AND fID = " + fId;
		PreparedStatement pstmt = con.prepareStatement(q);
		
		rs = pstmt.executeQuery();
	}
		
		
		
		
		
		
		while(rs.next()){
			
			pId.add(rs.getInt(1));
			pName.add(rs.getString(2));
			pDesc.add(rs.getString(3));
			stock.add(rs.getDouble(4));
			price.add(rs.getDouble(5));
			category.add(rs.getString(7));
			
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
        <strong>Products List</strong>
        
    </div>
    
  <form method="get" action="plist.jsp">
		<input type="text" name="productName" size="50"> 
		<input type="submit" value="Submit">
		<input type="reset"	value="Reset"> (Leave blank for all products)
	</form>
   				
			

	<% 
	
		for(int i = 0; i < pId.size(); i++){
	
     %>
     
     <div class="item  col-xs-4 col-lg-4">
            <div class="thumbnail">
                <img class="group list-group-image" src="http://placehold.it/400x250/000/fff" alt="" />
                <div class="caption">
                    <h4 class="group inner list-group-item-heading">
                        <%=pName.get(i) %></h4>
                        
                    
                    <p class="group inner list-group-item-text">
                       <%=pDesc.get(i) %>.</p>
                    <div class="row">
                        <div class="col-xs-12 col-md-6">
                            <p class="lead">
                               $<%=price.get(i) %> </p>
                              
                                                            
                       
                               	 <div class="col-xs-12 col-md-6">
                        	
                           				
                           				<a  class="btn btn-success" href="inOrder.jsp?pid=<%=pId.get(i)%>&custName=<%=custName %>&pName=<%=pName.get(i) %>&pDesc=<%=pDesc.get(i) %>&price=<%=price.get(i) %>"><font size="4"><b>Add to cart</b></font></a>
                           				 
  									
  								</div>
  								
  								
								
                     				
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
 
 
			
   


    


