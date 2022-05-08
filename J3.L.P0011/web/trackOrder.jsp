<%-- 
    Document   : trackOrder
    Created on : 23-Sep-2021, 13:59:47
    Author     : TamNXL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet"
              href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
        <script
        src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script
        src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    </head>
    <body>
        <c:if test="${not empty sessionScope.user}">
            <c:set var="roleId" value="Ad"/>
            <c:if test="${sessionScope.user.roleId eq roleId}">
                <c:redirect url="try"/>
            </c:if>
        </c:if>

        <div class="container">
            <a class="btn btn-primary" href="viewOrderHistory">Về Trang Lịch Sử Mua Hàng</a>
            <table class="table table-bordered">
                <c:set var="order" value="${requestScope.order}"/>
                <thead>
                    <tr>
                        <th>Order Id</th>
                        <th>Họ và Tên</th>
                        <th>SĐT</th>
                        <th>Địa Chỉ</th>
                        <th>Tổng Đơn</th>
                        <th>Ngày Đặt Hàng</th>
                        <th>Trạng Thái</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>${order.orderId}</td>
                        <td>${order.fullName}</td>
                        <td>${order.phone}</td>
                        <td>${order.address}</td>
                        <td>${order.total}</td>
                        <td>${order.orderDate}</td>
                        <td>${order.status}</td>
                    </tr>
                </tbody>
            </table>

            <h2>Danh Sách Sản Phẩm</h2>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Tên</th>
                        <th>Số Lượng</th>
                        <th>Giá</th>
                        <th>Tổng</th>

                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${requestScope.listItem}">
                        <tr>
                            <td>${item.name}</td>
                            <td>${item.quantity}</td>
                            <td>${item.price}</td>
                            <td>${item.quantity*item.price}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </body>
</html>
