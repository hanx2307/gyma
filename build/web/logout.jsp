<%-- 
    Document   : logout
    Created on : May 30, 2017, 9:40:52 AM
    Author     : Jack
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            if(session !=null ){
                session.removeAttribute("username");
                response.sendRedirect("login.jsp");
            }
        %>
    </body>
</html>
