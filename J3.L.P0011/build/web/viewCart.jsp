<%-- 
    Document   : viewCart
    Created on : 22-Sep-2021, 14:26:30
    Author     : TamNXL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Xem Giỏ Hàng</title>
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
            <h2>Giỏ Hàng Của Bạn</h2>
            <c:if test="${empty sessionScope.listItem}">
                <h2>Bạn chưa thêm gì vào giỏ hàng!</h2>
                <a class="btn btn-primary" href="loadCake">Trở Về Cửa Hàng</a>
            </c:if>
            <c:if test="${not empty sessionScope.listItem}">
                <p>
                    <a class="btn btn-primary" href="loadCake">Trở Về Cửa Hàng</a>
                    <a class="btn btn-primary" href="goToCheckOut">Thanh Toán</a>
                </p>
                <c:set var="mustPay"/>
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Hình Ảnh</th>
                            <th>Tên Sản Phẩm</th>
                            <th>Giá</th>
                            <th>Số Lượng</th>
                            <th>Tổng</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${sessionScope.listItem}">
                            <tr>
                        <form action="updateCart">
                            <td width="100"><img src="${item.image}" width="80" height="70"/></td>
                            <td>${item.name}</td>
                            <td>${item.price}</td>
                            <td><input type="number" min="0" value="${item.quantity}" name="txtQuantity"/></td>                            
                            <td>${item.quantity*item.price}</td>
                            <td>
                                <input type="hidden" name="txtCakeId" value="${item.cakeId}"/>
                            <input class="btn btn-danger btn-sm" type="submit" value="Update" name="btnUpdate"/> </form>| 
                        <a class="btn btn-danger btn-sm" href="removeCake?txtCakeId=${item.cakeId}" onclick="return confirm('Bạn có muốn xóa sản phẩm này?');">Xóa</a></td>
                        <c:if test="${not empty requestScope.listCakeError}">
                            <c:forEach var="cake" items="${requestScope.listCakeError}">
                                <c:if test="${item.cakeId eq cake.cakeId}">
                                    <td>
                                        <font color="green">
                                        Xin lỗi, sản phẩm này chỉ còn ${cake.quantity} cái trong cửa hàng.
                                        </font> 
                                    </td>
                                </c:if>
                            </c:forEach>
                        </c:if>
                        </tr>
                        <c:set var="totalBill" value="${totalBill + item.quantity*item.price}"/>
                    </c:forEach>
                        <tr><h3>Tổng hóa đơn: ${totalBill} VNĐ</h3></tr>
                    </tbody>
                </table>

            </c:if>    
        </div>
    </body>
</html>
