<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ADMINISTRATION</title>

<link href="css/bootstrap.min.css" rel="stylesheet">

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


</body>
</html>