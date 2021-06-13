<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

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
            int f=0;
            String uname="";
            Cookie ck[]=request.getCookies();
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
                String sender=request.getParameter("sender");
                String reciver=request.getParameter("reciver");
                int amount=Integer.parseInt(request.getParameter("amount"));
                SimpleDateFormat formatter = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");  
                Date d = new Date();  
                String date=(String)formatter.format(d);
                
                if(sender.equals(reciver)){
                    out.println("Invalid Reciver's Account Number...");
                    out.println("<form action='transfermoney.jsp' method='post'>");
                    out.println("<input type='submit' value='Back'>");
                    out.println("</form>");
                }
                
                if(amount<=0){
                    out.println("Please Enter Valid Amount...");
                    out.println("<form action='transfermoney.jsp' method='post'>");
                    out.println("<input type='submit' value='Back'>");
                    out.println("</form>");
                }
                else{
                    f=0;
                    
                    Class.forName("com.mysql.jdbc.Driver");
                    String db_url=application.getInitParameter("db_url");
                    String db_user=application.getInitParameter("db_user");
                    String db_pass=application.getInitParameter("db_pass");
                    Connection c=DriverManager.getConnection(db_url,db_user,db_pass);
                    String query = "select * from account";
                    Statement st=c.createStatement();
                    ResultSet rs=st.executeQuery(query);
                    int sender_balance=0;
                    int reciver_balance=0;
                    
                    while(rs.next()){
                        if(rs.getString("accno").equals(reciver)){
//                            reciver=rs.getString("uname");
                            reciver_balance=rs.getInt("balance");
                            f+=1;
                        }
                        else if(rs.getString("uname").equals(sender)){
                            if(rs.getInt("balance")<amount || (rs.getInt("balance")-amount)<100){
                                out.println("Insufficient Balance Add Some balance and then try again...");
                                out.println("<form action='transfermoney.jsp' method='post'>");
                                out.println("<input type='submit' value='Back'>");
                                out.println("</form>");
                                f=0;
                                break;
                            }
                            else{
                                sender=rs.getString("accno");
                                sender_balance=rs.getInt("balance");
                                f+=1;
                            }
                        }
                        if(f==2){
                            break;
                        }
                    }
                    if(f==2){
                        query = "insert into transaction values(?,?,?,?)";
                        PreparedStatement pst = c.prepareStatement(query);
                        pst.setString(1,sender);
                        pst.setString(2,reciver);
                        pst.setInt(3, amount);
                        pst.setString(4,date);
                        pst.executeUpdate();
                        pst.close();
                        
                        int updated_balance_sender =sender_balance-amount;
                        int updated_balance_reciver=reciver_balance+amount;
                        
                        out.println("Updated Balance Sender: "+updated_balance_sender);
                        
                        query="update account set balance="+updated_balance_sender+" where accno='"+sender+"'";
                        st.executeUpdate(query);
                        
                        query="update account set balance="+updated_balance_reciver+" where accno='"+reciver+"'";
                        st.executeUpdate(query);
                        
                        out.println("<h3>Transaction has been made... Thank you for using our services!</h3>");
                        out.println("<h5>Your New Balance is: "+updated_balance_sender+"</h5>");
                        out.println("<br><a href='transfermoney.jsp'>Do Another Transaction</a> <pre>  </pre> <a href='user.html'>Home</a>");
                    }
                    else if(f==1){
                        out.println("Invalid Reciver's Account Number...");
                        out.println("<form action='transfermoney.jsp' method='post'>");
                        out.println("<input type='submit' value='Back'>");
                        out.println("</form>");
                    }
                    c.close();
                }
            }
        %>
    </body>
</html>
