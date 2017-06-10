<%@ page language="java" import="java.util.*,java.sql.*" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<link href="css/bootstrap.min.css" rel="stylesheet">

<meta charset="ISO-8859-1">
<link rel="stylesheet" href="indexStyleSheet.css" >
<title>Log In</title>


	

</head>
<body style="color: #545454" >

<%
HttpSession sn = request.getSession(true);

String username="";
String password="";

try{
	username=request.getParameter("username").toString();
	password=request.getParameter("password").toString();
}catch (Exception e){
	username=sn.getAttribute("username").toString();
	password=sn.getAttribute("password").toString();
}
if(username.equals("")){
	username=sn.getAttribute("username").toString();
	password=sn.getAttribute("password").toString();
}
boolean login = false;

Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/library","root","mysql");
try{
PreparedStatement ps = con.prepareStatement("Select * from userdetails where email like ?;");
ps.setString(1,username);
System.out.println(username+" HAHA "+password);
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

if(username.equals("admin") && password.equals("admin")){
	sn.setAttribute("username", "admin");
	sn.setAttribute("password","admin");
%>

	<jsp:forward page="admin.jsp" />

<%
}
if(!login){
%>
	<jsp:forward page="index.html">
		<jsp:param name="msg" value="Username Or Password You Entered is Wrong!!"/>	
	</jsp:forward>
<%
}


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

<%
sn.setAttribute("username",username);
sn.setAttribute("password",password);

System.out.println(sn.getAttribute("username")+" "+sn.getAttribute("password"));
PreparedStatement ps=con.prepareStatement("Select * from userdetails where email like ?;");
ps.setString(1,username);
ResultSet rs = ps.executeQuery();
rs.next();
String name = rs.getString("name");
String address = rs.getString("address");
String state = rs.getString("state");
String pincode = rs.getString("pincode");
String phone = rs.getString("phone");
String email = rs.getString("email");
byte[] profilepic = rs.getBytes("image");
String imgsrc;

imgsrc="ShowImage?type=profile&id="+email;
System.out.println(imgsrc);
%>

<div class="container">
<div class="row" style="padding:20px;">
<div class="col-xs-12 col-sm-6 col-md-4 col-lg-4 col-xl-2" align="center">

<img src='<%=imgsrc %>' height="200px" style="border: 2px solid #545454;border-radius:20px;" />

</div>
<div class="col-xs-12 col-sm-6 col-md-8 col-lg-8 col-xl-10" align="center">
<h2><strong>Welcome <%=name %></strong></h2><br>
<table>
<tr><td><strong>NAME </strong></td><td>: <%=name %></td></tr>
<tr><td><strong>ADDRESS<br>&emsp;</strong></td><td>: <%=address %><br>&ensp;<%=state %> - <%=pincode %></td></tr>
<tr><td><strong>PHONE NO </strong></td><td>: <%=phone %></td></tr>
<tr><td><strong>EMAIL </strong></td><td>: <%=email %></td></tr>
</table>
</div>
</div>
</div>
<h3 style="background-color: #545454;color:white;padding:10px;margin:25px;" align="center"><i>MY BOOKS</i></h3>
<%



ps = con.prepareStatement("Select * from userdetails where email like ? ;");
ps.setString(1,username);
rs = ps.executeQuery();
if(rs.next())
{
	String books =  rs.getString("books");
	
	if(!books.equals(""))
	{
		String[] str =books.split(" ");
		for(int i=0;i<str.length;i++){
			ps = con.prepareStatement("Select * from books where id like ? ;");
			ps.setString(1,str[i]);
			rs = ps.executeQuery();
			rs.next();
			String path = "ShowImage?type=book&id="+rs.getString("id");
	
%>

<div class="container">
<div class="row">
<div class="col-xs-12 col-sm-6 col-md-3 col-lg-3 col-xl-3" align="center">
<div class="card" style="margin:0px; margin-bottom: 50px;  padding: 0px; ">
			
				<div class="card-block" align="center">
				<img class="card-img-top" src="<%=path %>" alt="Card image cap" height="200px" width="150px">
				<br><br><strong><%=rs.getString("name") %></strong>
				<br><i>- <%=rs.getString("author") %></i><br>
				</div>
				</div>
</div>

<%
		}
	}
}
%>
</div>
</div>
</body>
</html>