<%-- 
    Document   : search
    Created on : 14-Oct-2021, 22:09:30
    Author     : TamNXL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Simple Blog</title>
        <link rel="stylesheet"
              href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
        <script
        src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script
        src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    </head>
    <body>
        <div class="container" style="margin-top: 10px;">
            <c:if test="${not empty sessionScope.EMAIL}">
                <font color="red">
                Xin chào, ${sessionScope.FULLNAME}
                </font>
            </c:if>


            <p>
                <a class="btn btn-primary" href="postPage">Đăng Bài</a>
                <a class="btn btn-primary" href="showPost">Trang Chủ</a>
                <a class="btn btn-primary" href="logout">Đăng Xuất</a>
            </p>
            <h2>Simple Blog</h2>

            <form action="showPost">
                <div class="form-group">
                    <label>Search Value</label>
                    <input type="text" name="txtSearchValue" value="${param.txtSearchValue}"
                           placeholder="Nhập nội dung cần tim"/> 
                </div>

                <button type="submit" value="Search" name="btnAction" class="btn btn-primary">Tìm</button>

                <h2>Danh Sách Bài Viết</h2>
                <c:set var="listPost" value="${sessionScope.LIST_POST}"/>
                
                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th>Tên Bài Viết</th>
                            <th>Mô Tả</th>
                            <th>Tác Giả</th>
                            <th>Ngày Đăng</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="post" items="${sessionScope.LIST_POST}">
                            <tr>
                                <td>
                                    <c:url var="viewPostDetail" value="ViewPostDetailServlet">
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
                            </tr> 
                        </c:forEach>
                    </tbody>
                </table>
            </form>                
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
