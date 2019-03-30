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

String name = request.getParameter("name");
int year = Integer.parseInt(request.getParameter("year"));
String country = request.getParameter("country");
String description = request.getParameter("description");

PreparedStatement pstmt = con.prepareStatement("insert into artist values(default,?,?,?,?)");
pstmt.setString(1, name);
pstmt.setInt(2, year);
pstmt.setString(3, country);
pstmt.setString(4, description);
pstmt.executeUpdate();

%>

<a href="index.jsp">Go back to home</a>
<br>
<!--<a href="artists.jsp">Go to artists</a>-->
