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
        <title>Thanh toán</title>
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
                                                    <th>Giới tính</th>
                                                    <th>Ngày tham gia</th>
                                                    <th>Ngày hết hạn</th>
                                                    <th>Xác thực</th>
                                                    <th>Tình trạng</th>
                                                    <th></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%                                                    
                                                    Connection conn = DBConnect.getConnection();
                                                    String sql = "SELECT user.id, user.name,user.sex, user.avatar, user.proof, user.age, user.date_join, MAX(subscription.expiry) as expiry, DATEDIFF(expiry,CURDATE()) as day_can_use FROM user INNER  JOIN subscription ON user.id = subscription.user_id GROUP BY id ORDER BY expiry ASC";

                                                    PreparedStatement ps = conn.prepareCall(sql);
                                                    ResultSet rs = ps.executeQuery();

                                                    while (rs.next()) {
                                                %>
                                                <tr>
                                                    <td class="user-id"><%=rs.getLong("id")%></td>
                                                    <td><%=rs.getString("name")%></td>
                                                    <td><img src="<%=rs.getString("avatar")%>" class="img-circle" width="50" alt="Avatar"></td>
                                                    <td><% if (rs.getByte("sex")== 1) {
                                                            out.print("Nam");
                                                        } else {
                                                            out.println("Nữ");
                                                        }%></td>
                                                    <td><%=rs.getString("date_join")%></td>
                                                    <td><%=rs.getString("expiry")%></td>
                                                    <td><%=rs.getString("proof")%></td>
                                                    <td><% if (rs.getLong("day_can_use") > 0) {
                                                            out.print("<span class='label label-success'>Hoạt động</span>");
                                                        } else {
                                                            out.println("<span class='label label-danger'>Hết hạn</span>");
                                                        }%></td>
                                                    <td>
                                                        <a href="add-payment.jsp?id=<%=rs.getString("id")%>" class="btn btn-sm btn-primary"><span class="fa fa-money"></span> Thanh toán</a>
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
                                $.post('deletePlan', {id: id}, function (result) {
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
                    aaSorting: [[5, 'asc']],
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
