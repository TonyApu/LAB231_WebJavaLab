<%-- 
    Document   : login.jsp
    Created on : 12-Oct-2021, 16:18:51
    Author     : TamNXL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Trang Đăng Nhập</title>
        <meta charset="UTF-8">

        <link href="login.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <div class="login-page">
            <div style="margin-left: 100px;">
                <h1>Simple Blog</h1>
            </div>           

            <div class="form">
                <form action="login" method="POST">
                    <input type="text" name="txtEmail" placeholder="Nhập email" /><br/>
                    <input type="password" name="txtPassword" placeholder="Nhập mật khẩu"/><br/>
                    <button type="submit" value="Login" name="btnLogin">Đăng Nhập</button>
                    <p><a href="showPost">Xem Bài Viết</a></p>
                    <p>Bạn chưa có tài khoản?<a href="registerPage">Đăng ký ngay</a></p>
                    <c:if test="${not empty requestScope.LOGIN_FAIL}">
                        <font color="red">
                        Email hoặc mật khẩu không đúng!
                        </font>
                    </c:if>
                </form>
            </div>    
        </div>
    </body>
</html>
