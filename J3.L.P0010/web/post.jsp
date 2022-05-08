<%-- 
    Document   : post
    Created on : 21-Oct-2021, 14:28:37
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
        <title>Trang Đăng Bài</title>
    </head>
    <body>
        <c:if test="${empty sessionScope.EMAIL}">
            <c:redirect url="try"/>
        </c:if>

        <c:set var="errors" value="${requestScope.ERRORS}"/>
        <div class="container" style="margin-top: 10px;">
            <h2 class="myclass">Đăng Bài</h2>
            <p>
                <a class="btn btn-primary" href="showPost">Trang Chủ</a>
                <a class="btn btn-primary" href="logout">Đăng Xuất</a>
            </p>

            <form action="postArticle" method="POST">
                <div class="form-group">
                    <label>Title</label>
                    <input type="text" name="txtTitle" value=""
                           placeholder="Nhập tên bài đăng" class="form-control"/> <br/>
                    <c:if test="${not empty errors.invalidTitle}">
                        <font color="red">${errors.invalidTitle}</font> <br/>
                    </c:if>
                </div>

                <div class="form-group">
                    <label>Mô Tả</label>
                    <input type="text" name="txtShortDescription" value=""
                           placeholder="Nhập mô tả" class="form-control"/> <br/>
                    <c:if test="${not empty errors.invalidShortDescripton}">
                        <font color="red">${errors.invalidShortDescripton}</font> <br/>
                    </c:if>
                </div>

                <div class="form-group">
                    <label>Nội Dung</label>
                    <textarea name="txtContent" value="${param.txtContent}" rows="10"
                              placeholder="Nhập nội dung" class="form-control" cols="50"></textarea><br/>
                    <c:if test="${not empty errors.invalidContent}">
                        <font color="red">${errors.invalidContent}</font> <br/>
                    </c:if>
                </div>

                <button name="btnPost" value="Post" type="submit" class="btn btn-primary">Đăng Bài</button></br>
                <c:if test="${not empty requestScope.SUCCESS}">
                    <font color="blue">
                    ${requestScope.SUCCESS}
                    </font>
                </c:if>
            </form>
        </div>
    </body>
</html>
