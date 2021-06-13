<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>

</head>
<body>
    <%
        Cookie ck[] = request.getCookies();
        for(Cookie c1 : ck) {
                if(c1.getName().equals("name")){
                        c1.setMaxAge(0);
                        response.addCookie(c1);
                        break;
                }
        }
        for(Cookie c2 : ck) {
                if(c2.getName().equals("n1")){
                        c2.setMaxAge(0);
                        response.addCookie(c2);
                        break;
                }
        }
        response.sendRedirect("index.html");
    %>
</body>
</html>