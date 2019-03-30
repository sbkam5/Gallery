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

String title = request.getParameter("title");
String link = request.getParameter("link");
String artist = request.getParameter("artist");
String description = request.getParameter("description");
String location = request.getParameter("location");
int year = Integer.parseInt(request.getParameter("year"));
String type = request.getParameter("type");
String gallery = request.getParameter("gallery");
int detail_id = Integer.parseInt(request.getParameter("detail_id"));
int image_id = Integer.parseInt(request.getParameter("image_id"));

//first update the title and link to the image
PreparedStatement pstmt = con.prepareStatement("update image set title=?, link=? where image_id=?");
pstmt.setString(1, title);
pstmt.setString(2, link);
pstmt.setInt(3, image_id);
pstmt.executeUpdate();

//next check to see if the artist given already exists.  If they do, get his id and update it into image
pstmt = con.prepareStatement("select * from artist where name=?");
pstmt.setString(1, artist);
ResultSet rs = pstmt.executeQuery();
int artist_id = 0;
if(rs.next()){
  artist_id = rs.getInt("artist_id");
  pstmt = con.prepareStatement("update image set artist_id=? where image_id=?");
  pstmt.setInt(1, artist_id);
  pstmt.setInt(2, image_id);
  pstmt.executeUpdate();
}
else{
  //if artist doesn't exist yet, insert them
  pstmt = con.prepareStatement("insert into artist values(default,?,default,default,default)");
  pstmt.setString(1,artist);
  pstmt.executeUpdate();

  pstmt = con.prepareStatement("select * from artist where name=?");
  pstmt.setString(1, artist);
  rs = pstmt.executeQuery();
  if(rs.next()){
    artist_id = rs.getInt("artist_id");
  }

  pstmt = con.prepareStatement("update image set artist_id=? where image_id=?");
  pstmt.setInt(1, artist_id);
  pstmt.setInt(2, image_id);
  pstmt.executeUpdate();
}

//lastly update the actual details of the images
pstmt = con.prepareStatement("update detail set year=?, type=?, location=?, description=? where detail_id=?");
pstmt.setInt(1, year);
pstmt.setString(2, type);
pstmt.setString(3, location);
pstmt.setString(4, description);
pstmt.setInt(5, detail_id);
pstmt.executeUpdate();


%>

<form method="post" action = "image.jsp">
Go back to image:
<input name="gallery" type="hidden" value="<%=gallery %>">
<input name="title" type="submit" value="<%=title %>"/>
</form>
