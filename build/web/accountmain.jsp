<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>

</head>
<body>
    <%
        String uname = "";
        Cookie ck[] = request.getCookies();
        
        for(Cookie c1 : ck) {
                if(c1.getName().equals("n1"))
                        uname = c1.getValue();
        }
        
        String accno = request.getParameter("p1");
        String acctype = request.getParameter("acc_type");
        int balance = Integer.parseInt(request.getParameter("p2"));
        Class.forName("com.mysql.jdbc.Driver");
        String db_url=application.getInitParameter("db_url");
        String db_user=application.getInitParameter("db_user");
        String db_pass=application.getInitParameter("db_pass");
        Connection c=DriverManager.getConnection(db_url,db_user,db_pass);
        String query = "insert into account values(?,?,?,?)";
        PreparedStatement pst = c.prepareStatement(query);
        pst.setString(1,uname);
        pst.setString(2,accno);
        pst.setInt(3,balance);
        pst.setString(4,acctype);
        pst.executeUpdate();
        pst.close();
        c.close();
        out.println("Your details has been saved successfully !!!");
        out.println("<a href='login.html'>Click Here</a> for login");
    %>
</body>
</html>