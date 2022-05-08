<%-- 
    Document   : booking
    Created on : 29-Sep-2021, 20:35:14
    Author     : TamNXL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Trang Đặt Phòng</title>
        <link rel="stylesheet"
              href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
        <script
        src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script
        src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    </head>
    <body>
        <c:if test="${empty sessionScope.user}">
            <c:redirect url="try"/>
        </c:if>
        <c:if test="${not empty sessionScope.user}">
            <c:if test="${sessionScope.user.roleId != 2}">
                <c:redirect url="try"/>
            </c:if>
        </c:if>

        <div class="container">
            <c:if test="${not empty sessionScope.user}">
                <font color="red">
                Chào mừng đến với Tony Booking, ${sessionScope.user.name}
                </font>
            </c:if>

            <p>
                <a class="btn btn-primary" href="logout">Đăng Xuất</a>
                <a class="btn btn-primary" href="resetPage">Reset Mật Khẩu</a>
            </p>
            <h2>Tìm Kiếm</h2>
            <form action="search" method="POST">
                <div class="form-group">
                    <label>Tên Khách Sạn</label>
                    <input type="text" name="txtName" value="${param.txtHotelName}" 
                           class="form-control" placeholder="Nhập tên khách sạn"/>
                </div>

                <div class="form-group">
                    <label>Khu Vực</label>
                    <select name="txtArea">
                        <c:forEach var="area" items="${sessionScope.listAreas}">
                            <option value="${area}"
                                    <c:if test="${area eq param.txtArea}"> selected="selected"</c:if>>
                                        >
                                    ${area}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label>Loại Phòng</label>
                    <select name="txtRoomType">
                        <c:forEach var="roomType" items="${sessionScope.listRoomType}">
                            <option value="${roomType}"
                                    <c:if test="${roomType eq param.txtRoomType}"> selected="selected"</c:if>>
                                        >
                                    ${roomType}
                            </option>
                        </c:forEach>
                    </select>
                </div>

                <div class="form-group">
                    <label>Số Lượng</label>
                    <input type="number" name="txtAmount" value="${param.txtAmount}" 
                           class="form-control" placeholder="Nhập số phòng"/>
                    <c:if test="${not empty requestScope.emptyAmount}">
                        <font color="red">
                        ${requestScope.emptyAmount}
                        </font>
                    </c:if>
                </div>

                <div class="form-group">
                    <label>Ngày Nhận Phòng</label> 
                    <input type="date" 
                           class="form-control" name="txtCheckInDate" value="">
                    <c:if test="${not empty requestScope.emptyCheckInDate}">
                        <font color="red">
                        ${requestScope.emptyCheckInDate}
                        </font>
                    </c:if>
                    <c:if test="${not empty requestScope.invalidCheckInDate}">
                        <font color="red">
                        ${requestScope.invalidCheckInDate}
                        </font>
                    </c:if>
                </div> 
                <div class="form-group">

                    <label>Ngày Trả Phòng</label> 
                    <input type="date" 
                           class="form-control" name="txtCheckOutDate" value="">
                    <c:if test="${not empty requestScope.emptyCheckOutDate}">
                        <font color="red">
                        ${requestScope.emptyCheckOutDate}
                        </font>
                    </c:if>
                    <c:if test="${not empty requestScope.invalidCheckOutDate}">
                        <font color="red">
                        ${requestScope.invalidCheckOutDate}
                        </font>
                    </c:if>

                    <button name="btnAction" value="search" type="submit" class="btn btn-primary">Tìm</button>
                </div>           
            </form>

            <a class="btn btn-primary btn-sm" href="viewCart">Xem danh sách phòng đã chọn</a>
            <h2>Danh Sách Khách Sạn</h2>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Tên Khách Sạn</th>
                        <th>Khu Vực</th>
                        <th>Địa Chỉ</th>
                        <th>Mô Tả</th>
                        <th>Email</th>
                        <th>Hotline</th>
                        <th>Loại Phòng</th>
                        <th>Giá</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="hotel" items="${requestScope.listHotels}">
                        <c:forEach var="roomType" items="${requestScope.listRoomTypeSearch}">
                            <c:if test="${hotel.hotelID eq roomType.hotelID}">
                                <c:set var="price" value="${roomType.price}"/>
                                <c:set var="typeName" value="${roomType.typeName}"/>
                                <c:set var="typeID" value="${roomType.typeID}"/>
                            </c:if>
                        </c:forEach>
                        <tr>
                            <td>${hotel.hotelName}</td>
                            <td>${hotel.area}</td>
                            <td>${hotel.address}</td>
                            <td>${hotel.description}</td>
                            <td>${hotel.email}</td>
                            <td>${hotel.hotline}</td>
                            <td>${typeName}</td>
                            <td>${price}</td>
                            <td>
                                <c:url var="addHotelLink" value="addHotelToCart">
                                    <c:param name="txtName" value="${param.txtName}"/>
                                    <c:param name="txtArea" value="${param.txtArea}"/>
                                    <c:param name="txtRoomType" value="${param.txtRoomType}"/>                                             
                                    <c:param name="txtTypeID" value="${typeID}"/>
                                    <c:param name="txtHotelID" value="${hotel.hotelID}"/>
                                    <c:param name="txtHotelName" value="${hotel.hotelName}"/>
                                    <c:param name="txtTypeName" value="${typeName}"/>
                                    <c:param name="txtPrice" value="${price}"/>
                                    <c:param name="txtAmount" value="${param.txtAmount}"/>
                                    <c:param name="txtCheckInDate" value="${param.txtCheckInDate}"/>
                                    <c:param name="txtCheckOutDate" value="${param.txtCheckOutDate}"/>
                                </c:url>
                                <a class="btn btn-primary btn-sm" href="${addHotelLink}">Thêm vào danh sách</a>
                            </td>
                        </tr>
                    </c:forEach>

                    <c:if test="${not empty requestScope.success}">
                        <c:if test="${requestScope.success}">
                        <font color="blue">
                        Thêm thành công!
                        </font>
                    </c:if>

                    <c:if test="${not requestScope.success}">
                        <font color="red">
                        Phòng đã nằm trong danh sách!
                        </font>
                    </c:if>
                </c:if>
                </tbody>
            </table>

        </div>
    </body>
</html>
