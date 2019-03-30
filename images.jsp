<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*"%>


<%String title = request.getParameter("gallery");

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

//create the sql to find gallery id
PreparedStatement pstmt = con.prepareStatement("select * from gallery where name=?");
pstmt.setString(1, title);
ResultSet rs = pstmt.executeQuery();

int gallery_id = 0;
while(rs.next()){
  gallery_id = rs.getInt("gallery_id");
}
String gallery = Integer.toString(gallery_id);

//create sql command to find all images with corresponding gallery id
pstmt = con.prepareStatement("select * from image where gallery_id=?");
pstmt.setInt(1, gallery_id);
rs = pstmt.executeQuery();
int image_num = 0;

while(rs.next()){
  out.println("<tr>");
  //out.println("<td><a href=\"image.jsp\"?value = hello>" + rs.getString("name") + "</a></td>");
  //out.println("<td>"+rs.getString("link")+"</td>");
  out.println("<td>"+rs.getString("title")+"</td>");
  out.println("<br>");
  out.println("<td>"+rs.getString("link")+"</td>");
  out.println("<br>");
  out.println("<br>");
  out.println("</tr>");
  image_num++;
}


%>
<!--if user wants to add an image to this gallery-->

</br>
<p>Total Number of images: <%=image_num %></p>
</br>


</br>
<p>Add Image</p>
</br>

<form method="post" action = "add_image.jsp">
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
<input name="gallery_title" type="hidden" value="<%=title %>">
<input name = "id" type="submit" value="Add"/>
</form>


<!--If user wants to delete an image from the gallery-->
</br>
<form method="post" action = "add_image.jsp">
Delete Image: <input name = "title" type = "text">
<input name="gallery_title" type="hidden" value="<%=title %>">
<input name = "id" type="submit" value="Delete"/>
</form>

<!--if user wants to view a specific image in gallery-->
</br>
<form method="post" action = "image.jsp">
View Image: <input name = "title" type = "text">
<input name="gallery" type="hidden" value="<%=title %>">
<input type="submit" value="View"/>
</form>

</br>
<p>Modify Gallery</p>
<form method="post" action = "modify_gallery.jsp">
Title: <input name = "title" type = "text">
Description: <input name="description" type = "text">
<input name="gallery_id" type="hidden" value="<%=gallery_id %>">
<input type="submit" value="Submit"/>
</form>

<a href="galleries.jsp"> Go back to galleries </a>
