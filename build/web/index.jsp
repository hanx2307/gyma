<%-- 
    Document   : index
    Created on : May 30, 2017, 7:17:44 AM
    Author     : Jack
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
    }
%>
<!-- WRAPPER -->
<div id="wrapper">
    <%@include file="page/header.jsp" %>
    <%@include file="page/dashboard.jsp" %>
    <%@include file="page/footer.jsp" %>
</div>
<!-- END WRAPPER -->
