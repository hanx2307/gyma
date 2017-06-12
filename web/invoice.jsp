<%-- 
    Document   : invoice.jsp
    Created on : Jun 10, 2017, 11:23:28 PM
    Author     : Jack2307
--%>

<%@page import="tools.Currency"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="connect.DBConnect"%>
<%@page import="java.sql.Connection"%>
<%@page import="models.Plan"%>
<%@page import="models.Subscription"%>
<%@page import="dao.SubscriptionDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <title>Hóa đơn thanh toán</title>

        <style>
            .invoice-box{
                max-width:800px;
                margin:auto;
                padding:30px;
                border:1px solid #eee;
                box-shadow:0 0 10px rgba(0, 0, 0, .15);
                font-size:16px;
                line-height:24px;
                font-family: Roboto;
                color:#555;
            }

            .invoice-box table{
                width:100%;
                line-height:inherit;
                text-align:left;
            }

            .invoice-box table td{
                padding:5px;
                vertical-align:top;
            }

            .invoice-box table tr td:nth-child(2){
                text-align:right;
            }

            .invoice-box table tr.top table td{
                padding-bottom:20px;
            }

            .invoice-box table tr.top table td.title{
                font-size:45px;
                line-height:45px;
                color:#333;
            }

            .invoice-box table tr.information table td{
                padding-bottom:40px;
            }

            .invoice-box table tr.heading td{
                background:#eee;
                border-bottom:1px solid #ddd;
                font-weight:bold;
            }

            .invoice-box table tr.details td{
                padding-bottom:20px;
            }

            .invoice-box table tr.item td{
                border-bottom:1px solid #eee;
            }

            .invoice-box table tr.item.last td{
                border-bottom:none;
            }

            .invoice-box table tr.total td:nth-child(2){
                border-top:2px solid #eee;
                font-weight:bold;
            }

            @media only screen and (max-width: 600px) {
                .invoice-box table tr.top table td{
                    width:100%;
                    display:block;
                    text-align:center;
                }

                .invoice-box table tr.information table td{
                    width:100%;
                    display:block;
                    text-align:center;
                }
            }
        </style>
    </head>

    <body>
        <div class="invoice-box">
            <table cellpadding="0" cellspacing="0">
                <%
                    Connection conn = DBConnect.getConnection();
                    String sql = "SELECT * FROM subscription INNER JOIN plan ON subscription.plan_id = plan.id WHERE invoice = '" + request.getParameter("id") + "' ";

                    PreparedStatement ps = conn.prepareCall(sql);
                    ResultSet rs = ps.executeQuery();

                    while (rs.next()) {
                %>
                <tr class="top">
                    <td colspan="2">
                        <table>
                            <tr>
                                <td class="title">
                                    <a href="index.jsp"> <img src="assets/img/logo-dark.png" style="width:100%; max-width:300px;"></a>
                                </td>

                                <td>
                                    Mã hóa đơn: <%=rs.getString("invoice")%><br>
                                    Ngày thanh toán: <%=rs.getString("paid_date")%><br>
                                    Ngày hết hạn: <%=rs.getString("expiry")%>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>

                <tr class="information">
                    <td colspan="2">
                        <table>
                            <tr>
                                <td>
                                    Câu lạc bộ thể hình Gyma<br>
                                    Địa chỉ: 124 Vĩnh Tuy, Hai Bà Trưng, Hà Nội<br>
                                    Số điện thoại: 0988888888
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>

                <tr class="heading">
                    <td>
                        Gói tập
                    </td>

                    <td>
                        Đơn giá
                    </td>
                </tr>

                <tr class="item">
                    <td>
                        <%=rs.getString("plan_name")%>
                    </td>

                    <td>
                        <%=Currency.formatCurrency(Long.parseLong(rs.getString("plan_rate")))%>
                    </td>
                </tr>

                <tr class="total">
                    <td></td>

                    <td>
                        Tổng: <%=Currency.formatCurrency(Long.parseLong(rs.getString("total")))%><br>
                        Đã thanh toán: <%=Currency.formatCurrency(Long.parseLong(rs.getString("paid")))%>
                    </td>
                </tr>
            </table>
                    <% } %>
        </div>
    </body>
</html>
