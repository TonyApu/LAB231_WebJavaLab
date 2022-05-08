<%-- 
    Document   : orderHistory
    Created on : 23-Sep-2021, 12:52:23
    Author     : TamNXL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lịch Sử Mua Hàng</title>
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
            <h2>Lịch Sử Mua Hàng Của Bạn</h2>
            <c:if test="${empty requestScope.listOrder}">
                <h3>Bạn chưa có đơn đặt hàng nào!</h3>
                <a class="btn btn-primary" href="loadCake">Back To Store</a>
            </c:if>

            <c:if test="${not empty requestScope.listOrder}">
                <p>
                    <a class="btn btn-primary" href="loadCake">Back To Store</a>
                </p>

                <form action="trackOrder">
                    <div class="form-group">
                        <label>Order Id</label> 
                        <input type="text" 
                               class="form-control" name="txtOrderId" placeholder="Nhập order id" value="${param.txtOrderId}">

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
                            <th>Order Id</th>
                            <th>Ngày</th>
                            <th>Tổng đơn</th>

                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="order" items="${requestScope.listOrder}">
                            <tr>
                                <td>${order.orderId}</td>
                                <td>${order.orderDate}</td>
                                <td>${order.total}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>               
            </c:if>
        </div>
    </body>

</html>
