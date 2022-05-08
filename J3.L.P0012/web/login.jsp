<%-- 
    Document   : login
    Created on : 27-Sep-2021, 23:02:20
    Author     : TamNXL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login Page</title>
        <link href="login.css" rel="stylesheet" type="text/css"/>
         <script src="https://www.google.com/recaptcha/api.js"></script>
         
    </head>
    <body>
        <div class="login-page">
            <h1>Tony Booking</h1>
            <div class="form">
                <form action="login" method="POST">
                    <input type="text" name="txtUsername" value="" placeholder="tên đăng nhập"/>
                    <input type="password" name="txtPassword" value="" placeholder="mật khẩu" />
                    <button type="submit" value="Login" name="btnLogin">Đăng Nhập</button>
                    <p><a href="loadRoom">Xem Danh Sách Phòng!</a></p>
                    <p>Bạn chưa có tài khoản?<a href="createAccountPage">Đăng ký ngay</a></p>
                    <c:if test="${not empty requestScope.error}">
                        <font color="red">
                            Tên hoặc nhập hoặc mật khẩu không đúng!
                        </font>
                    </c:if>
                        <c:if test="${not empty requestScope.invalidLink}">
                        <font color ="red">
                        ${requestScope.invalidLink}
                        </font>
                    </c:if>

                    <c:if test="${not empty requestScope.success}">
                        <font color ="red">
                        ${requestScope.success}
                        </font>
                    </c:if>
                    <c:if test="${not empty requestScope.confirmBooking}">
                        <c:if test="${requestScope.confirmBooking}">
                            <font color ="blue">
                            Xác nhận đặt phòng thành công!
                            </font>
                        </c:if>
                        <c:if test="${not requestScope.confirmBooking}">
                            <font color ="red">
                            Đường dẫn không hợp lệ!
                            </font>
                        </c:if>

                    </c:if>
                </form>
            </div>
        </div>
    </body>
</html>
