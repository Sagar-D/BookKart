<%@ page language="java" contentType="text/html; charset=ISO-8859-1" import="java.util.*,java.sql.*,java.util.Date"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>BILLING</title>
<meta charset="ISO-8859-1">
<link rel="stylesheet" href="indexStyleSheet.css" >
</head>
<body>

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


<%
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/library","root","mysql");


HttpSession sn = request.getSession(true);
String username = sn.getAttribute("username").toString();

Random rand = new Random();
Date date = new Date();

String book_id = request.getParameter("id");
Statement st = con.createStatement();
ResultSet rs=st.executeQuery("Select * from books where id like '"+book_id+"' ;");
rs.next();

if(rs.getInt("availability")>0){

PreparedStatement ps = con.prepareStatement("Update books set availability = availability - 1 where id like ? ;");
ps.setString(1,book_id);
ps.executeUpdate();
%>

<div align="center" >
<h1 style="background-color:white;color:#545454;">TRANSACTION SUCCESSFUL</h1>
<h2> Billing Details</h2>
			<img class="card-img-top" src="ShowImage?type=book&id=<%=rs.getString("id") %> " alt="Card image cap" height="200px" style="border: 2px solid #545454;padding:0px;margin: 10px;">
		
			<br>
			<table>
				<tr style="border-bottom: 1px solid #545454;">
					<td class="desc_table" style="padding: 10px; margin: 20px; ">INVOICE ID</td>
					<td class="desc_table" style="padding: 0px; margin: 0px; "> : </td>
					<td class="desc_table" style="padding: 10px; margin: 20px; "><%=book_id+rand.nextInt(1000) %></td>
				</tr>
				<tr style="border-bottom: 1px solid #545454;">
					<td class="desc_table" style="padding: 10px; margin: 20px; ">DATE OF PURCHASE :</td>
					<td class="desc_table" style="padding: 0px; margin: 0px; "> : </td>
					<td class="desc_table" style="padding: 10px; margin: 20px; "><%= date.toString()%></td>
				</tr>
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
				
				
									
			</table>
				
			<br>
<%

rs = st.executeQuery("Select * from userdetails where email like '"+username+"' ;");
rs.next();
%>			
			<h2> Delivery Details </h2>
			<table>
				<tr style="border-bottom: 1px solid #545454;">
					<td class="desc_table" style="padding: 10px; margin: 20px; ">NAME</td>
					<td class="desc_table" style="padding: 0px; margin: 0px; "> : </td>
					<td class="desc_table" style="padding: 10px; margin: 20px; "><%=rs.getString("name") %></td>
				</tr>
				<tr style="border-bottom: 1px solid #545454;">
					<td class="desc_table" style="padding: 10px; margin: 20px; ">ADDRESS :</td>
					<td class="desc_table" style="padding: 0px; margin: 0px; "> : </td>
					<td class="desc_table" style="padding: 10px; margin: 20px; "><%= rs.getString("address")%><br><%=rs.getString("state")%> - <%= rs.getString("pincode") %></td>
				</tr>
				<tr style="border-bottom: 1px solid #545454;">
					<td class="desc_table" style="padding: 10px; margin: 20px; ">CONTACT NUMBER</td>
					<td class="desc_table" style="padding: 0px; margin: 0px; "> : </td>
					<td class="desc_table" style="padding: 10px; margin: 20px; "><%= rs.getString("phone") %></td>
				</tr>
				<tr style="border-bottom: 1px solid #545454;">
					<td class="desc_table" style="padding: 10px; margin: 20px; ">EMAIL ID</td>
					<td class="desc_table" style="padding: 0px; margin: 0px; "> : </td>
					<td class="desc_table" style="padding: 10px; margin: 20px; "><%=rs.getString("email") %></td>
				</tr>
														
			</table>
			<br><br>
			

</div>

<%

String books = rs.getString("books");
books += book_id+" ";

ps = con.prepareStatement("Update userdetails set books = ? where email like ? ;");
ps.setString(1,books);
ps.setString(2,username);
ps.executeUpdate();

}
else{
	
%>
<div align="center">

<h2>SORRY, NO STOCK AVAILABLE</h2>

</div>
<%
}
%>
</body>
</html>