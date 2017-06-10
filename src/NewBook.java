

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

import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext;

/**
 * Servlet implementation class NewBook
 */
@WebServlet("/NewBook")
public class NewBook extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	
	Connection con;
    Statement st;
    PreparedStatement ps;
    ResultSet rs;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NewBook() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    public void init() throws ServletException {
  	  // Initialization code...
  	
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


	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		PrintWriter writer = response.getWriter();
		
		String id=null,name=null,author=null,publication=null,mrp=null,count=null,catagory=null;
		byte[] b;
		Path path = Paths.get("C:\\Users\\sagar\\workspace\\Library Management\\WebContent\\images\\default_book.png");
		b = Files.readAllBytes(path);
		int profilepic=1,flag=0;

		writer.print("<!doctype html>"
				+ "<html>"
				+ "<head>"
				+ "<title>ONLINE BOOK PORTAL</title>"
				+ "<link href='css/bootstrap.min.css' rel='stylesheet'>"
				+ "<meta charset='utf-8' ><link rel='stylesheet' href='indexStyleSheet.css' >"
				+ "</head>"
				+ "<body>"
				+ "<header>"
				+ "<h1>ONLINE BOOK PORTAL</h1>"
				+ "</header>"
				+ "<nav>"
				+ "<ul>"
				+ "<li> <a class='TabTitle'  href='admin.jsp' id='default'><strong>ADMIN</strong></a></li>"
				+ "<li> <a class='TabTitle'  href='addBook.jsp'>ADD BOOK</a></li>"
				+ "<li> <a class='TabTitle'  href='removeBook.jsp'>REMOVE BOOK</a></li>"
				+ "<li> <a class='TabTitle'  href='newBook.jsp'>INCLUDE NEW BOOK</a></li>"
				+ "<li> <a class='TabTitle'  href='Logout.jsp'>LOG OUT</a></li>"
				+ "</ul>"
				+ "</nav>");
		
		
		if(ServletFileUpload.isMultipartContent(request)){
			DiskFileItemFactory itemFactory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(itemFactory);
			
			try {
				List<FileItem> items = upload.parseRequest(new ServletRequestContext(request));
				
				id = items.get(1).getString();
				name = items.get(2).getString();
				author=items.get(3).getString();
				publication=items.get(4).getString();
				mrp = items.get(5).getString();
				count = items.get(6).getString();
				catagory = items.get(7).getString();
				
				
					
				
				
				if(items.get(0).getSize()!=0)
					b = items.get(0).get();
				
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
			try{
				
				if(con!=null){
					
					
					ps = con.prepareStatement("INSERT INTO books VALUES(?,?,?,?,?,?,?,?);");
					
					ps.setString(1, id);
					ps.setString(2, name);
					ps.setString(3, author);
					ps.setString(4, publication);
					ps.setFloat(5, Float.parseFloat(mrp));
					ps.setInt(6, Integer.parseInt(count));
					ps.setString(7, catagory);
					ps.setBytes(8, b);
			
					
					flag=ps.executeUpdate();
				}
				
			}catch(Exception e){
				
				System.out.println(e);
				writer.print("<br><br><br><br><h2 align='center'>SORRY, WE ENCOUNTERED A ERROR..</h2><h3 align='center'>PLEASE TRY AGAIN LATER</h3>");
				
			}

			if(flag==1)
				writer.println("<br><h2 align='center' >NEW BOOK HAS BEEN ADDED TO STORE</h2><p align='center'>Below is the details of the book</p>");
				writer.println("<div class='container'>"
				+ "<div class='row'>"
				+ "<div class='col-xs-12 col-sm-6 col-md-6 col-lg-6 col-xl-6' align='center'>"
				+ "<img class='card-img-top' src='ShowImage?type=book&id="+id+"' alt='Card image cap' height='400px' style='border: 2px solid #545454;padding:0px;margin: 50px;'>"
				+ "</div>"
				+ "<div align='center' class='col-xs-12 col-sm-6 col-md-6 col-lg-6 col-xl-6' >"
				+ "<br/>"
				+ "<table>"
				
				+ "<tr style='border-bottom: 1px solid #545454;'>"
				+ "		<td class='desc_table' style='padding: 10px; margin: 20px; '>NAME</td>"
				+ "		<td class='desc_table' style='padding: 0px; margin: 0px; '> : </td>"
				+ "		<td class='desc_table' style='padding: 10px; margin: 20px; '>"+name+"</td>"
				+ "		</tr>"
				+ "<tr style='border-bottom: 1px solid #545454;'>"
				+ "		<td class='desc_table' style='padding: 10px; margin: 20px; '>ID</td>"
				+ "		<td class='desc_table' style='padding: 0px; margin: 0px; '> : </td>"
				+ "		<td class='desc_table' style='padding: 10px; margin: 20px; '>"+id+"</td>"
				+ "		</tr>"
				+ "<tr style='border-bottom: 1px solid #545454;'>"
				+ "		<td class='desc_table' style='padding: 10px; margin: 20px; '>AUTHOR</td>"
				+ "		<td class='desc_table' style='padding: 0px; margin: 0px; '> : </td>"
				+ "		<td class='desc_table' style='padding: 10px; margin: 20px; '>"+author+"</td>"
				+ "		</tr>"
				+ "<tr style='border-bottom: 1px solid #545454;'>"
				+ "		<td class='desc_table' style='padding: 10px; margin: 20px; '>PUBLICATION</td>"
				+ "		<td class='desc_table' style='padding: 0px; margin: 0px; '> : </td>"
				+ "		<td class='desc_table' style='padding: 10px; margin: 20px; '>"+publication+"</td>"
				+ "		</tr>"
				+ "<tr style='border-bottom: 1px solid #545454;'>"
				+ "		<td class='desc_table' style='padding: 10px; margin: 20px; '>MRP</td>"
				+ "		<td class='desc_table' style='padding: 0px; margin: 0px; '> : </td>"
				+ "		<td class='desc_table' style='padding: 10px; margin: 20px; '>Rs."+mrp+"</td>"
				+ "		</tr>"
				+ "<tr style='border-bottom: 1px solid #545454;'>"
				+ "		<td class='desc_table' style='padding: 10px; margin: 20px; '>AVAILABILITY</td>"
				+ "		<td class='desc_table' style='padding: 0px; margin: 0px; '> : </td>"
				+ "		<td class='desc_table' style='padding: 10px; margin: 20px; '>"+count+" pcs</td>"
				+ "		</tr>"
				+ "</table>"	
				+ "</div>"
				+ "</div>"
				+ "</div>");
			
			
		}
		
		
		
	}

}
