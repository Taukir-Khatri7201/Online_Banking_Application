<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
    <%
        String name = request.getParameter("t1");
        String mail = request.getParameter("t2");
        String msg = request.getParameter("t3");
        Class.forName("com.mysql.jdbc.Driver");
        String db_url=application.getInitParameter("db_url");
        String db_user=application.getInitParameter("db_user");
        String db_pass=application.getInitParameter("db_pass");
        Connection c=DriverManager.getConnection(db_url,db_user,db_pass);
        String query = "insert into contact values(?,?,?)";
        PreparedStatement pst = c.prepareStatement(query);
        pst.setString(1,name);
        pst.setString(2,mail);
        pst.setString(3,msg);
        pst.executeUpdate();
        pst.close();
        c.close();
        Cookie ck[] = request.getCookies();
        for(Cookie c1 : ck) {
                if(c1.getName().equals("name")){
                        if(c1.getMaxAge()==0){
                                response.sendRedirect("index.html");
                        }
                        else{
                                response.sendRedirect("user.html");
                        }
                }
        }
    %>
</body>
</html>