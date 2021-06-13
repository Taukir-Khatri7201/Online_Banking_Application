<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login Validation</title>
</head>
<body>
<%
    String uname = request.getParameter("username");
    String psw = request.getParameter("password");
    Class.forName("com.mysql.jdbc.Driver");
    String db_url=application.getInitParameter("db_url");
    String db_user=application.getInitParameter("db_user");
    String db_pass=application.getInitParameter("db_pass");
    Connection c=DriverManager.getConnection(db_url,db_user,db_pass);
    Statement st = c.createStatement();
    ResultSet rs = st.executeQuery("select * from user");
    int f=0;
    while(rs.next()){
        if(rs.getString("uname").equals(uname)){
            out.println(rs.getString("uname"));
            if(rs.getString("password").equals(psw)){
                out.println("Successfully Logged in!!!");
                Cookie ck=new Cookie("name",uname);
                response.addCookie(ck);
                response.sendRedirect("user.html");
                f=1;
            }
        }
    }
    if(f==0){
        out.println("<script>alert('Please Register First!!!');</script>");
        response.sendRedirect("register.html");
    }
%>
</body>
</html>