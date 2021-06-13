<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
    <%
        String name = request.getParameter("username");
        Cookie cookie = new Cookie("n1",name);
        response.addCookie(cookie);
        String psw = request.getParameter("password");
        String mail = request.getParameter("email");
        Class.forName("com.mysql.jdbc.Driver");
        String db_url=application.getInitParameter("db_url");
        String db_user=application.getInitParameter("db_user");
        String db_pass=application.getInitParameter("db_pass");
        Connection c=DriverManager.getConnection(db_url,db_user,db_pass);
        String query = "insert into user values(?,?,?)";
        PreparedStatement pst = c.prepareStatement(query);
        pst.setString(1,name);
        pst.setString(2,psw);
        pst.setString(3,mail);
        pst.executeUpdate();
        pst.close();
        c.close();

        out.println("You are registered successfully!!!");
        out.println("Enetr your account details below : ");
        out.println("<br><br>");
        out.println("<form action='accountmain.jsp' method='post'>");
        out.println("<input type='text' name='p1' placeholder='Account No.'><br><br>");
        out.println("<input type='text' name='p2' placeholder='Balance'><br><br>");
        out.println("Account Type : <br>");
        out.println("<input type='radio' name='acc_type' value='current'>");
        out.println("<label for='current'>CURRENT</label><br>");
        out.println("<input type='radio' name='acc_type' value='savings'>");
        out.println("<label for='current'>SAVINGS</label><br>");
        out.println("<input type='submit' value='submit'><br>");
        out.println("</form>");
    %>
</body>
</html>