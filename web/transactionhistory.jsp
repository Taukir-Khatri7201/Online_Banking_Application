<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Transaction History</title>
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
            int f=0;
                Cookie ck[]=request.getCookies();
                String uname="";
                for(Cookie i:ck){
                    if(i.getName().equals("name")){
                        uname=i.getValue();
                        f=1;
                        break;
                    }
                }
                
                if(f==0){
                    response.sendRedirect("login.html");
                }
                
                else{
                    Class.forName("com.mysql.jdbc.Driver");
                    String db_url=application.getInitParameter("db_url");
                    String db_user=application.getInitParameter("db_user");
                    String db_pass=application.getInitParameter("db_pass");
                    Connection c=DriverManager.getConnection(db_url,db_user,db_pass);
                    String query = "select * from account";
                    Statement st=c.createStatement();
                    ResultSet rs=st.executeQuery(query);
                    
                    String accno="";
                    
                    while(rs.next()){
                        if(rs.getString("uname").equals(uname)){
                            accno=rs.getString("accno");
                            break;
                        }
                    }
                    
                    if(accno.equals("")){
                        response.sendRedirect("login.html");
                    }
                    else{
                        query="select * from transaction";
                        rs=st.executeQuery(query);
                        out.println("<table border=1>");
                        out.println("<tr>");
                        out.println("<th>Sender</th>");
                        out.println("<th>Receiver</th>");
                        out.println("<th>Amount</th>");
                        out.println("<th>Date & Time</th>");
                        out.println("</tr>");
                        while(rs.next()){
                            if(rs.getString("sender").equals(accno) || rs.getString("receiver").equals(accno)){
                                out.println("<tr>");
                                out.println("<td>"+rs.getString("sender")+"</td>");
                                out.println("<td>"+rs.getString("receiver")+"</td>");
                                out.println("<td>"+rs.getString("amount")+"</td>");
                                out.println("<td>"+rs.getString("date_time")+"</td>");
                                out.println("</tr>");
                            }
                        }
                        out.println("</table>");
                        out.println("<br><a href='transfermoney.jsp'>New Transaction</a> <pre>  </pre> <a href='user.html'>Home</a>");
                    }
                }
        %>
    </body>
</html>
