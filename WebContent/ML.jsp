<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="java.util.*,java.sql.*,java.io.*"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

 <link href="css/bootstrap.min.css" rel="stylesheet">

<meta charset="ISO-8859-1">
<link rel="stylesheet" href="indexStyleSheet.css" >
<title>Machine Learning</title>

<style>
	
	.card{
		
		transition: 0.1s;
	}
	
	.card:hover {
		box-shadow: 0 8px 16px 0 #545454;
		cursor:pointer;
	}


</style>


	<script>
	
	

	
		function showDetails(btId,descId) {
			
			 modal = document.getElementById(descId);
			
			var btn = document.getElementById(btId);
			
			modal.style.display = "block";
			
			
		}
		
		
		function onSpanClick(descId) {
			
			var modal = document.getElementById(descId);
			modal.style.display = "none";
		}
		

		window.onclick = function(event) {

		if (event.target == modal) {
			modal.style.display = "none";
		}
		
		
		}
</script>
	

</head>
<body style="color: #545454" >

<%
HttpSession sn = request.getSession(true);
String username=sn.getAttribute("username").toString();
String password=sn.getAttribute("password").toString();
boolean login = false;

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/library","root","mysql");
try{
PreparedStatement ps = con.prepareStatement("Select * from userdetails where email like ?;");
ps.setString(1,username);

ResultSet rs = ps.executeQuery();
if(rs.next()){
	if(rs.getString("password").equals(password)){
		login=true;
	}
}



}
catch(Exception e){
	e.printStackTrace();
	out.println(e.toString());
	
}


if(!login){
%>
	<jsp:forward page="index.html">
		<jsp:param name="msg" value="Session Timed Out. Please Login Again"/>	
	</jsp:forward>
<%
}
sn.setAttribute("username",username);
sn.setAttribute("password",password);

%>
 
<header>
<h1>ONLINE BOOK PORTAL</h1>
</header>
 <nav>
<ul>
<li> <a class='TabTitle'  href='MyProfile.jsp' id='default'><strong>MY PROFILE</strong></a></li>
<li> <a class='TabTitle'  href='SS.jsp'>SYSTEM SOFTWARE</a></li>
<li> <a class='TabTitle'  href='OS.jsp'>OPERATING SYSTEM</a></li>
<li> <a class='TabTitle'  href='Java.jsp'>JAVA</a></li>
<li> <a class='TabTitle'  href='CPP.jsp'>C++</a></li>
<li> <a class='TabTitle'  href='C.jsp'>C</a></li>
<li> <a class='TabTitle'  href='CG.jsp'>COMPUTER GRAPHICS</a></li>
<li> <a class='TabTitle'  href='ML.jsp'>MACHINE LEARNING</a></li>
<li> <a class='TabTitle'  href='DIP.jsp'>DIGITAL IMAGE PROCESSING</a></li>
<li> <a class='TabTitle'  href='Logout.jsp'>LOG OUT</a></li>
</ul>
</nav>



<div class="container" style="margin-top: 30px; margin-bottom: 30px;">
<div class="row">
<%

PreparedStatement ps = con.prepareStatement("Select * from books where catagory like 'ml';");
ResultSet rs = ps.executeQuery();
while(rs.next()){
	String id = rs.getString("id");
	String path = "ShowImage?type=book&id="+id;
%>



<div class="col-xs-12 col-sm-6 col-md-3 col-lg-3 col-xl-2">
				<div class="card" style="margin:0px; margin-bottom: 50px;  padding: 0px; " onClick="showDetails('bt<%=id %>','<%=id%>')">
			
				<div class="card-block" align="center">
				<img class="card-img-top" src="<%=path %>" alt="Card image cap" height="200px" width="150px">
				<br><br><strong><%=rs.getString("name") %></strong>
				<br><i>- <%=rs.getString("author") %></i><br>
				<button id="bt<%=id%>" style="margin:10px; background-color:#545454; border: 0; color: #fff; padding: 5px 40px 5px 40px;" align="center" onClick="showDetails('bt<%=id %>','<%=id%>')" >VIEW DETAILS</button>
				</div>
				</div>
				</div>
				



<div id="<%= id %>" class="modal">
			
				<!-- Modal content -->
				<div class="modal-content" style="margin:70px;">
					<span  class="close" style="padding:10px;" onClick="onSpanClick('<%=id %>')" >&times;</span>
					<div class="container">
					<div class="row">
					<div class="col-xs-12 col-sm-6 col-md-6 col-lg-6 col-xl-6" align="center">
					<img class="card-img-top" src="<%=path %>" alt="Card image cap" height="400px" style="border: 2px solid #545454;padding:0px;margin: 50px;">
					</div>
					<div align="center" class="col-xs-12 col-sm-6 col-md-6 col-lg-6 col-xl-6" >
					<br/>
					<table>
					<tr style="border-bottom: 1px solid #545454;">
							<td class="desc_table" style="padding: 10px; margin: 20px; ">NAME</td>
							<td class="desc_table" style="padding: 0px; margin: 0px; "> : </td>
							<td class="desc_table" style="padding: 10px; margin: 20px; "><%= rs.getString("name") %></td>
							</tr>
					<tr style="border-bottom: 1px solid #545454;">
							<td class="desc_table" style="padding: 10px; margin: 20px; ">AUTHOR</td>
							<td class="desc_table" style="padding: 0px; margin: 0px; "> : </td>
							<td class="desc_table" style="padding: 10px; margin: 20px; "><%=rs.getString("author") %></td>
							</tr>
					<tr style="border-bottom: 1px solid #545454;">
							<td class="desc_table" style="padding: 10px; margin: 20px; ">PUBLICATION</td>
							<td class="desc_table" style="padding: 0px; margin: 0px; "> : </td>
							<td class="desc_table" style="padding: 10px; margin: 20px; "><%=rs.getString("publication") %></td>
							</tr>
					<tr style="border-bottom: 1px solid #545454;">
							<td class="desc_table" style="padding: 10px; margin: 20px; ">MRP</td>
							<td class="desc_table" style="padding: 0px; margin: 0px; "> : </td>
							<td class="desc_table" style="padding: 10px; margin: 20px; "><%=rs.getFloat("mrp") %></td>
							</tr>
					<tr style="border-bottom: 1px solid #545454;">
							<td class="desc_table" style="padding: 10px; margin: 20px; ">AVAILABILITY</td>
							<td class="desc_table" style="padding: 0px; margin: 0px; "> : </td>
							<td class="desc_table" style="padding: 10px; margin: 20px; "><%=rs.getInt("availability") %></td>
							</tr>
						
					</table>
				
					<br><br><br>
					<a href="Bill.jsp?id=<%=id%>" ><button style="margin:10px; background-color:#545454; border: 0; color: #fff; padding: 5px 40px 5px 40px;" align="center" > BUY NOW </button></a>
				
					</div>
					</div>
					</div>
				</div>

</div>


<%


}

%>

</div>
</div>

</body>
</html>