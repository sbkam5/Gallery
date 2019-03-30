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

  PreparedStatement pstmt = con.prepareStatement("select * from artist where birth_year>=? and birth_year<=?");
  pstmt.setInt(1, start);
  pstmt.setInt(2, end);
  rs = pstmt.executeQuery();
}
else{
  //If the user used the country to search for an artists
  //If the user used the location to search
  String country = request.getParameter("country");

  PreparedStatement pstmt = con.prepareStatement("select * from artist where country=?");
  pstmt.setString(1, country);
  rs = pstmt.executeQuery();
}

//Once result set is found, extract and display Info
while(rs.next()){
  out.println("Artist: " + rs.getString("name") + "<br>");
  out.println("Birth Year: " + rs.getInt("birth_year") + "<br>");
  out.println("Country: " + rs.getString("country") + "<br>");
  out.println("Description: " + rs.getString("description") + "<br>");
  out.println("<br><br>");
}

%>

<a href="index.jsp">Go back to Home</a>
