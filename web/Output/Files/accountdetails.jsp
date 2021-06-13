<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Account Page</title>
    <style type="text/css">
    * {
        padding : 0;
        margin : 0;
        box-sizing : border-box;
    }
    body {
        background-image:url(background.jpg);
        background-size:cover;
        background-position:center;
        box-sizing : border-box;
        font-family : sans-serif;
    }
    .menu-bar {
        background : rgb(0,100,0);
        text-align : center;
    }
    .menu-bar ul {
        display : inline-flex;
        list-style : none;
        color : #fff;
    }
    .menu-bar ul li {
        width : 120px;
        margin : 15px;
        padding : 15px;
    }
    .menu-bar ul li a {
        text-decoration : none;
        color : #fff;
    }
    .menu-bar ul li:hover {
            background : #ab2d0c;
            border-radius : 3px;
    }
    .welcome{
        border : 0;
        padding : 0;
        color : #000000;
        margin : 70px 40px 200px 800px;
        text-align : center;
    }
    .intro{
        border : 0;
        padding : 0;
        color : #000000;
        margin-top : 0;
        margin-right : 40px;
        margin-bottom : 200px;
        margin-left : 900px;
        text-align : left;
        font-size : 50px;
    }
    </style>
</head>
<body>
    <div class="menu-bar">
        <ul>
            <li><a href="user.html">Home</a></li>
            <li><a href="profile.jsp">Profile</a></li>
            <li><a href="accountdetails.jsp">Account Details</a></li>
            <li><a href="transfermoney.jsp">Transfer Money</a></li>
            <li><a href="transactionhistory.jsp">Transaction History</a></li>
            <li><a href="contact.html">Contact Us</a></li>
            <li><a href="logout.jsp">Logout</a></li>
        </ul>
    </div>
    <%
        String uname = "";
        Cookie ck[] = request.getCookies();
        for(Cookie c1 : ck) {
                if(c1.getName().equals("name"))
                        uname = c1.getValue();
        }
        Class.forName("com.mysql.jdbc.Driver");
        String db_url=application.getInitParameter("db_url");
        String db_user=application.getInitParameter("db_user");
        String db_pass=application.getInitParameter("db_pass");
        Connection c=DriverManager.getConnection(db_url,db_user,db_pass);
        Statement st = c.createStatement();
        ResultSet rs = st.executeQuery("select * from account where uname='"+uname+"'");
        if(rs.next()){
            out.println("<table BORDER=1 CELLPADDING=2px CELLSPACING=2px WIDTH=30>");
            out.println("<tr>");
            out.println("<td> Username </td>");
            out.println("<td>"+rs.getString("uname")+"</td>");
            out.println("</tr>");
            out.println("<tr>");
            out.println("<td> Account Number </td>");
            out.println("<td>"+rs.getString("accno")+"</td>");
            out.println("</tr>");
            out.println("<tr>");
            out.println("<td> Account Balance </td>");
            out.println("<td>"+rs.getInt("balance")+"</td>");
            out.println("</tr>");
            out.println("<tr>");
            out.println("<td> Account Type </td>");
            out.println("<td>"+rs.getString("acctype")+"</td>");
            out.println("</tr>");
            out.println("</table>");
            out.println("<form action='user.html' method='post'>");
            out.println("<input type='submit' value='Back'>");
            out.println("</form>");
        }
    %>
</body>
</html>