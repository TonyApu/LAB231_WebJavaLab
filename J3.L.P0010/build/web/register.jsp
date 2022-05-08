<%-- 
    Document   : register
    Created on : 16-Oct-2021, 15:53:01
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
        <title>Trang Đăng Ký</title>
    </head>
    <body>
        <c:if test="${not empty requestScope.message}">
            <font color="blue">
            ${requestScope.message}
            </font>
        </c:if>

        <c:set var="result" value="${requestScope.CREATE_ERRORS}"/>

        <div class="container" style="margin-top: 10px;">
            <div class="row" 
                 style="border: 1px darkgray solid; border-radius: 10px; width: 50%; margin: 0 auto; padding: 20px;">
                <div class="col-sm-12">
                    <h2 class="myclass">Đăng Ký</h2>
                    <a class="btn btn-primary" href="try">Về Trang Đăng Nhập</a>

                    <form action="register" method="POST">
                        <div class="form-group">
                            <label>Email</label>    
                            <input type="text" name="txtEmail" value="${param.txtEmail}"
                                   maxlength="100" placeholder="Nhập email" class="form-control"/> <br/>
                            <c:if test="${not empty result.emailIsExisted}">
                                <font color="red">
                                ${result.emailIsExisted}
                                </font><br/>
                            </c:if>
                            <c:if test="${not empty result.emailIsIncorrectFormat}">
                                <font color="red">
                                ${result.emailIsIncorrectFormat}
                                </font><br/>
                            </c:if>
                        </div>
                        
                        <div class="form-group">
                            <label>Password* <6-20 chars></label>    
                            <input type="password" name="txtPassword"
                                   placeholder="Nhập mật khẩu" class="form-control"/> <br/>
                            <c:if test="${not empty result.passwordLengtErr}">
                                <font color="red">
                                ${result.passwordLengtErr}
                                </font><br/>
                            </c:if>
                        </div>
                        
                        <div class="form-group">
                            <label>Confirm* <6-20 chars></label>    
                            <input type="password" name="txtConfirm"
                                   placeholder="Xác nhận mật khẩu" class="form-control"/> <br/>
                            <c:if test="${not empty result.confirmNotMatched}">
                                <font color="red">
                                ${result.confirmNotMatched}
                                </font><br/>
                            </c:if>
                        </div>           

                        <div class="form-group">
                            <label>Họ Và Tên <2-50 chars></label>    
                            <input type="text" name="txtFullname" value="${param.txtFullname}"
                                   placeholder="Nhập họ và tên" class="form-control"/> <br/>
                            <c:if test="${not empty result.fullNameLengtErr}">
                                <font color="red">
                                ${result.fullNameLengtErr}
                                </font><br/>
                            </c:if>
                        </div>
                        <button name="btnRegister" value="Register" type="submit" class="btn btn-primary">Đăng Kí</button>
                        <button type="reset" class="btn btn-primary">Reset</button>           
                    </form>
                </div>
            </div>

        </div>
    </body>
</html>
