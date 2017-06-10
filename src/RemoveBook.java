

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class RemoveBook
 */
@WebServlet("/RemoveBook")
public class RemoveBook extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	Connection con;
    Statement st;
    PreparedStatement ps;
    ResultSet rs;
	

    public RemoveBook() {
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
PrintWriter writer = response.getWriter();
		
		String id=null,count=null,catagory=null;
		
		int flag=0;

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
		
		
			
			try {
				
				id = request.getParameter("id");
				count = request.getParameter("count");
				catagory = request.getParameter("catagory");
								
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
			try{
				
				if(con!=null){
					
					
					ps = con.prepareStatement("Update books set availability = availability - ? where id like ? ;");
					ps.setInt(1, Integer.parseInt(count));
					ps.setString(2, id);
					
					flag=ps.executeUpdate();
				}
				
			}catch(Exception e){
				
				System.out.println(e);
				writer.print("<br><br><br><br><h2 align='center'>SORRY, WE ENCOUNTERED A ERROR..</h2><h3 align='center'>PLEASE TRY AGAIN LATER</h3>");
				
			}
			
			try{
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("Select * from books where id like '"+id+"' ;");
			rs.next();
			if(flag==1)
				writer.println("<br><h2 align='center' >BOOKS HAVE BEEN ADDED TO STORE</h2><p align='center'>Below is the details of the book</p>");
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
				+ "		<td class='desc_table' style='padding: 10px; margin: 20px; '>"+rs.getString("name")+"</td>"
				+ "		</tr>"
				+ "<tr style='border-bottom: 1px solid #545454;'>"
				+ "		<td class='desc_table' style='padding: 10px; margin: 20px; '>ID</td>"
				+ "		<td class='desc_table' style='padding: 0px; margin: 0px; '> : </td>"
				+ "		<td class='desc_table' style='padding: 10px; margin: 20px; '>"+id+"</td>"
				+ "		</tr>"
				+ "<tr style='border-bottom: 1px solid #545454;'>"
				+ "		<td class='desc_table' style='padding: 10px; margin: 20px; '>AUTHOR</td>"
				+ "		<td class='desc_table' style='padding: 0px; margin: 0px; '> : </td>"
				+ "		<td class='desc_table' style='padding: 10px; margin: 20px; '>"+rs.getString("author")+"</td>"
				+ "		</tr>"
				+ "<tr style='border-bottom: 1px solid #545454;'>"
				+ "		<td class='desc_table' style='padding: 10px; margin: 20px; '>PUBLICATION</td>"
				+ "		<td class='desc_table' style='padding: 0px; margin: 0px; '> : </td>"
				+ "		<td class='desc_table' style='padding: 10px; margin: 20px; '>"+rs.getString("publication")+"</td>"
				+ "		</tr>"
				+ "<tr style='border-bottom: 1px solid #545454;'>"
				+ "		<td class='desc_table' style='padding: 10px; margin: 20px; '>MRP</td>"
				+ "		<td class='desc_table' style='padding: 0px; margin: 0px; '> : </td>"
				+ "		<td class='desc_table' style='padding: 10px; margin: 20px; '>Rs."+rs.getFloat("mrp")+"</td>"
				+ "		</tr>"
				+ "<tr style='border-bottom: 1px solid #545454;'>"
				+ "		<td class='desc_table' style='padding: 10px; margin: 20px; '>AVAILABILITY</td>"
				+ "		<td class='desc_table' style='padding: 0px; margin: 0px; '> : </td>"
				+ "		<td class='desc_table' style='padding: 10px; margin: 20px; '>"+rs.getInt("availability")+" pcs</td>"
				+ "		</tr>"
				+ "</table>"	
				+ "</div>"
				+ "</div>"
				+ "</div>");
			
			}catch(Exception e){
				e.printStackTrace();
			}
		
		
		
		
	}

}
