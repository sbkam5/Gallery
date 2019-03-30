<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*"%>


<!--<b><?php echo $_GET['value']; ?></b>-->

<%
try {
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

String name = request.getParameter("name");
int artist_id = Integer.parseInt(request.getParameter("artist_id"));
int year = Integer.parseInt(request.getParameter("year"));
String country = request.getParameter("country");
String description = request.getParameter("description");
String title = request.getParameter("title");
String gallery = request.getParameter("gallery");

PreparedStatement pstmt = con.prepareStatement("update artist set name=?,birth_year=?,country=?,description=? where artist_id=?");
pstmt.setString(1, name);
pstmt.setInt(2, year);
pstmt.setString(3, country);
pstmt.setString(4, description);
pstmt.setInt(5, artist_id);
pstmt.executeUpdate();

%>

<form method="post" action = "artist.jsp">
Go Back to artist:
<input name="title" type="hidden" value="<%=title %>">
<input name="gallery" type="hidden" value="<%=gallery %>">
<input name="artist_id" type="submit" value="<%=artist_id %>"/>
</form>
