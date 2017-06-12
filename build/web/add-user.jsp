<%-- 
    Document   : add-user
    Created on : May 31, 2017, 1:23:22 AM
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
        <title>Thêm thành viên</title>
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
                                        <h3 class="panel-title">Thêm thành viên</h3>
                                    </div>  
                                    <div class="panel-body">
                                        <form action="UserServlet" method="post" class="form-horizontal" id="addUser">
                                            <input type="hidden" name="action" value="insert">
                                            <input type="hidden" name="userAvatar" class="userAvatar" value="">
                                            <div class="col-md-9">
                                                <div class="form-group">
                                                    <label for="name" class="col-sm-2 control-label">Họ tên <span class="text-danger">*</span></label>
                                                    <div class="col-sm-10">
                                                        <input type="text" class="form-control" name="userName" id="username" style="margin-bottom: 10px;">
                                                        <span class="error text-danger">${errors.username}</span>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label for="name" class="col-sm-2 control-label">Email</label>
                                                    <div class="col-sm-10">
                                                        <input type="email" class="form-control" name="userEmail" id="useremail">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label for="name" class="col-sm-2 control-label">Địa chỉ <span class="text-danger">*</span></label>
                                                    <div class="col-sm-10">
                                                        <input type="text" class="form-control" name="userAddress" id="useraddress" style="margin-bottom: 10px;">
                                                        <span class="error text-danger">${errors.useraddress}</span>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label for="name" class="col-sm-2 control-label">Số điện thoại</label>
                                                    <div class="col-sm-10">
                                                        <input type="number" maxlength="11" class="form-control" name="userPhone" id="userphone" style="margin-bottom: 10px;">
                                                        <br>
                                                        <span class="error text-danger">${errors.userphone}</span>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label for="name" class="col-sm-2 control-label">Năm sinh <span class="text-danger">*</span></label>
                                                    <div class="col-sm-10">
                                                        <input type="number" class="form-control" maxlength="4"  name="userAge" id="usegAge" style="margin-bottom: 10px;">
                                                        <span class="error text-danger">${errors.userage}</span>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label for="name" class="col-sm-2 control-label">Giới tính <span class="text-danger">*</span></label>
                                                    <div class="col-sm-10">
                                                        <label class="fancy-radio">
                                                            <input name="userSex" value="1" type="radio" checked="checked">
                                                            <span><i></i>Nam</span>
                                                        </label>
                                                        <label class="fancy-radio">
                                                            <input name="userSex" value="0" type="radio" >
                                                            <span><i></i>Nữ</span>
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label for="name" class="col-sm-2 control-label">Ngày tham gia</label>
                                                    <div class="col-sm-10">
                                                        <input type="text" class="form-control datepick" name="userDateJoin" id="disabledInput" disabled value="<%                                                            Date date = new Date();
                                                            SimpleDateFormat ft = new SimpleDateFormat("yyyy-MM-dd");
                                                            out.print(ft.format(date));
                                                               %>">
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label for="name" class="col-sm-2 control-label">Chứng thực <span class="text-danger">*</span></label>
                                                    <div class="col-sm-10">
                                                        <select class="form-control" name="userProof" id="userproof">
                                                            <option value="Thẻ hội viên">Chứng minh thư</option>
                                                            <option value="Thẻ hội viên">Thẻ hội viên</option>
                                                        </select>

                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label for="name" class="col-sm-2 control-label">Chọn gói tập <span class="text-danger">*</span></label>
                                                    <div class="col-sm-10">
                                                        <select class="form-control plain" name="subsciptionPlan">
                                                            <option value="">-- Chọn gói --</option>
                                                            <%
                                                                Connection conn = DBConnect.getConnection();
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
                                                        <label for="name" class="col-sm-2 control-label">Tổng tiền <span class="text-danger">*</span></label>
                                                        <div class="col-sm-10">
                                                            <div class="input-group">
                                                                <input class="form-control totalMoney" name="subsciptionTotal" type="text" required>
                                                                <span class="input-group-addon">VNĐ</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="name" class="col-sm-2 control-label">Đã thanh toán <span class="text-danger">*</span></label>
                                                        <div class="col-sm-10">
                                                            <div class="input-group">
                                                                <input class="form-control totalpaidMoney" name="subsciptionPaid" type="text" required>
                                                                <span class="input-group-addon">VNĐ</span>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label for="name" class="col-sm-2 control-label"></label>
                                                    <div class="col-sm-10">
                                                        <button type="submit" class="btn btn-primary btn-block" ><i class="fa fa-paper-plane-o"></i> Xác nhận</button>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-3">
                                                <h3 class="panel-title">Ảnh đại diện <span class="text-danger">*</span></h3>
                                                <div id="my_photo_booth">
                                                    <div id="my_camera" style="margin: 10px 0;"></div>
                                                    <span class="error text-danger">${errors.useravatar}</span>
                                                    <script type="text/javascript" src="assets/scripts/webcam/webcam.min.js"></script>
                                                    <!-- Cấu hình camera -->
                                                    <script language="JavaScript">
                                                        Webcam.set({
                                                            // live preview size
                                                            width: 320,
                                                            height: 240,

                                                            // device capture size
                                                            dest_width: 640,
                                                            dest_height: 480,

                                                            // final cropped size
                                                            crop_width: 480,
                                                            crop_height: 480,

                                                            // format and quality
                                                            image_format: 'jpeg',
                                                            jpeg_quality: 90,

                                                            // flip horizontal (mirror mode)
                                                            flip_horiz: true
                                                        });
                                                        Webcam.attach('#my_camera');
                                                    </script>

                                                    <!-- A button for taking snaps -->

                                                    <div id="pre_take_buttons">
                                                        <!-- This button is shown before the user takes a snapshot -->
                                                        <input class="btn btn-primary" type=button value="Chụp" onClick="preview_snapshot()">
                                                    </div>
                                                    <div id="post_take_buttons" style="display:none">
                                                        <!-- These buttons are shown after a snapshot is taken -->
                                                        <input type=button class="btn btn-primary" value="Chụp lại" onClick="cancel_preview()">
                                                        <input type=button class="btn btn-primary" value="Lưu ảnh " onClick="save_photo()" style="font-weight:bold;">
                                                    </div>
                                                   
                                                </div>

                                                <div id="results text-center" style="display:none">
                                                    '<img src="' + data_uri + '"/><
                                                </div>

                                                <!-- Code to handle taking the snapshot and displaying it locally -->
                                                <script language="JavaScript">
                                                    // preload shutter audio clip
                                                    var shutter = new Audio();
                                                    shutter.autoplay = false;
                                                    shutter.src = navigator.userAgent.match(/Firefox/) ? 'assets/scripts/webcam/shutter.ogg' : 'assets/scripts/webcam/shutter.mp3';

                                                    function preview_snapshot() {
                                                        // play sound effect
                                                        try {
                                                            shutter.currentTime = 0;
                                                        } catch (e) {
                                                            ;
                                                        } // fails in IE
                                                        shutter.play();

                                                        // freeze camera so user can preview current frame
                                                        Webcam.freeze();

                                                        // swap button sets
                                                        document.getElementById('pre_take_buttons').style.display = 'none';
                                                        document.getElementById('post_take_buttons').style.display = '';
                                                    }

                                                    function cancel_preview() {
                                                        // cancel preview freeze and return to live camera view
                                                        Webcam.unfreeze();

                                                        // swap buttons back to first set
                                                        document.getElementById('pre_take_buttons').style.display = '';
                                                        document.getElementById('post_take_buttons').style.display = 'none';
                                                    }

                                                    function save_photo() {
                                                        // actually snap photo (from preview freeze) and display it
                                                        Webcam.snap(function (data_uri) {
                                                            
                                                            $(".userAvatar").val(data_uri);
                                                            swal("Thông báo", "Lưu ảnh thành công", "success")
                                                            // display results in page
                                                            document.getElementById('results').innerHTML =
                                                                    '<h2>Here is your large, cropped image:</h2>' +
                                                                    '<img src="' + data_uri + '"/><br/></br>' +
                                                                    '<a href="' + data_uri + '" target="_blank">Open image in new window...</a>';

                                                            // shut down camera, stop capturing
                                                            Webcam.reset();

                                                            // show results, hide photo booth
                                                            document.getElementById('results').style.display = '';
                                                            document.getElementById('my_photo_booth').style.display = 'none';
                                                        });
                                                    }
                                                    
                                                </script>	
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
