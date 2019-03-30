<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*"%>

<%try {
Class.forName("com.mysql.jdbc.Driver").newInstance();
}
catch(Exception e) {
out.println("can't load mysql driver");
out.println(e.toString());
}


//String street = request.getParameter("street");
String url="jdbc:mysql://127.0.0.1:3306/gallery";
String id="gallery";
String pwd="eecs118";
Connection con = DriverManager.getConnection(url,id,pwd);


//get the info submitted by user
String gallery_name = request.getParameter("gallery");
String gallery_description = request.getParameter("gallery_description");
/*Statement stmt = con.createStatement();
String sql="SELECT * FROM gallery";
ResultSet rs = stmt.executeQuery(sql);

while (rs.next()) {
out.println("<tr>");
out.println("<td>"+rs.getString("gallery_id")+"</td>");
out.println("<td>"+rs.getString("name")+"</td>");
out.println("<td>"+rs.getString("description")+"</td>");
//out.println("<td>"+rs.getString("customer_city")+"</td>");
out.println("</tr>");
}*/

//Submit info to the database
PreparedStatement pstmt = con.prepareStatement("insert into gallery values(default,?,?)",Statement.RETURN_GENERATED_KEYS);
pstmt.clearParameters();
pstmt.setString(1, gallery_name);
pstmt.setString(2, gallery_description);
pstmt.executeUpdate();
/*rs=pstmt.getGeneratedKeys();
while (rs.next()) {
out.println("Successfully added. Customer_ID:"+rs.getInt(1));
}*/
%>

<p> You successfully created a new gallery </p>
<a href="index.jsp"> Go back to home </a>
<br>
<a href="galleries.jsp"> Go to galleries </a>
