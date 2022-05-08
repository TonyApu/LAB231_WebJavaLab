<%-- 
    Document   : reset
    Created on : 30-Sep-2021, 16:45:56
    Author     : TamNXL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <link rel="stylesheet"
              href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
        <script
        src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script
        src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
        <title>Trang Đổi Mật Khẩu</title>
    </head>
    <body>
        <c:if test="${empty sessionScope.user}">
            <c:redirect url="try"/>
        </c:if>

        <div class="container" style="margin-top: 10px;">
            <div class="row" 
                 style="border: 1px darkgray solid; border-radius: 10px; width: 50%; margin: 0 auto; padding: 20px;">
                <div class="col-sm-12">
                    <h2>Đổi Mật Khẩu</h2>
                    <c:if test="${not empty sessionScope.user}">
                        <c:if test="${sessionScope.user.roleId ==  2}">
                            <a class="btn btn-primary" href="bookingPage">Trở Về Trang Booking</a>
                        </c:if>
                        <c:if test="${sessionScope.user.roleId ==  1}">
                            <a class="btn btn-primary" href="createDiscountPage">Trở Về Trang Tạo Mã Giảm Giá</a>
                        </c:if>
                    </c:if>

                    <form action="reset" method="POST">
                        <div class="form-group">
                            <label>Nhập Mật Khẩu *</label>
                            <input type="password" name="txtPassword" value="" 
                                   class="form-control" placeholder="Nhập mật khẩu"/>
                            <c:if test="${not empty requestScope.invalidPassword}">
                                <font color="red">
                                ${requestScope.invalidPassword}
                                </font>
                            </c:if>
                        </div>

                        <div class="form-group">
                            <label>Nhập Mật Khẩu Mới * (6 - 30 kí tự)</label>
                            <input type="password" name="txtNewPassword" value="" 
                                   class="form-control" placeholder="Nhập mật khẩu mới"/>
                            <c:if test="${not empty requestScope.invalidNewPassword}">
                                <font color="red">
                                ${requestScope.invalidNewPassword}
                                </font>
                            </c:if>
                        </div>

                        <div class="form-group">
                            <label>Xác Nhận Mật Khẩu Mới *</label>
                            <input type="password" name="txtConfirm" value="" 
                                   class="form-control" placeholder="Xác nhận mật khẩu mới"/>
                            <c:if test="${not empty requestScope.invalidConfirm}">
                                <font color="red">
                                ${requestScope.invalidConfirm}
                                </font>
                            </c:if>
                        </div>

                        <c:if test="${not empty requestScope.success}">
                            <font color="blue">
                            ${requestScope.success}
                            </font>
                        </c:if></br>

                        <button name="btnReset" value="reset" type="submit" class="btn btn-primary">Đổi Mật Khẩu</button>
                        <button type="reset" class="btn btn-primary">Reset</button>
                    </form>        
                </div>
            </div>
        </div>
    </body>
</html>
