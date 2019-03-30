<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*"%>

<p>Galleries</p>
<br>

<%try {
Class.forName("com.mysql.jdbc.Driver").newInstance();
}
catch(Exception e) {
out.println("can't load mysql driver");
out.println(e.toString());
}

String url="jdbc:mysql://127.0.0.1:3306/gallery";
String id="gallery";
String pwd="eecs118";
Connection con = DriverManager.getConnection(url,id,pwd);

Statement stmt = con.createStatement();
String sql="SELECT * FROM gallery";
ResultSet rs = stmt.executeQuery(sql);

//display all of the galleries in the database
while (rs.next()) {
out.println("<tr>");
out.println("<td>"+rs.getString("gallery_id")+"</td>");
//out.println("<td><a href=\"images.jsp\"?value = hello>" + rs.getString("name") + "</a></td>");
out.println("<td>"+rs.getString("name")+"</td><br>");
out.println("<td>"+rs.getString("description")+"</td><br><br>");
out.println("</tr>");
}

%>

<form method="post" action = "delete_galleries.jsp">
Delete Gallery: <input name = "gallery" type = "text">
<input type="submit" value="Enter"/>
</form>

</br>
</br>

<form method="post" action = "index2.jsp">
Add Gallery: <input name = "gallery" type = "text">
Description: <input name = "gallery_description" type = "text">
<input type="submit" value="Enter"/>
</form>

</br>
</br>

<form method="post" action = "images.jsp">
View Gallery: <input name = "gallery" type = "text">
<input type="submit" value="View"/>
</form>



<a href="index.jsp"> Go back to home </a>
