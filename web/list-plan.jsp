<%@page import="tools.Currency"%>
<%@page import="java.util.ArrayList"%>
<%@page import="models.Plan"%>
<%@page import="dao.PlanDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Quản lí gói tập</title>
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
                                        <h3 class="panel-title">Danh sách gói tập</h3>

                                    </div>
                                    <div class="panel-body">
                                        <table class="table table-striped" id="my-table">
                                            <thead>
                                                <tr>
                                                    <th>#</th>
                                                    <th>Tên gói</th>
                                                    <th>Mô tả</th>
                                                    <th>Số ngày</th>
                                                    <th>Giá</th>
                                                    <th>Thao tác</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <% PlanDAO planDAO = new PlanDAO();
                                                    ArrayList<Plan> listPlan = planDAO.getListPlan();

                                                    for (Plan plan : listPlan) {
                                                %>
                                                <tr>
                                                    <td class="plan-id"><%=plan.getPlanID()%></td>
                                                    <td><%=plan.getPlanName()%></th>
                                                    <td><%=plan.getPlanDescription()%></th>
                                                    <td><%=plan.getPlanDay()%></th>
                                                    <td><%=Currency.formatCurrency(plan.getPlanRate())%></td>
                                                    <td>
                                                        <a href="edit-plan.jsp?id=<%=plan.getPlanID()%>" class="btn btn-primary btn-xs"><i class="lnr lnr-pencil"></i> Sửa</a>
                                                        <button type="button" class="btn btn-danger btn-xs deletePlain" data-id="<%=plan.getPlanID()%>"><i class="lnr lnr-trash"></i> Xóa</button>
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
                $(document).ready(function () {

                    $("#my-table").on('click', '.deletePlain', function () {
                        // get the current row
                        var currentRow = $(this).closest("tr");
                        var id = currentRow.find(".plan-id").html(); // get current row 1st table cell TD value

                        swal({
                            title: "Cảnh báo",
                            text: "Bạn có chắc chắn muốn xóa vĩnh viễn dữ liệu này?",
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
                                        swal("Thành công", "Xóa thành công gói tập có mã là:  " + result, "success");
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

                });

            </script>
    </body>
</html>