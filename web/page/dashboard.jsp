<%-- 
    Document   : dashboard
    Created on : May 30, 2017, 7:27:20 AM
    Author     : Jack
--%>
<%@page import="java.util.Calendar"%>
<%@page import="tools.Currency"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="connect.DBConnect"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="apple-touch-icon" sizes="76x76" href="assets/img/apple-icon.png">
<link rel="icon" type="image/png" sizes="96x96" href="assets/img/favicon.png">
<!-- MAIN -->
<div class="main">
    <!-- MAIN CONTENT -->
    <div class="main-content">
        <div class="container-fluid">
            <h3 class="page-title">Bảng điều khiển</h3> 
            <div class="panel">
                <div class="panel-heading">
                    <h3 class="panel-title"></h3>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="metric">
                                <span class="icon"><i class="fa fa-user-plus"></i></span>
                                <p>
                                    <%
                                        Connection conn = DBConnect.getConnection();
                                        String sql3 = "SELECT count(*) as TotalUser FROM user WHERE MONTH(date_join) = MONTH(CURRENT_DATE)";

                                        PreparedStatement ps3 = conn.prepareCall(sql3);
                                        ResultSet rs3 = ps3.executeQuery();

                                        while (rs3.next()) {

                                    %>
                                    <span class="number"><%=rs3.getString("TotalUser")%></span>
                                    <% }%>
                                    <span class="title">Thành viên tham gia tháng <%=Calendar.getInstance().get(Calendar.MONTH) + 1%></span>
                                </p>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="metric">
                                <span class="icon"><i class="fa fa-users"></i></span>
                                <p>
                                    <%
                                        String sql4 = "SELECT count(*) as TotalUser FROM user";

                                        PreparedStatement ps4 = conn.prepareCall(sql4);
                                        ResultSet rs4 = ps4.executeQuery();

                                        while (rs4.next()) {

                                    %>
                                    <span class="number"><%=rs4.getString("TotalUser")%></span>
                                    <% } %>
                                    <span class="title">Tổng số thành viên</span>
                                </p>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="metric">
                                <span class="icon"><i class="fa fa-money"></i></span>
                                <p>
                                    <%
                                        String sql2 = "SELECT sum(paid) as TotalMonth FROM subscription WHERE MONTH(paid_date) = MONTH(CURRENT_DATE)";

                                        PreparedStatement ps2 = conn.prepareCall(sql2);
                                        ResultSet rs2 = ps2.executeQuery();

                                        while (rs2.next()) {

                                    %>
                                    <span class="number"><%=Currency.formatCurrency(Long.parseLong(rs2.getString("TotalMonth")))%></span>
                                    <% }%>
                                    <span class="title">
                                        Doanh thu tháng <%=Calendar.getInstance().get(Calendar.MONTH) + 1%>
                                    </span>
                                </p>
                            </div>
                        </div>

                    </div>

                </div>
            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="panel">
                        <div class="panel-heading">
                            <h3 class="panel-title">Thành viên đã hết hạn</h3>
                        </div>
                        <div class="panel-body" >
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Họ tên</th>
                                        <th>Hết hạn từ ngày</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        String sql1 = "SELECT user.id,user.name,Max(subscription.expiry) as expiry, DATEDIFF(expiry,CURRENT_DATE()) as dayExpiry FROM user INNER JOIN subscription ON user.id = subscription.user_id  GROUP BY id HAVING dayExpiry < 0 ORDER BY dayExpiry ASC  LIMIT 10";

                                        PreparedStatement ps1 = conn.prepareCall(sql1);
                                        ResultSet rs1 = ps1.executeQuery();

                                        while (rs1.next()) {

                                    %>
                                    <tr>
                                        <td><%=rs1.getLong("id")%></td>
                                        <td><%=rs1.getString("name")%></td>
                                        <td>
                                            <%=rs1.getString("expiry")%>
                                        </td>
                                        <td><a href="add-payment.jsp?id=<%=rs1.getLong("id")%>" class="btn btn-xs btn-danger"><i class="fa fa-money"></i> Thanh toán</a></td>
                                    </tr>
                                    <% }%>
                                </tbody>
                            </table>

                        </div>
                        <div class="panel-footer">
                            <div class="row">
                                <div class="text-center"><a href="list-payment.jsp">Xem tất cả</a></div>
                            </div>
                        </div>    
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="panel">
                        <div class="panel-heading">
                            <h3 class="panel-title">Thành viên sắp hết hạn</h3>
                        </div>
                        <div class="panel-body" >
                            <table class="table table-striped">
                                <thead>
                                    <tr>
                                        <th>#</th>
                                        <th>Họ tên</th>
                                        <th>Số ngày còn lại</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        String sql = "SELECT user.id,user.name,Max(subscription.expiry) as expiry, DATEDIFF(expiry,CURRENT_DATE()) as dayExpiry FROM user INNER JOIN subscription ON user.id = subscription.user_id  GROUP BY id HAVING dayExpiry > 0 AND dayExpiry < 10 ORDER BY dayExpiry ASC  LIMIT 10";

                                        PreparedStatement ps = conn.prepareCall(sql);
                                        ResultSet rs = ps.executeQuery();

                                        while (rs.next()) {
                                            int percent = Integer.parseInt(rs.getString("dayExpiry")) * 10;
                                    %>
                                    <tr>
                                        <td><%=rs.getLong("id")%></td>
                                        <td><%=rs.getString("name")%></td>
                                        <td>
                                            <div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="<%=percent%>" aria-valuemin="0" aria-valuemax="100" style="width: <%=percent%>%;">
                                                <%=rs.getString("dayExpiry")%>
                                            </div>
                                        </td>
                                        <td><a href="add-payment.jsp?id=<%=rs.getLong("id")%>" class="btn btn-xs btn-success"><i class="fa fa-money"></i> Thanh toán</a></td>
                                    </tr>
                                    <% }%>
                                </tbody>
                            </table>
                        </div>
                        <div class="panel-footer">
                            <div class="row">
                                <div class="text-center"><a href="list-payment.jsp">Xem tất cả</a></div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <!-- END MAIN CONTENT -->
</div>
<!-- END MAIN -->
