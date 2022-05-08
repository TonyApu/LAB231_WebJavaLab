<%-- 
    Document   : store
    Created on : 18-Sep-2021, 15:16:56
    Author     : TamNXL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cửa Hàng</title>
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
            <c:if test="${not empty sessionScope.user}">
                <font color="red">
                Chào mừng đến với YellowMoonShop, ${sessionScope.user.fullName}
                </font><br/>
            </c:if>

            <c:if test="${sessionScope.checkOutSuccess}">
                <font color="blue">
                    Chúc mừng bạn đã đặt hàng thành công!
                </font>
            </c:if>    
            <p>
                <c:if test="${not empty sessionScope.user}">
                    <a class="btn btn-primary" href="logout">Thoát</a>
                </c:if>
            </p>

            <form action="loadCake" method="POST">

                <div class="form-group">
                    <h2>TÌM KIẾM</h2>
                    <label>Tên bánh:</label>
                    <input class="form-control" type="text" name="txtSearchValue" placeholder="Bạn muốn tìm bánh gì?" value="${param.txtSearchValue}"/>
                </div>

                <div class="form-group">
                    <label>Category</label>
                    <select name="txtCategoryId">
                        <option value="0">All</option>
                        <c:forEach var="category" items="${sessionScope.listCategory}">
                            <option value="${category.key}"
                                    <c:if test="${param.txtCategoryId eq category.key}">
                                        selected="selected"
                                    </c:if>
                                    >${category.value}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label>Giá bánh khoảng từ:</label>
                    <input class="form-control" type="number" min="0" name="txtMinPrice" value="${param.txtMinPrice}"/>
                    <label>Cho đến:</label>
                    <input class="form-control" type="number" min="0" name="txtMaxPrice" value="${param.txtMaxPrice}"/>
                </div>

                <button type="submit" name="btnAction" class="btn btn-primary">Tìm Kiếm</button><br/>                
            </form>
            <a class="btn btn-primary btn-sm" href="viewCart">Xem giỏ hàng</a> 
            <c:if test="${not empty sessionScope.user}">
                <a class="btn btn-primary btn-sm"href="viewOrderHistory" style="margin-left: 10">Lịch sử giao dịch</a> 
            </c:if>
            <h2>Danh Sách Bánh:</h2>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Hình Ảnh</th>
                        <th>Tên Bánh</th>
                        <th>Mô Tả</th>
                        <th>Loại</th>
                        <th>Giá</th>
                        <th>Ngày Sản Xuất</th>
                        <th>Hạn Sử Dụng</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="cake" items="${sessionScope.listCake}">
                        <tr>
                            <td width="100"><img src="${cake.image}" width="80" height="70"/></td>
                            <td>${cake.name}</td>
                            <td>${cake.description}</td>
                            <td>${cake.category}</td>
                            <td>${cake.price} VND</td>
                            <td>${cake.createDate}</td>
                            <td>${cake.expirationDate}</td>
                            <td>
                                <c:url var="addCakeLink" value="addCake">
                                    <c:param name="txtCakeId" value="${cake.cakeId}"/>
                                    <c:param name="txtSearchValue" value="${param.txtSearchValue}"/>
                                    <c:param name="txtCategoryId" value="${param.txtCategoryId}"/>
                                    <c:param name="txtMinPrice" value="${param.txtMinPrice}"/>
                                    <c:param name="txtMaxPrice" value="${param.txtMaxPrice}"/>
                                    <c:param name="page" value="${sessionScope.currentPage}"/>

                                </c:url>
                                <a class="btn btn-primary btn-sm"href="${addCakeLink}">Thêm vào giỏ hàng</a> 

                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <br/>
            <c:set var="numberOfPage" value="${applicationScope.numberOfPage}"/>
            <c:forEach begin="1" end="${numberOfPage}" varStatus="counter">
                <c:url var="linkPage" value="loadCake">

                </c:url>
                <c:if test="${sessionScope.currentPage == counter.count}">
                    <a href="${linkPage}" style="color:red;">${counter.count}</a>
                </c:if>
                <c:if test="${sessionScope.currentPage != counter.count}">
                    <a href="${linkPage}" style="color:red;">${counter.count}</a>
                </c:if>
            </c:forEach>
        </div>
    </body>
</html>
