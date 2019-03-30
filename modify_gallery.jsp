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

String title = request.getParameter("title");
String description = request.getParameter("description");
int gallery_id = Integer.parseInt(request.getParameter("gallery_id"));

PreparedStatement pstmt = con.prepareStatement("update gallery set name=?,description=? where gallery_id=?");
pstmt.setString(1, title);
pstmt.setString(2, description);
pstmt.setInt(3, gallery_id);
pstmt.executeUpdate();
%>

<form method="post" action = "images.jsp">
Go back to gallery:
<input name="gallery" type="hidden" value="<%=title %>">
<input type="submit" value="<%=title %>"/>
</form>
