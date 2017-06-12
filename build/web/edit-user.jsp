<%-- 
    Document   : add-user
    Created on : May 31, 2017, 1:23:22 AM
    Author     : Jack
--%>

<%@page import="models.User"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="connect.DBConnect"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import = "java.io.*,java.util.*, javax.servlet.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sửa thành viên</title>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0">
        <!-- VENDOR CSS -->
        <link rel="stylesheet" href="assets/vendor/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="assets/vendor/font-awesome/css/font-awesome.min.css">
        <link rel="stylesheet" href="assets/vendor/linearicons/style.css">
        <link rel="stylesheet" href="assets/vendor/chartist/css/chartist-custom.css">
        <!-- MAIN CSS -->
        <link rel="stylesheet" href="assets/css/main.css">
        <!-- FOR DEMO PURPOSES ONLY. You should remove this in your project -->
        <link rel="stylesheet" href="assets/css/demo.css">
        <link rel="stylesheet" href="assets/scripts/datepicker/css/datepicker.css">
        <!-- GOOGLE FONTS -->
        <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700" rel="stylesheet">
        <!-- ICONS -->
        <link rel="apple-touch-icon" sizes="76x76" href="assets/img/apple-icon.png">
        <link rel="icon" type="image/png" sizes="96x96" href="assets/img/favicon.png">
    </head>
    <body>
        <%
            if (session.getAttribute("username") == null) {
                response.sendRedirect("login.jsp");
            }
        %>
        <!-- WRAPPER -->
        <div id="wrapper">
            <%@include file="page/header.jsp" %>
            <!-- MAIN -->
            <div class="main">
                <!-- MAIN CONTENT -->
                <div class="main-content">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-md-12">
                                <!-- BUTTONS -->
                                <div class="panel">
                                    <div class="panel-heading">
                                        <h3 class="panel-title">Sửa thành viên</h3>
                                    </div>  
                                    <div class="panel-body">
                                        <form action="UpdateUserServlet" method="post" class="form-horizontal">
                                            <input type="hidden" name="action" value="edit">                                           
                                            <div class="col-md-9">
                                                <%
                                                    Long userID = Long.parseLong(request.getParameter("id"));
                                                    UserDAO userDAO = new UserDAO();
                                                    User user = userDAO.getListPlanFromID(userID);
                                                %>
                                                <input type="hidden" name="userAvatar" class="userAvatar" value="<%=user.getUserAvatar()%>">
                                                <input type="hidden" name="userID" class="userID" value="<%=user.getUserID()%>">
                                                <input type="hidden" name="userDateJoin" value="<%=user.getUserDateJoin()%>">
                                                <div class="form-group">
                                                    <label for="name" class="col-sm-2 control-label">Họ tên</label>
                                                    <div class="col-sm-10">
                                                        <input type="text" class="form-control" name="userName" id="username" value="<%=user.getUserName()%>">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label for="name" class="col-sm-2 control-label">Email</label>
                                                    <div class="col-sm-10">
                                                        <input type="email" class="form-control" name="userEmail" id="useremail" value="<%=user.getUserEmail()%>">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label for="name" class="col-sm-2 control-label">Địa chỉ</label>
                                                    <div class="col-sm-10">
                                                        <input type="text" class="form-control" name="userAddress" id="useraddress" value="<%=user.getUserAddress()%>">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label for="name" class="col-sm-2 control-label">Số điện thoại</label>
                                                    <div class="col-sm-10">
                                                        <input type="number" maxlength="11" class="form-control" name="userPhone" id="userphone" value="<%=user.getUserPhone()%>">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label for="name" class="col-sm-2 control-label">Năm sinh</label>
                                                    <div class="col-sm-10">
                                                        <input type="number" maxlength="4" class="form-control" name="userAge" id="userAge" value="<%=user.getUserAge()%>">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label for="name" class="col-sm-2 control-label">Giới tính</label>
                                                    <div class="col-sm-10">
                                                        <label class="fancy-radio">
                                                            <input name="userSex" value="1" <% if(user.getUserSex() == 1) { out.print("checked"); } %> type="radio">
                                                            <span><i></i>Nam</span>
                                                        </label>
                                                        <label class="fancy-radio">
                                                            <input name="userSex" value="0" <% if(user.getUserSex() == 0) { out.print("checked"); } %> type="radio">
                                                            <span><i></i>Nữ</span>
                                                        </label>
                                                    </div>
                                                </div>

                                                <div class="form-group">
                                                    <label for="name" class="col-sm-2 control-label">Chứng thực</label>
                                                    <div class="col-sm-10">
                                                        <select class="form-control" name="userProof" id="userproof">
                                                            <option value="Chứng minh thư" <% if(user.getUserProof() == "Chứng minh thư") { out.print("selected"); } %>>Chứng minh thư</option>
                                                            <option value="Thẻ hội viên" <% if(user.getUserProof() == "Thẻ hội viên") { out.print("selected"); } %>>Thẻ hội viên</option>
                                                        </select>

                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label for="name" class="col-sm-2 control-label"></label>
                                                    <div class="col-sm-10">
                                                        <button type="submit" class="btn btn-primary btn-block"><i class="fa fa-paper-plane-o"></i> Xác nhận</button>
                                                    </div>
                                                </div>
                                                <%if (request.getAttribute("success") != null) {
                                                %>
                                                <div class="form-group">
                                                    <label for="name" class="col-sm-2 control-label"></label>
                                                    <div class="col-sm-10">
                                                        <div class="alert alert-success fade in" role="alert">
                                                            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span></button>
                                                            <i class="fa fa-check-circle"></i> <%=request.getAttribute("success")%>.
                                                        </div>
                                                        <a href="list-user.jsp"><i class="fa fa-undo" aria-hidden="true"></i> Trở về trang danh sách</a>
                                                    </div>
                                                </div>

                                                <% }%>
                                            </div>
                                        </form> 
                                    </div>
                                </div>
                                <!-- END INPUT SIZING -->
                            </div>
                        </div>
                        <!-- END INPUT SIZING -->
                    </div>
                </div>
            </div>
        </div>
        <!-- END MAIN CONTENT -->
    </div>
    <!-- END MAIN -->
    <%@include file="page/footer.jsp" %>
</div>
<!-- END WRAPPER -->
</body>
</html>
