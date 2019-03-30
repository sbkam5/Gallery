<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*"%>


<!--<b><?php echo $_GET['value']; ?></b>-->

<%String title = request.getParameter("title");
String gallery = request.getParameter("gallery");

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
String sql = "select * from image where title=?";
PreparedStatement pstmt = con.prepareStatement(sql);
pstmt.setString(1, title);
ResultSet rs = pstmt.executeQuery();

//first get the image info
String link = "";
int image_id = 0;
int detail_id = 0;
int artist_id = 0;
while(rs.next()){
  image_id = rs.getInt("image_id");
  link = rs.getString("link");
  detail_id = rs.getInt("detail_id");
  artist_id = rs.getInt("artist_id");
}

//next get the artist info
pstmt = con.prepareStatement("select * from artist where artist_id=?");
pstmt.setInt(1, artist_id);
rs = pstmt.executeQuery();
String artist_name = "";
while(rs.next()){
  artist_name = rs.getString("name");
}

//lastly get detail info
pstmt = con.prepareStatement("select * from detail where detail_id=?");
pstmt.setInt(1, detail_id);
rs = pstmt.executeQuery();
String description = "";
String location ="";
String type="";
int year = 0;
while(rs.next()){
  description = rs.getString("description");
  location = rs.getString("location");
  year = rs.getInt("year");
  type= rs.getString("type");
}

%>

<img src= "<%=link %>">
<br>

<%
out.println("Title: " + title + "<br>");
out.println("Year: " + year + "<br>");
out.println("Location: " + location + "<br>");
out.println("Type: " + type + "<br>");
out.println("Description: " + description + "<br>");
out.println("Artist: " + artist_name + "<br>");
//out.println("<form method='post' action='index.jsp'>
  //<input type='submit' value='Submit'/>");

%>

<form method="post" action = "images.jsp">
Go Back to gallery:
<input name="gallery" type="submit" value="<%=gallery %>"/>
</form>

<br>

<form method="post" action = "artist.jsp">
View artist Info:
<input name="title" type="hidden" value="<%=title %>">
<input name="gallery" type="hidden" value="<%=gallery %>">
<input name="artist_id" type="submit" value="<%=artist_id %>"/>
</form>

<br>
<br>
<P>Modify Image</p>
<form method="post" action = "modify_image.jsp">
Title: <input name = "title" type = "text">
</br>
URL: <input name = "link" type="text">
</br>
Artist: <input name = "artist" type="text">
</br>
Location: <input name = "location" type="text">
</br>
Description: <input name = "description" type="text">
</br>
Year: <input name="year" type="text">
</br>
Type: <input name="type" type="text">
</br>
<input name="gallery" type="hidden" value="<%=gallery %>">
<input name="detail_id" type="hidden" value="<%=detail_id %>">
<input name="image_id" type="hidden" value="<%=image_id %>">
<input type="submit" value="Add"/>
</form>
