<%-- 
    Document   : manage
    Created on : 22-Oct-2021, 01:10:55
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
        <c:if test="${empty sessionScope.ROLE}">
            <c:redirect url="try"/>
        </c:if>

        <c:if test="${not empty sessionScope.ROLE}">
            <c:set var="roleId" value="Member"/>
            <c:if test="${sessionScope.ROLE eq roleId}">
                <c:redirect url="try"/>
            </c:if>
        </c:if>

        <div class="container" style="margin-top: 10px;">
            <font color="red">
            Xin chào, ${sessionScope.FULLNAME}
            </font>
            <a class="btn btn-primary" href="logout">Đăng Xuất</a>
            <h2>Quản Lý Bài Viết</h2>

            <form action="showPost">
                <div class="form-group">
                    <label>Tìm Bài Viết</label>
                    <input type="text" name="txtSearchValue" value="${param.txtSearchValue}"
                           placeholder="Nhập nội dung cần tim"/>
                </div>

                <div class="form-group">
                    <label>Status</label>
                    <select name="txtStatus">
                        <c:forEach var="status" items="${sessionScope.LIST_STATUS}">
                            <option value="${status}">                                        
                                ${status}
                            </option>
                        </c:forEach>
                    </select>
                </div>          

                <button type="submit" value="Search" name="btnSearch" class="btn btn-primary">Tìm</button>
            </form>    
            <h2>Danh Sách Bài Viết</h2>
            <c:set var="listPost" value="${sessionScope.LIST_POST}"/>

            <c:if test="${not empty requestScope.UPDATE_SUCCESS}">
                <font color="blue">${requestScope.UPDATE_SUCCESS}</font>
            </c:if>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Tên Bài Viết</th>
                        <th>Mô Tả</th>
                        <th>Tác Giả</th>
                        <th>Ngày Đăng</th>
                        <th>Trạng Thái</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="post" items="${sessionScope.LIST_POST}">
                        <tr>
                            <td>
                                <c:url var="viewPostDetail" value="viewPostDetail">
                                    <c:param name="txtPostId" value="${post.postDTO.postId}"/>
                                </c:url>
                                <a href="${viewPostDetail}">${post.postDTO.title}</a>
                            </td>
                            <td>${post.postDTO.shortDescription}</td>
                            <td>${post.name}</td>
                            <td>
                                <c:set var="minute" value="${post.postDTO.dateCreated.minutes}"/>
                                ${post.postDTO.dateCreated.date}  / ${post.postDTO.dateCreated.month + 1} at ${post.postDTO.dateCreated.hours}: <c:if test="${minute < 10}">0${minute}</c:if><c:if test="${minute >= 10}">${minute}</c:if>
                                </td>
                                <td>
                                ${post.postDTO.status}
                            </td>
                            <td>
                                <c:set var="status" value="Active"/>
                                <c:if test="${post.postDTO.status eq status}">
                                    <c:url var="deletePostLink" value="deletePost">
                                        <c:param name="txtPostId" value="${post.postDTO.postId}"/>
                                    </c:url>
                                    <a href="${deletePostLink}" class="btn btn-primary" style="background-color: lightcoral;">Delete</a>
                                </c:if>

                                <c:if test="${post.postDTO.status ne status}">
                                    <c:url var="activePostLink" value="activePost">
                                        <c:param name="txtPostId" value="${post.postDTO.postId}"/>
                                    </c:url>
                                    <a href="${activePostLink}" class="btn btn-primary" style="background-color: lightgreen;">Approval</a>
                                </c:if>    
                            </td>
                        </tr> 
                    </c:forEach>
                </tbody>
            </table>

            <c:set var="numberOfPage" value="${sessionScope.NUMBER_OF_PAGE}"/>
            <c:forEach begin="1" end="${numberOfPage}" varStatus="counter">
                <c:url var="showPostLink" value="showPost">
                    <c:param name="txtSearchValue" value="${param.txtSearchValue}"/>
                    <c:param name="page" value="${counter.count}"/>
                    <c:param name="txtStatus" value="${param.txtStatus}"/>
                </c:url>
                <c:if test="${sessionScope.CURRENT_PAGE == counter.count}">
                    <a href="${showPostLink}" style="color:red;">${counter.count}</a>
                </c:if>
                <c:if test="${sessionScope.CURRENT_PAGE != counter.count}">
                    <a href="${showPostLink}" style="color:blue;">${counter.count}</a>
                </c:if>    
            </c:forEach>
        </div>
    </body>
</html>
