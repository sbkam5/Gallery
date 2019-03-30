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

String search = request.getParameter("find");
String sub = search.substring(0,1);
ResultSet rs;

if(sub.equals("y")){
  //If the user used years to search
  int start = Integer.parseInt(request.getParameter("start"));
  int end = Integer.parseInt(request.getParameter("end"));

  PreparedStatement pstmt = con.prepareStatement("select * from detail where year>=? and year<=?");
  pstmt.setInt(1, start);
  pstmt.setInt(2, end);
  rs = pstmt.executeQuery();
}
else if(sub.equals("t")){
  //If the user used the type to search
  String type = request.getParameter("type");

  PreparedStatement pstmt = con.prepareStatement("select * from detail where type=?");
  pstmt.setString(1, type);
  rs = pstmt.executeQuery();
}
else if(sub.equals("a")){
  //If the user used the artist to search
  String artist = request.getParameter("artist");

  PreparedStatement pstmt = con.prepareStatement("select * from artist where name=?");
  pstmt.setString(1, artist);
  rs = pstmt.executeQuery();

  //find the id of the artist first
  int artist_id = 0;
  if(rs.next()){
  artist_id = rs.getInt("artist_id");
  }

  pstmt = con.prepareStatement("select * from image where artist_id=?");
  pstmt.setInt(1, artist_id);
  rs = pstmt.executeQuery();
}
else{
  //If the user used the location to search
  String location = request.getParameter("location");

  PreparedStatement pstmt = con.prepareStatement("select * from detail where location=?");
  pstmt.setString(1, location);
  rs = pstmt.executeQuery();
}

//once the desired details are found, print out the corresponding images and galleries.
while(rs.next()){
  int image_id = rs.getInt("image_id");
  String image = "";
  int gallery_id = 0;
  String gallery = "";

  PreparedStatement stmnt = con.prepareStatement("select * from image where image_id=?");
  stmnt.setInt(1, image_id);
  ResultSet result = stmnt.executeQuery();
  if(result.next()){
    image = result.getString("title");
    gallery_id = result.getInt("gallery_id");
  }

  stmnt = con.prepareStatement("select * from gallery where gallery_id=?");
  stmnt.setInt(1, gallery_id);
  result = stmnt.executeQuery();
  if(result.next()){
    gallery = result.getString("name");
  }

  out.println("Gallery: " + gallery + "<br>");
  out.println("Image: " + image + "<br><br><br>");

}


%>

<br>
<a href="index.jsp">Go back to Home</a>
