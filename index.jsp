<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*"%>
<% //String funcID = request.getParameter(“funcID”);
 //String name = request.getParameter(“name”);
 %>

<p> HOME PAGE </p>
<br>
<br>

<p>Add a gallery</p>
 <form method="post" action="index2.jsp">
 <input name="funcID" type="hidden" value="2">
Gallery: <input name="gallery" type="text">
<br>
Gallery Description: <input name="gallery_description" type="text">
<br>
 <input type="submit" value="Add"/>
</form>
<br>

<p>Add an Artist</p>
<form method="post" action="add_artist.jsp">
Artist: <input name="name" type="text">
<br>
Year: <input name="year" type="text">
<br>
Country: <input name="country" type="text">
<br>
Description: <input name="description" type="text">
<br>
<input type="submit" value="Add"/>
</form>
<br>
<br>

<!--Give users option to search images by year-->
<form method="post" action="find_image.jsp">
Find Image By Year:
<br>
Start: <input name="start" type="text">
End: <input name="end" type="text">
<input name="find" type="hidden" value="year">
<input type="submit" value="Search"/>
</form>
  <!--Give user option to find by type-->
<form method="post" action="find_image.jsp">
Find Image by Type:<input name="type" type="text">
<input name="find" type="hidden" value="type">
<input type="submit" value="Search"/>
</form>
<br>
  <!--Give user option to find by artist-->
<form method="post" action="find_image.jsp">
Find Image by Artist:<input name="artist" type="text">
<input name="find" type="hidden" value="artist">
<input type="submit" value="Search"/>
</form>
<br>
  <!--Give user option to find by Location-->
<form method="post" action="find_image.jsp">
Find Image by Location:<input name="location" type="text">
<input name="find" type="hidden" value="location">
<input type="submit" value="Search"/>
</form>
<br>
<br>
<br>


<!--Give user option to find by Birth year-->
<form method="post" action="find_artist.jsp">
Find Artist by Birth Year:
<br>
Start:<input name="start" type="text"> End:<input name="end" type="text">
<input name="find" type="hidden" value="year">
<input type="submit" value="Search"/>
</form>
<br>
<!--Give user option to find artists by Location-->
<form method="post" action="find_artist.jsp">
Find Artist by Country:<input name="country" type="text">
<input name="find" type="hidden" value="country">
<input type="submit" value="Search"/>
</form>
<br>

<br>
<a href="galleries.jsp"> Go to Galleries </a>
