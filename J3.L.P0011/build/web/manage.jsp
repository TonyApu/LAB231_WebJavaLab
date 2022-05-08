<%-- 
    Document   : manage
    Created on : 21-Sep-2021, 13:18:09
    Author     : TamNXL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Trang Quản Lý</title>
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
            <c:if test="${sessionScope.user.roleId ne roleId}">
                <c:redirect url="try"/>
            </c:if>   
        </c:if>
        <c:if test="${empty sessionScope.user}">
             <c:redirect url="try"/>
        </c:if>
        
        <div class="container">
            <c:if test="${not empty sessionScope.user}">
                <font color="red">
                welcome, ${sessionScope.user.fullName}
                </font>
            </c:if>

            <p>
                <a class="btn btn-primary" href="create">THÊM BÁNH MỚI:</a>
                <c:if test="${not empty sessionScope.user}">
                    <a class="btn btn-primary" href="logout">ĐĂNG XUẤT</a>
                </c:if>
            </p>
            <form action="loadCake" method="POST">
                <div class="form-group">
                    <h2>Tìm Kiếm</h2>
                    <label>Tên Bánh</label> 
                    <input type="text" 
                           class="form-control" name="txtSearchValue" placeholder="Nhập tên bánh" value="${param.txtSearchValue}"/>

                </div>
                <div class="form-group">
                    <label>Loại Bánh</label> 
                    <select name="txtCategoryId" >
                        <option value="0">Tất cả</option>
                        <c:forEach var="category" items="${sessionScope.listCategory}">
                            <option value="${category.key}"
                                    <c:if test="${param.txtCategoryId eq category.key}">
                                        selected="selected"
                                    </c:if>

                                    >${category.value}</option>

                        </c:forEach>
                    </select>
                </div>
                <div class="form-group">
                    <label>Giá từ</label> 
                    <input type="number" min="0"
                           class="form-control" name="txtMinPrice" value="${param.txtMinPrice}">
                    <label>Đến</label> 
                    <input type="number" min="0"
                           class="form-control" name="txtMaxPrice" value="${param.txtMaxPrice}">
                </div>

                <button name="btnSearch" value="search" type="submit" class="btn btn-primary">Tìm</button>
            </form>
            <h2>Danh Sách Bánh</h2>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Hình Ảnh</th>
                        <th>Tên</th>
                        <th>Mô Tả</th>
                        <th>Loại</th>
                        <th>Giá</th>
                        <th>Số Lượng</th>
                        <th>Ngày Sản Xuất</th>
                        <th>Hạn Sử Dụng</th>
                        <th>Trạng Thái</th>
                        <th>Cập Nhật</th>

                    </tr>
                </thead>
                <tbody>

                    <c:forEach var="cake" items="${sessionScope.listCake}">
                        <tr>
                            <td>${cake.cakeId}</td>
                            <td width="100"><img src="${cake.image}" width="80" height="70"/></td>
                            <td>${cake.name}</td>
                            <td>${cake.description}</td>
                            <td>${cake.category}</td>
                            <td>${cake.price}</td>
                            <td>${cake.quantity}</td>
                            <td>${cake.createDate}</td>
                            <td>${cake.expirationDate}</td>
                            <td>${cake.status}</td>
                            <td>
                                <c:url var="updateLink" value="updateCake">
                                    <c:param name="txtCakeId" value="${cake.cakeId}"/>
                                    <c:param name="txtSearchValue" value="${param.txtSearchValue}"/>
                                    <c:param name="txtCategoryId" value="${param.txtCategoryId}"/>
                                    <c:param name="txtMinPrice" value="${param.txtMinPrice}"/>
                                    <c:param name="txtMaxPrice" value="${param.txtMaxPrice}"/>
                                    <c:param name="page" value="${sessionScope.currentPage}"/>

                                </c:url>
                                <a class="btn btn-primary btn-sm"href="${updateLink}">Update</a>
                        </tr>
                    </c:forEach>




                </tbody>
            </table>
            <br/>
            <c:set var="numberOfPage" value="${sessionScope.numberOfPage}"/>

            <c:forEach begin="1" end="${numberOfPage}" varStatus="counter">
                <c:if test="${sessionScope.currentPage == counter.count}">
                    <a href="loadCake?page=${counter.count}" style="color: red;">${counter.count}</a>
                </c:if>
                <c:if test="${sessionScope.currentPage != counter.count}">
                    <a href="loadCake?page=${counter.count}">${counter.count}</a>
                </c:if>     

            </c:forEach>
        </div>
    </body>
</html>
