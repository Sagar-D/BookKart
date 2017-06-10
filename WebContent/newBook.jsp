<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>ADD A BOOK</title>

<meta charset="ISO-8859-1">
<link rel="stylesheet" href="indexStyleSheet.css" >

<script>
function uploadImage(){
	
	document.getElementById("imageUpload").click();
}



var loadFile = function(event) {
    var profile = document.getElementById('image');
    profile.src = URL.createObjectURL(event.target.files[0]);
    
  };
</script>


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
<font size="4" color="#545454"><strong>INCLUDE NEW BOOK </strong></font>
<br><br>

<form action="NewBook" method="Post" enctype="multipart/form-data">

<image id="image" src="images/default_book.png" height="150" onClick="uploadImage()" style="border:3px solid #545454;border-radius:15px;" /><br>
<input id="imageUpload" type="file" name="image" placeholder="Photo" style="display:none;" onchange="loadFile(event)" ><br>
<input type="text" name="id" placeholder="BOOK ID" style="border:2px solid #545454;margin:10px;border-radius:5px;width:200px;"/><br>
<input type="text" name="name" placeholder="BOOK NAME" style="border:2px solid #545454;margin:10px;border-radius:5px;width:200px;"/><br>
<input type="text" name="author" placeholder="AUTHOR NAME" style="border:2px solid #545454;margin:10px;border-radius:5px;width:200px;"/><br>
<input type="text" name="publication" placeholder="PUBLICATION" style="border:2px solid #545454;margin:10px;border-radius:5px;width:200px;"/><br>
<input type="text" name="mrp" placeholder="MRP" style="border:2px solid #545454;margin:10px;border-radius:5px;width:200px;"/><br>
<input type="number" name="count" placeholder="NUMBER OF COPIES" style="border:2px solid #545454;border-radius:5px;margin:10px;width:200px;" /><br>
<select name="catagory" style="border:2px solid #545454;border-radius:5px;margin:10px;color:#545454;height:30px;width:215px;">
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
<input type="submit" value="INCLUDE BOOK" style="border:2px solid #545454;border-radius:5px;margin:10px;" />

</form>

</div>

</body>
</html>