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

PreparedStatement pstmt = con.prepareStatement("Delete from gallery where name=?");
pstmt.setString(1, gallery_name);
pstmt.executeUpdate();

%>

<p> You successfully deleted a gallery </p>

<br>
<a href="galleries.jsp"> Go to Galleries </a>
