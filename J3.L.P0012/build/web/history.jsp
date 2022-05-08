<%-- 
    Document   : history
    Created on : 18-Oct-2021, 18:13:11
    Author     : TamNXL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lịch Sử Đặt Phòng</title>
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
            <h2>Lịch Sử Đặt Phòng Của Bạn</h2>
            <c:if test="${empty requestScope.listBooking}">
                <font color="blue">
                Bạn chưa có đơn đặt hàng nào!
                </font></br>
                <a class="btn btn-primary" href="bookingPage">Trở Về Trang Đặt Phòng</a>
            </c:if>

            <c:if test="${not empty requestScope.listBooking}">
                <a class="btn btn-primary" href="bookingPage">Trở Về Trang Đặt Phòng</a>
                
                <form action="trackBooking">
                    <div class="form-group">
                        <label>Booking Id</label> 
                        <input type="text" 
                               class="form-control" name="txtBookId" placeholder="Nhập order id" value="${param.txtBookId}">

                    </div>
                    <button name="btnTrack" value="Track" type="submit" class="btn btn-primary">Tìm</button>
                    <c:if test="${not empty requestScope.error}">
                        <font color="red">
                        Mã order id không đúng!
                        </font>
                    </c:if>
                </form>
                               
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Booking Id</th>
                            <th>Ngày</th>
                            <th>Mã Giảm Giá</th>

                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="booking" items="${requestScope.listBooking}">
                            <tr>
                                <td>${booking.bookID}</td>
                                <td>${booking.bookDate}</td>
                                <td>${booking.discountCode}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:if>    
        </div>
    </body>
</html>
