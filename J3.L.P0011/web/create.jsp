<%-- 
    Document   : create
    Created on : 21-Sep-2021, 14:46:36
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
        <title>Thêm Bánh Mới</title>
    </head>
    <body>
        <c:if test="${not empty sessionScope.user}">
            <c:set var="roleId" value="Ad"/>
            <c:if test="${sessionScope.user.roleId ne roleId}">
                <c:redirect url="try"/>
            </c:if>
        </c:if>

        <c:set var="error" value="${requestScope.error}"/>
        <div class="container" style="margin-top: 10px">
            <div class="row"
                 style="border: 1px darkgray solid; border-radius: 10px; width: 50%; margin: 0 auto; padding: 20px">
                <div class="col-sm-12">
                    <h2 class="myclass">Thêm Bánh</h2>
                    <a class="btn btn-primary" href="loadCake">Về Trang Quản Lý</a>
                    <form action="createCake" method="POST">
                        <div class="form-group">
                            <label>Tên</label>
                            <input type="text" name="txtName" class="form-control" 
                                   placeholder="Nhập tên bánh" value="${param.txtName}"/>
                            <c:if test="${not empty error.emptyName}">
                                <font color="red">${error.emptyName}</font>
                            </c:if><br/>
                        </div>

                        <div class="form-group">
                            <label>Mô Tả</label>
                            <input type="text" name="txtDescription" class="form-control" 
                                   placeholder="Nhập mô tả" value="${param.txtDescription}"/>
                            <c:if test="${not empty error.emptyDescription}">
                                <font color="red">${error.emptyDescription}</font>
                            </c:if><br/>
                        </div>

                        <div class="form-group">
                            <label>Giá</label>
                            <input type="number" min="0" name="txtPrice" class="form-control" 
                                   placeholder="Nhập giá" value="${param.txtPrice}"/>
                            <c:if test="${not empty error.emptyPrice}">
                                <font color="red">${error.emptyPrice}</font>
                            </c:if><br/>
                        </div>

                        <div class="form-group">
                            <label>Số Lượng</label>
                            <input type="number" min="0" name="txtQuantity" class="form-control" 
                                   placeholder="Nhập số lượng" value="${param.txtQuantity}"/>
                            <c:if test="${not empty error.emptyQuantity}">
                                <font color="red">${error.emptyQuantity}</font>
                            </c:if><br/>
                        </div>

                        <div class="form-group">
                            <label>Ngày Hết Hạn (dd/mm/yyyy)</label>
                            <input type="date" min="0" name="txtExpirationDate" class="form-control" 
                                   placeholder="Nhập ngày hết hạn" value="${param.txtExpirationDate}"/>
                            <c:if test="${not empty error.emptyExpirationDate}">
                                <font color="red">${error.emptyExpirationDate}</font>
                            </c:if><br/>
                            <c:if test="${not empty error.invalidExpirationDate}">
                                <font color="red">${error.invalidExpirationDate}</font>
                            </c:if><br/>
                        </div>

                        <div class="form-group">
                            <label>Hình Ảnh</label>
                            <input type="text" name="txtImage" value="${requestScope.filePath}"/>
                            <input type="submit" value="Chọn Ảnh" name="btnChoose"/>
                            <c:if test="${not empty error.emptyImage}">
                                <font color="red">${error.emptyImage}</font>
                            </c:if><br/>
                            <c:if test="${not empty error.invalidImage}">
                                <font color="red">${error.invalidImage}</font>
                            </c:if><br/>
                        </div>

                        <div class="form-group">
                            <label>Loại Bánh</label> 
                            <select name="txtCategoryId">
                                <c:forEach var="category" items="${sessionScope.listCategory}">
                                    <option value="${category.key}">${category.value}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <input type="hidden" name="txtTypeAction" value="create" />
                        <button name="btnCreate" value="Create" type="submit" class="btn btn-primary">Tạo Mới</button>
                        <button type="reset" class="btn btn-primary">Reset</button>    
                    </form>
                    <c:if test="${requestScope.success}">
                        <font color="blue">Tạo Mới Thành Công!</font> <br/>           
                    </c:if>        
                </div>
            </div>
        </div>
    </body>
</html>
