<%-- 
    Document   : viewCart
    Created on : 04-Oct-2021, 00:39:21
    Author     : TamNXL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Trang Danh Sách Phòng</title>
        <link rel="stylesheet"
              href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
        <script
        src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script
        src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    </head>
    <body>
        <c:if test="${empty sessionScope.user}">
            <c:redirect url="try"/>
        </c:if>

        <c:if test="${not empty sessionScope.user}">
            <c:if test="${sessionScope.user.roleId != 2}">
                <c:redirect url="try"/>
            </c:if>
        </c:if>

        <div class="container">
            <h2>Danh Sách Đặt Phòng</h2>
            <c:if test="${empty sessionScope.listItem}">
                <h3>Bạn chưa chọn phòng nào!</h3>
                <a class="btn btn-primary" href="bookingPage">Trở Về Trang Đặt Phòng</a>
                </br>
                <c:if test="${not empty requestScope.success}">
                    <font color="blue">
                    ${requestScope.success}
                    </font>
                </c:if>
            </c:if>

            <c:if test="${not empty sessionScope.listItem}">
                <p>
                    <a class="btn btn-primary" href="bookingPage">Trở Về Trang Đặt Phòng</a>
                    <a class="btn btn-primary" href="booking">Xác Nhận Đặt Phòng</a>
                </p>

                <form action="discount">
                    <div class="form-group">
                        <label>Discount Code</label>
                        <input type="text"name="txtDiscountCode" value="">
                        <input type="submit" value="Apply" name="btnApply" />
                        <c:if test="${requestScope.invalidCode}">
                            <font color="red">Code không hợp lệ!</font>
                        </c:if>
                        <c:if test="${not empty sessionScope.discountCode}">
                            <font color="blue">Bạn được giảm ${sessionScope.discountValue*100}% </font>
                        </c:if>
                    </div>

                </form>

                <c:set var="bill"/>
                <table border="1">
                    <thead>
                        <tr>
                            <th>Tên Khách Sạn</th>
                            <th>Loại Phòng</th>
                            <th>Ngày Nhận Phòng</th>
                            <th>Ngày Trả Phòng</th>
                            <th>Số Lượng</th>
                            <th>Giá</th>
                            <th>Tổng Đơn</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${sessionScope.listItem}">
                            <tr>
                        <form action="updateCart">
                            <td>${item.hotelName}</td>
                            <td>${item.typeName}</td>
                            <td>${item.checkInDate}</td>
                            <td>${item.checkOutDate}</td>
                            <td><input type="number" min="0" value="${item.amount}" name="txtAmount"/></td>
                            <td>${item.price}</td>
                            <td>${item.amount*item.price*item.totalDay}</td>
                            <td>
                                <input type="hidden" name="txtTypeID" value="${item.typeID}" />
                            <input class="btn btn-danger btn-sm" type="submit" value="Update" name="btnUpdate"/> </form>|
                        <a class="btn btn-danger btn-sm" href="removeHotel?txtTypeID=${item.typeID}" onclick="return confirm('Bạn có thực sự muốn hủy đặt phòng này?')">Hủy Phòng</a></td>

                        <c:if test="${not empty requestScope.bookingErrors}">
                            <c:forEach var="error" items="${requestScope.bookingErrors}">
                                <c:if test="${item.typeID eq error.typeID}">
                                    <td>
                                        <font color ="red">
                                        Xin lỗi, chúng tôi chỉ còn ${error.amount} phòng cùng loại!
                                        </font>
                                    </td>

                                </c:if>
                            </c:forEach>
                        </c:if>
                        </tr>
                        <c:set var="bill" value="${bill + item.amount*item.price*item.totalDay}"/>
                    </c:forEach>
                        <tr><h3>Tổng hóa đơn: ${bill - bill*sessionScope.discountValue} VND</h3></tr>    
                    </tbody>
                </table>

            </c:if>        
        </div>
    </body>
</html>
