<%-- 
    Document   : viewPostDetail
    Created on : 21-Oct-2021, 01:17:18
    Author     : TamNXL
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Trang Chi Tiết</title>
        <link rel="stylesheet"
              href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
        <script
        src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script
        src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    </head>
    <body>
        <div class="container" style="margin-top: 10px">
            <p>
                <a href="showPost" class="btn btn-primary">Về Trang Chủ</a>
                <a class="btn btn-primary" href="logOut">Đăng Xuất</a>
            </p>

            <c:set var="post" value="${requestScope.POST}"/>
            <form action="postComment" method="POST">                    
                <h1>${post.postDTO.title}</h1>
                <i>
                    Tác Giả: ${post.name} </br>
                    <c:set var="minute" value="${post.postDTO.dateCreated.minutes}"/>
                    ${post.postDTO.dateCreated.date} tháng ${post.postDTO.dateCreated.month + 1} lúc ${post.postDTO.dateCreated.hours}:<c:if test="${minute < 10}">0${minute}</c:if><c:if test="${minute >= 10}">${minute}</c:if>
                    </i>
                    <br/>
                        <p>${post.postDTO.shortDescription}</p>
                <div class="row" 
                     style="border: 1px darkgray solid; border-radius: 10px; width: 100%; margin: 0 auto; padding: 5px;">
                    <p>${post.postDTO.content}</p>    
                </div>

                <div style="margin-top: 50px;">
                    <h2>Comment</h2>
                    <div class="form-group">
                        <input type="hidden" name="txtEmail" value="${sessionScope.EMAIL}" />
                        <input type="hidden" name="txtPostId" value="${post.postDTO.postId}" />
                        <input type="text" name="txtComment" value=""
                               maxlength="200" placeholder="Nhập comment" class="form-control"/> <br/>
                        <button type="submit" class="btn btn-primary">Comment</button>
                    </div>
                    <c:forEach var="comment" items="${post.commentList}">
                        <div class="form-group">
                            <c:set var="minutes" value="${comment.commentDTO.dateCreated.minutes}"/>
                            <p><small>${comment.name} at ${comment.commentDTO.dateCreated}</small></p>
                            <input class="form-control" type="text" name="" value="${comment.commentDTO.content}" readonly="readonly" />
                        </div>
                    </c:forEach>
                </div>
            </form>    
        </div>
    </body>
</html>
