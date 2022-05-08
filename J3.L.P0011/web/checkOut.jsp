<%-- 
    Document   : checkOut
    Created on : 23-Sep-2021, 10:41:58
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
        <title>Trang Thanh Toán</title>
    </head>
    <body>
        <c:if test="${not empty sessionScope.user}">
            <c:set var="roleId" value="Ad"/>
            <c:if test="${sessionScope.user.roleId eq roleId}">
                <c:redirect url="try"/>
            </c:if>
        </c:if>
        
        <c:if test="${sessionScope.checkOutSuccess}">
            <c:redirect url="store"/>
        </c:if>
        <c:set var="error" value="${requestScope.errors}"/>
        <div class="container" style="margin-top: 10px;">
            <div class="row" style="border: 1px darkgray solid; border-radius: 10px; 
                 width: 50%; margin: 0 auto; padding: 20px;">
                <div class="col-sm-12">
                    <h2 class="myclass">Thanh Toán</h2>
                    <a class="btn btn-primary" href="viewCart">Trở Về Giỏ Hàng</a>

                    <c:if test="${not empty sessionScope.user}">
                        <c:set var="name" value="${sessionScope.user.fullName}"/>
                        <c:set var="phone" value="${sessionScope.user.phone}"/>
                        <c:set var="address" value="${sessionScope.user.address}"/>
                    </c:if>

                    <form action="checkOut" method="post">
                        <div class="form-group">
                            <label>Họ Và Tên</label>
                            <input type="text" class="form-control" name="txtFullName" 
                                   placeholder="Nhập tên" value="${name}"/>
                            <c:if test="${not empty error.invalidName}">
                                <font color="red">${error.invalidName}</font><br/>
                            </c:if>
                        </div>

                        <div class="form-group">
                            <label>Số Điện Thoại</label>
                            <input type="text" class="form-control" name="txtPhone" 
                                   placeholder="Nhập SĐT" value="${phone}"/>
                            <c:if test="${not empty error.invalidPhone}">
                                <font color="red">${error.invalidPhone}</font><br/>
                            </c:if>
                        </div>

                        <div class="form-group">
                            <label>Địa Chỉ</label>
                            <input type="text" class="form-control" name="txtAddress" 
                                   placeholder="Nhập địa chỉ" value="${address}"/>
                            <c:if test="${not empty error.invalidAddress}">
                                <font color="red">${error.invalidAddress}</font><br/>
                            </c:if>
                        </div>
                        <br/>

                        <button type="submit" class="btn btn-primary" value="checkOut" name="btnCheckOut">Thanh Toán</button>
                        <button type="reset" class="btn btn-primary">Reset</button>
                    </form>
                    
                </div>

            </div>
        </div>
    </body>
