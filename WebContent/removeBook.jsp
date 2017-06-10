<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ADD A BOOK</title>

<meta charset="ISO-8859-1">
<link rel="stylesheet" href="indexStyleSheet.css" >

</head>
<body>

<%

HttpSession sn = request.getSession();
String name = sn.getAttribute("username").toString();
String pass = sn.getAttribute("password").toString();

if(!name.equals("admin") || !pass.equals("admin")){
	
%>
<jsp:forward page="index.html">
	<jsp:param value="Session etails not found,Please login again." name="msg"/>
</jsp:forward>
<%
}
%>

<header>
<h1>ONLINE BOOK PORTAL</h1>
</header>

<nav>
<ul>
<li> <a class='TabTitle'  href='admin.jsp' id='default'><strong>ADMIN</strong></a></li>
<li> <a class='TabTitle'  href='addBook.jsp'>ADD BOOK</a></li>
<li> <a class='TabTitle'  href='removeBook.jsp'>REMOVE BOOK</a></li>
<li> <a class='TabTitle'  href='newBook.jsp'>INCLUDE NEW BOOK</a></li>
<li> <a class='TabTitle'  href='Logout.jsp'>LOG OUT</a></li>
</ul>
</nav>

<div align="center">

<br><br>
<font size="4" color="#545454"><strong>REMOVE BOOK </strong></font>
<br><br>

<form action="RemoveBook" method="Post" >


<input type="text" name="id" placeholder="BOOK ID" style="border:2px solid #545454;margin:10px;border-radius:5px;width:200px;"/><br>
<input type="number" name="count" placeholder="NUMBER OF COPIES" style="border:2px solid #545454;border-radius:5px;margin:10px;width:200px;" /><br>
<select style="border:2px solid #545454;border-radius:5px;margin:10px;color:#545454;height:30px;width:215px;">
<option value="ss" default>SYSTEM SOFTWARE</option>
<option value="os">OPERATING SYSTEM</option>
<option value="java">JAVA</option>
<option value="cpp">C++</option>
<option value="c">C</option>
<option value="cg">COMPUTER GRAPHICS</option>
<option value="ml">MACHINE LEARNING</option>
<option value="dip">DIGITAL IMAGE PROCESSING</option>
</select>
<br>
<input type="submit" value="REMOVE BOOK" style="border:2px solid #545454;border-radius:5px;margin:10px;" />

</form>

</div>

</body>
</html>