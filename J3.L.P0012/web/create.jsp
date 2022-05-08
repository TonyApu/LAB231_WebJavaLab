<%-- 
    Document   : create
    Created on : 29-Sep-2021, 20:47:07
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
        <title>Trang Đăng Kí</title>
    </head>
    <body>
        <c:if test="${not empty requestScope.message}">
            <font color="blue">
            ${requestScope.message}
            </font>
        </c:if>
            
        <c:set var="error" value="${requestScope.errors}"/>
        <div class="container" style="margin-top: 10px;">
            <div class="row" 
                 style="border: 1px darkgray solid; border-radius: 10px; width: 50%; margin: 0 auto; padding: 20px;">
                <div class="col-sm-12">
                    <h2 class="myclass">Đăng Kí Tài Khoản</h2>
                    <a class="btn btn-primary" href="try">Về Trang Đăng Nhập</a>
                    <form action="create" method="POST">
                        <div class="form-group">
                            <label>Tên tài khoản * (6-30 kí tự)</label>
                            <input type="text" name="txtUsername" value="${param.txtUsername}"
                                   class="form-control" placeholder="nhập tên tài khoản"/>
                            <c:if test="${not empty error.invalidUsername}">
                                <font color="red">
                                    ${error.invalidUsername}
                                </font>
                            </c:if>
                            <c:if test="${not empty error.existedUsername}">
                                <font color="red">
                                    ${error.existedUsername}
                                </font>
                            </c:if>
                        </div>
                        
                        <div class="form-group">
                            <label>Mật khẩu * (6-30 kí tự)</label>
                            <input type="password" name="txtPassword" value=""
                                   class="form-control" placeholder="nhập mật khẩu"/>
                            <c:if test="${not empty error.invalidPassword}">
                                <font color="red">
                                    ${error.invalidPassword}
                                </font>
                            </c:if>
                        </div>
                        
                        <div class="form-group">
                            <label>Xác nhận mật khẩu *</label>
                            <input type="password" name="txtConfirm" value=""
                                   class="form-control" placeholder="nhập mật khẩu"/>
                            <c:if test="${not empty error.invalidConfirm}">
                                <font color="red">
                                    ${error.invalidConfirm}
                                </font>
                            </c:if>
                        </div>
                        
                        <div class="form-group">
                            <label>Họ và tên *</label>
                            <input type="text" name="txtName" value="${param.txtName}"
                                   class="form-control" placeholder="nhập tên"/>
                            <c:if test="${not empty error.invalidName}">
                                <font color="red">
                                    ${error.invalidName}
                                </font>
                            </c:if>
                        </div>
                        
                        <div class="form-group">
                            <label>Số điện thoại *</label>
                            <input type="text" name="txtPhone" value="${param.txtPhone}"
                                   class="form-control" placeholder="nhập số điện thoại"/>
                            <c:if test="${not empty error.invalidPhone}">
                                <font color="red">
                                    ${error.invalidPhone}
                                </font>
                            </c:if>
                        </div>
                        
                        <div class="form-group">
                            <label>Email *</label>
                            <input type="text" name="txtEmail" value="${param.txtEmail}"
                                   class="form-control" placeholder="nhập email"/>
                            <c:if test="${not empty error.invalidEmail}">
                                <font color="red">
                                    ${error.invalidEmail}
                                </font>
                            </c:if>
                        </div>
                        
                        <button name="btnCreate" value="Create" type="submit" class="btn btn-primary">Đăng Kí</button>
                        <button type="reset" class="btn btn-primary">Reset</button>           
                    </form>
                </div>
            </div>
        </div>
    </body>
</html>
