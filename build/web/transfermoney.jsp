<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
    <title>Transfer Money</title>
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
        <form action="validate_transaction.jsp" method='post'>
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
//                out.println("Username: "+uname);
//                out.println("Flag: "+f);
                if(f==0){
                    response.sendRedirect("login.html");
                }
                out.println("<input type='hidden' name='sender' value='"+uname+"'>");
            %>
            Recipient's Account Number: <input type="text" name="reciver" placeholder="Enter Recipient's Account Number" required><br>
            Amount: <input type="number" name="amount" placeholder="Enter Amount Here" required><br>
            <input type="submit" value="Send Money">
        </form>
    </body>
</html>
