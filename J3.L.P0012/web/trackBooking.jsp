<%-- 
    Document   : trackBooking
    Created on : 18-Oct-2021, 22:26:54
    Author     : TamNXL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Chi Tiết Đặt Phòng</title>
        <link rel="stylesheet"
              href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
        <script
        src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script
        src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    </head>
    <body>
        <c:if test="${not empty sessionScope.user}">
            <c:set var="roleId" value="1"/>
            <c:if test="${sessionScope.user.roleId eq roleId}">
                <c:redirect url="try"/>
            </c:if>
        </c:if>

        <div class="container">
            <a class="btn btn-primary" href="viewBookingHistory" style="margin-top: 10px">Về Trang Lịch Sử Đặt Phòng</a>
            <h2>Danh Sách Phòng</h2>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Mã Phòng</th>
                        <th>Giá Phòng(1 ngày)</th>
                        <th>Ngày Nhận Phòng</th>
                        <th>Ngày Trả Phòng</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${requestScope.listItem}">
                        <tr>
                            <td>${item.roomID}</td>
                            <td>${item.price}</td>
                            <td>${item.checkInDate}</td>
                            <td>${item.checkOutDate}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

    </body>
</html>
