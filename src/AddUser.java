

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.FileUploadException;
import org.apache.tomcat.util.http.fileupload.FileUtils;
import org.apache.tomcat.util.http.fileupload.RequestContext;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext;



/**
 * Servlet implementation class AddUser
 */
@WebServlet("/AddUser")
public class AddUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	Connection con;
    Statement st;
    PreparedStatement ps;
    ResultSet rs;
	
	public void init() throws ServletException{
		
		 try {
				Class.forName("com.mysql.jdbc.Driver");
		        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/library","root","mysql");

		        
			} catch (ClassNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	         
		
	}
       
    
    public AddUser() {
        super();
        // TODO Auto-generated constructor stub
    }



	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		PrintWriter writer = response.getWriter();
		
		String name=null,adr=null,state=null,pin=null,phone=null,email=null,pass=null;
		byte[] b;
		Path path = Paths.get("C:\\Users\\sagar\\workspace\\Library Management\\WebContent\\images\\default_profile.png");
		b = Files.readAllBytes(path);
		int profilepic=1,flag=0;

		writer.print("<!doctype html>"
				+ "<html>"
				+ "<head>"
				+ "<title>ONLINE BOOK PORTAL</title>"
				+ "<meta charset='utf-8' ><link rel='stylesheet' href='indexStyleSheet.css' >"
				+ "</head>"
				+ "<body>"
				+ "<header>"
				+ "<h1>ONLINE BOOK PORTAL</h1>"
				+ "</header>"
				+ "<nav>"
				+ "<ul>"
				+ "<li> <a class='TabTitle'  href='index.html' id='default'><strong>MY PROFILE</strong></a></li>"
				+ "<li> <a class='TabTitle'  href='transplant.html'>SYSTEM SOFTWARE</a></li>"
				+ "<li> <a class='TabTitle'  href='transplant.html'>OPERATING SYSTEM</a></li>"
				+ "<li> <a class='TabTitle'  href='transplant.html'>JAVA</a></li>"
				+ "<li> <a class='TabTitle'  href='Availability'>C++</a></li>"
				+ "<li> <a class='TabTitle'  href='Availability'>C</a></li>"
				+ "<li> <a class='TabTitle'  href='Availability'>COMPUTER GRAPHICS</a></li>"
				+ "<li> <a class='TabTitle'  href='Availability'>MACHINE LEARNING</a></li>"
				+ "<li> <a class='TabTitle'  href='Availability'>DIGITAL IMAGE PROCESSING</a></li>"
				+ "<li> <a class='TabTitle'  href='Availability'>LOG OUT</a></li>"
				+ "</ul>"
				+ "</nav>");
		
		
		if(ServletFileUpload.isMultipartContent(request)){
			DiskFileItemFactory itemFactory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(itemFactory);
			
			try {
				List<FileItem> items = upload.parseRequest(new ServletRequestContext(request));
				
				name = items.get(1).getString();
				adr = items.get(2).getString();
				state=items.get(3).getString();
				pin=items.get(4).getString();
				phone = items.get(5).getString();
				email = items.get(6).getString();
				pass = items.get(7).getString();
				
				
					
				
				
				if(items.get(0).getSize()!=0)
					b = items.get(0).get();
				
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
			try{
				
				if(con!=null){
					
					
					ps = con.prepareStatement("INSERT INTO userdetails VALUES(?,?,?,?,?,?,?,?,?);");
					
					ps.setString(1, name);
					ps.setString(2, adr);
					ps.setString(3, state);
					ps.setString(4, pin);
					ps.setString(5, phone);
					ps.setString(6, email);
					ps.setString(7, pass);
					ps.setString(8, "");
					ps.setBytes(9, b);
			
					
					flag=ps.executeUpdate();
				}
				
			}catch(Exception e){
				
				System.out.println(e);
				writer.print("<br><br><br><br><h2 align='center'>SORRY, WE ENCOUNTERED A ERROR..</h2><h3 align='center'>PLEASE TRY AGAIN LATER</h3>");
				
			}

			if(flag==1)
				writer.println("<br><br><br><br><h2 align='center' >THANK YOU FOR SIGNING UP</h2><p align='center'><a href='index.html'>Click Here to LogIn</a></p>");
			
			
			
		}
		
		
	}

}
