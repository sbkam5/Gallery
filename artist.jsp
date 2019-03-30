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

//create the sql command
int artist_id = Integer.parseInt(request.getParameter("artist_id"));
String title = request.getParameter("title");
String gallery = request.getParameter("gallery");
PreparedStatement pstmt = con.prepareStatement("select * from artist where artist_id=?");
pstmt.setInt(1, artist_id);
ResultSet rs = pstmt.executeQuery();

//first get the image info
String name="";
int year = 0;
String country = "";
String description = "";
while(rs.next()){
  name = rs.getString("name");
  year = rs.getInt("birth_year");
  country = rs.getString("country");
  description = rs.getString("description");
}

out.println("Artist: " + name + "<br>");
out.println("Birth year: " + year + "<br>");
out.println("Country: " + country + "<br>");
out.println("Description: " + description + "<br>");

%>


<form method="post" action = "image.jsp">
Go back to image:
<input name="title" type="hidden" value="<%=title %>">
<input name="gallery" type="hidden" value="<%=gallery %>">
<input type="submit" value="Go"/>
</form>

<p>Modify Artist</p>
<form method="post" action="modify_artist.jsp">
Artist: <input name="name" type="text">
<br>
Year: <input name="year" type="text">
<br>
Country: <input name="country" type="text">
<br>
Description: <input name="description" type="text">
<br>
<input name="artist_id" type="hidden" value="<%=artist_id %>">
<input name="title" type="hidden" value="<%=title %>">
<input name="gallery" type="hidden" value="<%=gallery %>">
<input type="submit" value="Submit"/>
</form>
