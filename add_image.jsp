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

//First get the parameters sent over
String val = request.getParameter("id");
String gallery_title = request.getParameter("gallery_title");
String sub = val.substring(0,3);

//if user clicked on the add option, we will add an image
if(sub.equals("Add")){
String title = request.getParameter("title");
String link = request.getParameter("link");
String artist = request.getParameter("artist");
String description = request.getParameter("description");
String location = request.getParameter("location");
int year = Integer.parseInt(request.getParameter("year"));
String type = request.getParameter("type");
int gallery_id = Integer.parseInt(request.getParameter("gallery"));

//check to see if artist is already in database
PreparedStatement pstmt = con.prepareStatement("select * from artist where name=?");
pstmt.setString(1,artist);
ResultSet rs =pstmt.executeQuery();
int artist_id = -10;
if(rs.next()){
  artist_id = rs.getInt("artist_id");
}

//if artist_id is less than 0, then we know the artist isnt there yet, so we add him in.
if(artist_id<0){
  pstmt = con.prepareStatement("insert into artist values(default,?,default,default,default)");
  pstmt.setString(1,artist);
  pstmt.executeUpdate();

  pstmt = con.prepareStatement("select * from artist where name=?");
  pstmt.setString(1,artist);
  rs =pstmt.executeQuery();
  if(rs.next()){
    artist_id = rs.getInt("artist_id");
  }
}
else{
  
}

//Now we need to add in the image's details
pstmt = con.prepareStatement("insert into detail values(default,default,?,?,default,default,?,?)");
pstmt.setInt(1, year);
pstmt.setString(2, type);
pstmt.setString(3, location);
pstmt.setString(4, description);
pstmt.executeUpdate();
//once detail is inserted, re-search through database to get its id.
pstmt = con.prepareStatement("select * from detail where description=?");
pstmt.setString(1, description);
rs = pstmt.executeQuery();
int detail_id = 0;
while(rs.next()){
  detail_id = rs.getInt("detail_id");
}


//first update the title and url into database
pstmt = con.prepareStatement("insert into image values(default,?,?,?,?,?)",Statement.RETURN_GENERATED_KEYS);
pstmt.clearParameters();
pstmt.setString(1, title);
pstmt.setString(2, link);
pstmt.setInt(3, gallery_id);
pstmt.setInt(4, artist_id);
pstmt.setInt(5, detail_id);
pstmt.executeUpdate();
//once image is inserted, go through database again to find its id
pstmt = con.prepareStatement("select * from image where title=?");
pstmt.setString(1, title);
rs = pstmt.executeQuery();
int image_id = 0;
while(rs.next()){
  image_id = rs.getInt("image_id");
}


//update detail so it has the image id
pstmt = con.prepareStatement("update detail set image_id=? where description=?");
pstmt.setInt(1, image_id);
pstmt.setString(2, description);
pstmt.executeUpdate();
}
else{
  //If user selected the delete opption.  First we need to find id of the image
  String title = request.getParameter("title");
  PreparedStatement pstmt = con.prepareStatement("select * from image where title=?");
  pstmt.setString(1, title);
  ResultSet rs = pstmt.executeQuery();
  int image_id = 0;
  if(rs.next()){
    image_id = rs.getInt("image_id");
  }

  //Next delete the image and its details
  pstmt = con.prepareStatement("delete from image where image_id=?");
  pstmt.setInt(1, image_id);
  pstmt.executeUpdate();

  pstmt = con.prepareStatement("delete from detail where image_id=?");
  pstmt.setInt(1, image_id);
  pstmt.executeUpdate();
}
%>

<form method="post" action = "images.jsp">
Go Back to gallery:
<input name="gallery" type="submit" value="<%=gallery_title %>"/>
</form>
