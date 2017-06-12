<%-- 
    Document   : user-manager
    Created on : May 30, 2017, 9:19:37 PM
    Author     : Jack
--%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.ArrayList"%>
<%@page import="models.User"%>
<%@page import="dao.UserDAO"%>
<%@ page import="java.io.*,java.util.*, javax.servlet.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lí thành viên</title>
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
                                <!-- TABLE STRIPED -->
                                <div class="panel">
                                    <div class="panel-heading">
                                        <h3 class="panel-title">Danh sách thành viên</h3>
                                    </div>
                                    <div class="panel-body">
                                        <table class="table table-striped" id="my-table">
                                            <thead>
                                                <tr>
                                                    <th>#</th>
                                                    <th>Tên</th>
                                                    <th>Ảnh</th>
                                                    <th>Địa chỉ</th>
                                                    <th>Email</th>
                                                    <th>Số điện thoại</th>
                                                    <th>Giới tính</th>
                                                    <th>Năm sinh</th>
                                                    <th>Ngày tham gia</th>
                                                    <th>Thao tác</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%                                                    UserDAO userDAO = new UserDAO();
                                                    ArrayList<User> listUser = userDAO.getListUser();

                                                    for (User user : listUser) {%>
                                                <tr>
                                                    <td class="user-id"><%=user.getUserID()%></td>
                                                    <td><%=user.getUserName()%></td>
                                                    <td><img src="<%=user.getUserAvatar()%>" class="img-circle" width="50" alt="Avatar"></td>
                                                    <td><%=user.getUserAddress()%></td>
                                                    <td><%=user.getUserEmail()%></td>
                                                    <td><%=user.getUserPhone()%></td>
                                                    <td><% if (user.getUserSex() == 1) {
                                                            out.print("Nam");
                                                        } else {
                                                            out.println("Nữ");
                                                        }%></td>
                                                    <td><%=user.getUserAge()%></td>
                                                    <td><%=user.getUserDateJoin()%></td>

                                                    <td>
                                                        <div class="btn-group">
<!--                                                            <div class="btn-group" role="group" aria-label="...">
                                                                <a href="edit-user.jsp?id=<%=user.getUserID()%>" class="btn btn-default btn-xs"><i class="lnr lnr-pencil"></i> Sửa</a>
                                                                <button type="button" class="btn btn-default btn-xs">Middle</button>
                                                                <button type="button" class="btn btn-default btn-xs">Right</button>
                                                            </div>-->
                                                            <button type="button" class="btn btn-primary btn-sm dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                                                Thao tác <span class="caret"></span>
                                                            </button>
                                                            <ul class="dropdown-menu">
                                                                <li><a href="edit-user.jsp?id=<%=user.getUserID()%>"><i class="lnr lnr-pencil"></i> Sửa</a></li>
                                                                <li><a href="#" class="deleteUser"><i class="lnr lnr-trash"></i> Xóa</a></li>
                                                                <li><a href="#"><i class="lnr lnr-eye"></i> Lịch sử thanh toán</a></li>
                                                            </ul>
                                                        </div>

                                                    </td>
                                                </tr>
                                                <% }%>

                                            </tbody>
                                        </table>
                                    </div>
                                    <!-- END TABLE HOVER -->
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
            <script>
                $("#my-table").on('click', '.deleteUser', function () {
                    // get the current row
                    var currentRow = $(this).closest("tr");
                    var id = currentRow.find(".user-id").html(); // get current row 1st table cell TD value

                    swal({
                        title: "Cảnh báo",
                        text: "Bạn có chắc chắn muốn xóa vĩnh viễn thành viên này?",
                        type: "warning",
                        animation: true,
                        showCancelButton: true,
                        confirmButtonColor: "#d9534f",
                        confirmButtonText: "Đồng ý",
                        cancelButtonText: "Hủy",
                        confirmButtonText: "Chấp nhận",
                        closeOnConfirm: false
                    },
                            function () {
                                $.post('deleteUser', {id: id}, function (result) {
                                    swal("Thành công", "Xóa thành công thành viên có mã là: " + result, "success");
                                    setTimeout(function () {
                                        currentRow.hide('slow');
                                    }, 500);
                                });
                            });
                });
                $('#my-table').DataTable({
                    buttons: [
                        'copy', 'excel', 'pdf'
                    ],
                    aaSorting: [[8, 'asc']],
                    language: {
                        "decimal": "",
                        "emptyTable": "Không có dữ liệu nào phù hợp",
                        "info": "Hiển thị từ _START_ đến _END_ của _TOTAL_ mục",
                        "infoEmpty": "Hiển thị từ 0 đến 0 của 0 mục",
                        "infoFiltered": "(đã lọc từ _MAX_ mục)",
                        "infoPostFix": "",
                        "thousands": ",",
                        "lengthMenu": "Hiển thị _MENU_ mục",
                        "loadingRecords": "Đang tải...",
                        "processing": "Đang xử lí...",
                        "search": "Tìm kiếm:",
                        "zeroRecords": "Không tìm thấy dữ liệu nào",
                        "paginate": {
                            "first": "Đầu",
                            "last": "Cuối",
                            "next": "Sau",
                            "previous": "Trước"
                        },
                        "aria": {
                            "sortAscending": ": activate to sort column ascending",
                            "sortDescending": ": activate to sort column descending"
                        }
                    }


                });
            </script>
    </body>
</html>
