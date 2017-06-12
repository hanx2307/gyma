<%@page import="dao.UserDAO"%>
<%@page import="dao.UserDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="connect.DBConnect"%>
<%@page import="connect.DBConnect"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
        <title>GYMA System</title>
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
        <link rel="stylesheet" href="assets/scripts/sweetalert/sweetalert.css">
        <link rel="stylesheet" href="assets/scripts/datatable/css/dataTables.bootstrap.min.css">
        <link rel="stylesheet" href="assets/scripts/datatable/buttons/css/buttons.bootstrap.css">

        <!-- GOOGLE FONTS -->
        <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700" rel="stylesheet">
        <!-- ICONS -->
        <link rel="apple-touch-icon" sizes="76x76" href="assets/img/apple-icon.png">
        <link rel="icon" type="image/png" sizes="96x96" href="assets/img/favicon.png">
    </head>
    <body>
        <!-- NAVBAR -->
        <nav class="navbar navbar-default navbar-fixed-top">
            <div class="brand">
                <a href="index.html"><img src="assets/img/logo-dark.png" alt="Klorofil Logo" class="img-responsive logo"></a>
            </div>
            <div class="container-fluid">
                <div class="navbar-btn">
                    <button type="button" class="btn-toggle-fullwidth"><i class="lnr lnr-arrow-left-circle"></i></button>
                </div>
                <form class="navbar-form navbar-left">
                    <div class="input-group">
                        <input type="text" class="form-control iuserid" placeholder="Nhập mã thành viên...">
                        <span class="input-group-btn"><button type="button" class="btn btn-primary check-user">Kiểm tra</button></span>
                    </div>
                </form>
                <!--                <div class="navbar-btn navbar-btn-right">
                                    <a class="btn btn-primary update-pro" href="" title="Khóa màn hình" target="_blank"><i class="fa fa-lock"></i> <span>Khóa màn hình</span></a>
                                </div>-->
                <div id="navbar-menu">
                    <ul class="nav navbar-nav navbar-right">

                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="lnr lnr-user"></i><span> <%

                                if (session.getAttribute("username") != null) {
                                    out.print(session.getAttribute("username"));
                                }

                                    %></span> <i class="icon-submenu lnr lnr-chevron-down"></i></a>
                            <ul class="dropdown-menu">
                                <li><a href="#"><i class="lnr lnr-cog"></i> <span>Cài đặt</span></a></li>
                                <li><a href="logout.jsp"><i class="lnr lnr-exit"></i> <span>Đăng xuất</span></a></li>
                            </ul>
                        </li>

                    </ul>
                </div>
            </div>
        </nav>
        <!-- END NAVBAR -->
        <!-- LEFT SIDEBAR -->
        <div id="sidebar-nav" class="sidebar">
            <div class="sidebar-scroll">
                <nav>
                    <ul class="nav">
                        <li><a href="index.jsp" class=""><i class="lnr lnr-home"></i> <span>Trang chủ</span></a></li>
                        <li><a href="add-user.jsp" class=""><i class="lnr lnr-plus-circle"></i> <span>Đăng ký mới</span></a></li>
                        <li><a href="list-payment.jsp" class=""><i class="lnr lnr-cart"></i> <span>Thanh toán</span></a></li>

                        <li>
                            <a href="#subPages" data-toggle="collapse" class="collapsed"><i class="lnr lnr-user"></i> <span>Thành viên</span> <i class="icon-submenu lnr lnr-chevron-left"></i></a>
                            <div id="subPages" class="collapse ">
                                <ul class="nav">
                                    <li><a href="add-user.jsp" class="">Xác thực thành viên</a></li>
                                    <li><a href="list-user.jsp" class="">Quản lí thành viên</a></li>
                                </ul>
                            </div>
                        </li>
                        <li>
                            <a href="#subPages2" data-toggle="collapse" class="collapsed"><i class="lnr lnr-list"></i> <span>Gói tập</span> <i class="icon-submenu lnr lnr-chevron-left"></i></a>
                            <div id="subPages2" class="collapse ">
                                <ul class="nav">
                                    <li><a href="add-plan.jsp" class="">Thêm gói</a></li>
                                    <li><a href="list-plan.jsp" class="">Quản lí gói</a></li>
                                </ul>
                            </div>
                        </li>
                        <li>
                            <a href="#subPages3" data-toggle="collapse" class="collapsed"><i class="lnr lnr-calendar-full"></i> <span>Báo cáo</span> <i class="icon-submenu lnr lnr-chevron-left"></i></a>
                            <div id="subPages3" class="collapse ">
                                <ul class="nav">
                                    <li><a href="page-profile.html" class="">Báo cáo thành viên</a></li>
                                    <li><a href="page-login.html" class="">Báo cáo doanh thu</a></li>
                                </ul>
                            </div>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
        <!-- END LEFT SIDEBAR -->
    </body>
</html>