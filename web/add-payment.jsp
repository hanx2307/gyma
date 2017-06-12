<%-- 
    Document   : add-plan
    Created on : Jun 8, 2017, 1:53:50 PM
    Author     : Jack
--%>

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
        <meta charset="utf-8">
        <title>Thêm gói</title>
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
        <!-- GOOGLE FONTS -->
        <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700" rel="stylesheet">
        <!-- ICONS -->
        <link rel="apple-touch-icon" sizes="76x76" href="assets/img/apple-icon.png">
        <link rel="icon" type="image/png" sizes="96x96" href="assets/img/favicon.png">
    </head>
    <body>

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
                                <div class="panel">
                                    <div class="panel-heading">
                                        <h3 class="panel-title">Thêm gói</h3>
                                    </div>
                                    <div class="panel-body">
                                        <form action="PlaymentServlet" method="post" class="form-horizontal">
                                            <%  
                                                Connection conn = DBConnect.getConnection();
                                                String sql1 = "SELECT id, name, avatar FROM user WHERE id = "+request.getParameter("id")+"";

                                                PreparedStatement ps1 = conn.prepareCall(sql1);
                                                ResultSet rs1 = ps1.executeQuery();

                                                while (rs1.next()) {
                                            %>
                                            <input type="hidden" name="action" value="insert">                                            
                                            <div class="col-md-6">
                                                <div class="form-group">
                                                    <label for="name" class="col-sm-3 control-label">Mã thành viên</label>
                                                    <div class="col-sm-9">
                                                        <input type="text" class="form-control" name="userID" id="userid" disabled value="<%=rs1.getLong("id")%>">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label for="name" class="col-sm-3 control-label">Họ tên</label>
                                                    <div class="col-sm-9">
                                                        <input type="text" class="form-control" name="username" id="username" value="<%=rs1.getString("name")%>"></input>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label for="name" class="col-sm-3 control-label">Ảnh đại diện</label>
                                                    <div class="col-sm-9">
                                                        <img src="<%=rs1.getString("avatar")%>" width="180" class="" alt="Avatar">
                                                    </div>
                                                </div>
                                                <% } %>
                                                <div class="form-group">
                                                    <label for="name" class="col-sm-3 control-label">Ngày thanh toán</label>
                                                    <div class="col-sm-9">
                                                        <input type="text" class="form-control datepick" name="userDateJoin" id="disabledInput" disabled value="<%                                                            Date date = new Date();
                                                            SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
                                                            out.print(ft.format(date));
                                                               %>">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label for="name" class="col-sm-3 control-label">Chọn gói</label>
                                                    <div class="col-sm-9">
                                                        <select class="form-control plain" name="subsciptionPlan">
                                                            <option value="">-- Chọn gói --</option>
                                                            <%
                                                                
                                                                String sql = "SELECT * FROM plan";

                                                                PreparedStatement ps = conn.prepareCall(sql);
                                                                ResultSet rs = ps.executeQuery();

                                                                while (rs.next()) {
                                                            %>
                                                            <option value="<%=rs.getString("id")%>"><%=rs.getString("plan_name")%></option>
                                                            <% }%>
                                                        </select>
                                                    </div>
                                                </div>
                                                <div class="totalcost">
                                                    <div class="form-group">
                                                        <label for="name" class="col-sm-3 control-label">Tổng tiền <span class="text-danger">*</span></label>
                                                        <div class="col-sm-9">
                                                            <div class="input-group">
                                                                <input class="form-control totalMoney" name="subsciptionTotal" type="text" required>
                                                                <span class="input-group-addon">VNĐ</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="name" class="col-sm-3 control-label">Đã thanh toán <span class="text-danger">*</span></label>
                                                        <div class="col-sm-9">
                                                            <div class="input-group">
                                                                <input class="form-control totalpaidMoney" name="subsciptionPaid" type="text" required>
                                                                <span class="input-group-addon">VNĐ</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label for="name" class="col-sm-3 control-label"></label>
                                                    <div class="col-sm-9">
                                                        <button type="submit" class="btn btn-primary btn-block"><i class="fa fa-paper-plane-o"></i> Xác nhận</button>
                                                    </div>
                                                </div>

                                                <%if (request.getAttribute("sussess") != null) {
                                                %>
                                                <div class="form-group">
                                                    <label for="name" class="col-sm-2 control-label"></label>
                                                    <div class="col-sm-10">

                                                        <div class="alert alert-success alert-dismissible" role="alert">
                                                            <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">×</span></button>
                                                            <i class="fa fa-check-circle"></i> <%=request.getAttribute("sussess")%>.
                                                        </div>
                                                        <a href="list-plan.jsp"><i class="fa fa-undo" aria-hidden="true"></i> Trở về trang danh sách</a>
                                                    </div>
                                                </div>

                                                <% }%>
                                            </div>
                                        </form>
                                    </div>
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