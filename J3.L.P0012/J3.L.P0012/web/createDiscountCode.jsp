<%-- 
    Document   : createDiscountCode
    Created on : 07-Oct-2021, 17:38:42
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
        <title>Trang Tạo Mã Giảm Giá</title>
    </head>
    <body>
        <c:if test="${empty sessionScope.user}">
            <c:redirect url="try"/>
        </c:if>

        <c:if test="${not empty sessionScope.user}">
            <c:if test="${sessionScope.user.roleId != 1}">
                <c:redirect url="try"/>
            </c:if>
        </c:if>

        <c:set var="error" value="${requestScope.errors}"/>
        <div class="container" style="margin-top: 10px;">
            <div class="row" 
                 style="border: 1px darkgrey solid; border-radius: 10px; width: 50%; margin: 0 auto; padding: 20px;">
                <div class="col-sm-12">
                    <h2 class="myclass">Tạo Mã Giảm Giá</h2>
                    <a class="btn btn-primary" href="logout">Thoát</a>
                    <a class="btn btn-primary" href="resetPage">Đổi Mật Khẩu</a>

                    <form action="createDiscountCode" method="POST">
                        <div class="form-group">
                            <label>Mã Giảm Giá (tối đa 10 kí tự)</label>
                            <input type="text" name="txtCode" value="${param.txtCode}"
                                   class="form-control" placeholder="Nhập Code"/>

                            <c:if test="${not empty error.invalidCode}">
                                <font color="red">
                                ${error.invalidCode}
                                </font>
                            </c:if>

                            <c:if test="${not empty error.existedCode}">
                                <font color="red">
                                ${error.existedCode}
                                </font>
                            </c:if>    
                        </div>

                        <div class="form-group">
                            <label>Tên</label> 
                            <input type="text" 
                                   class="form-control" name="txtName" placeholder="Nhập tên" value="${param.txtName}">
                            <c:if test="${not empty error.invalidName}">
                                <font color="red">
                                ${error.invalidName}
                                </font><br/>
                            </c:if>
                        </div>

                        <div class="form-group">
                            <label>Giá Trị (%)</label> 
                            <input type="number" min="1" max="100"
                                   class="form-control" name="txtValue" placeholder="Nhập giá trị" value="${param.txtValue}">
                            <c:if test="${not empty error.invalidValue}">
                                <font color="red">
                                ${error.invalidValue}
                                </font><br/>
                            </c:if>
                        </div>

                        <div class="form-group">
                            <label>Ngày hết hạn</label> 
                            <input type="date"
                                   class="form-control" name="txtExpiredDate" placeholder="Nhập ngày hết hạn" value="${param.txtExpiredDate}">



                            <button name="btCreate" value="Create" type="submit" class="btn btn-primary">Tạo</button>
                            <button type="reset" class="btn btn-primary">Reset</button>    
                    </form>
                    <c:if test="${requestScope.success}">
                        <font color="blue">
                        Tạo thành công!
                        </font><br/>
                    </c:if>

                </div>
            </div>
        </div>
    </div>    
</body>
</html>
