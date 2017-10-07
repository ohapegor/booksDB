<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="from" uri="http://www.springframework.org/tags/form" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>Books Database</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <style type="text/css">
        .myrow-container {
            margin: 20px;
        }

        .btn {
            padding: 2px 2px;
            width: 5em;
            height: 2em;
            background-color: #4d3a1e;
            color: #f1f1f1;
            border-radius: 0;
            transition: .2s;
        }

        .btn:hover, .btn:focus {
            border: 1px solid #4d3a1e;
            background-color: #fff;
            color: #000;
        }

        a.aEdit:link, a.aDelete:link {
            color: #a83016;
        }

        a.aEdit:visited, a.aDelete:visited {
            color: #947872;
        }

        a.aEdit:hover, a.aDelete:hover {
            color: #60a870;
        }

        a.aEdit:active, a.aDelete:active {
            color: #ded728;
        }

        .panel-footer a {
            font-size: 1.2em;
        }

        .panel-footer a:link {
            color: #d1cbbc;
        }

        .panel-footer a:visited {
            color: #c4bba5;
        }

        .panel-footer a:hover {
            color: #a0cc95;
        }

        .panel-footer a:active {
            color: #ded728;
        }

    </style>

</head>
<body class=".container-fluid" style="background-color:whitesmoke">
<div align="center" class="container myrow-container">
    <div class="panel">
        <div class="panel-heading" style="background-color:#786455">
            <h1 align="center" class="panel-title" style="color: coral">Welcome to my Books Database (Author - Egor
                Okhapkin; email -
                ohapegor@list.ru)</h1>
        </div>
        <div class="panel-body">
            <%--Search book by title URL--%>
            <c:url value="/" var="search">
                <c:param name="id" value="${book.id}"/>
                <c:param name="page" value="${page }"/>
            </c:url>
            <form action="${search}">
                <div class="row">
                    <p>Search Book by title: <input type="text" name="searchTitle" placeholder="type title here...">
                        <input type="submit" class="btn" value="Search">
                    </p>
                </div>
            </form>
            <c:if test="${!empty searchTitle}">
                <p>Searching Books containing title: ${searchTitle}</p>
            </c:if>

            <c:if test="${!empty bookList}">

            <table class="table table-hover table-bordered">
                <thead style="background-color: #b39b89;">
                <tr>
                    <th>ID</th>
                    <th>Title</th>
                    <th>Description</th>
                    <th>Author</th>
                    <th>ISBN</th>
                    <th>Print Year</th>
                    <th>Read Already?</th>
                    <th>Read Book</th>
                    <th>Edit</th>
                    <th>Delete</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${bookList}" var="book">
                <tr>
                    <td><c:out value="${book.id}"/></td>
                    <td><c:out value="${book.title}"/></td>
                    <td><c:out value="${book.description}"/></td>
                    <td><c:out value="${book.author}"/></td>
                    <td><c:out value="${book.isbn}"/></td>
                    <td><c:out value="${book.printYear}"/></td>
                    <td><c:out value="${book.readAlready}"/></td>
                    <td>Click if read already</td>


                    <c:url value="editBook" var="editBook">
                        <c:param name="id" value="${book.id}"/>
                        <c:param name="page" value="${page}"/>
                        <c:param name="searchTitle" value="${searchTitle}"/>
                    </c:url>

                    <td><a class="aEdit" href="<c:out value="${editBook}" />">Edit</a></td>



                    <c:url value="deleteBook" var="deleteBook">
                        <c:param name="id" value="${book.id}"/>
                        <c:param name="page" value="${page}"/>
                        <c:param name="searchTitle" value="${searchTitle}"/>
                    </c:url>
                    <td><a class="aDelete" href="<c:out value="${deleteBook}" />" onclick="return confirmDelete();">Delete</a>
                    </td>
                </tr>
                </tbody>
                </c:forEach>
            </table>
        </div>
        <div align="center" class="panel-footer" style="background-color:#786455" id="pagination">
            </c:if>
            <c:if test="${empty bookList}">
                <h2>No books found</h2>
            </c:if>

            <%--Previous--%>
            <c:url value="/" var="prev">
                <c:param name="page" value="${page-1}"/>
                <c:param name="searchTitle" value="${searchTitle}"/>
            </c:url>
            <p> Pages :
                <c:if test="${page > 1}">
                    <a class="pn prev" href="<c:out value="${prev}" />">Prev</a>
                </c:if>

                <%--Pages--%>
                <c:forEach begin="1" end="${maxPages}" step="1" varStatus="i">
                    <c:choose>
                        <c:when test="${page == i.index}">
                            <span>${i.index}</span>
                        </c:when>
                        <c:otherwise>
                            <c:url value="/" var="url">
                                <c:param name="page" value="${i.index}"/>
                                <c:param name="searchTitle" value="${searchTitle}"/>
                            </c:url>
                            <a href='<c:out value="${url}" />'>${i.index}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
                <%--Next--%>
                <c:url value="/" var="next">
                    <c:param name="page" value="${page + 1}"/>
                    <c:param name="searchTitle" value="${searchTitle}"/>
                </c:url>
                <c:if test="${page + 1 <= maxPages}">
                    <a class="pn next" href='<c:out value="${next}" />' class="pn next">Next</a>
                </c:if>
            </p>
        </div>

        <%--Add / Edit book area--%>
        <c:url value="addBook" var="addBook">
            <c:param name="page" value="${page}"/>
            <c:param name="searchTitle" value="${searchTitle}"/>
        </c:url>
        <div class="panel-body">
            <form:form id="BookRegisterForm" cssClass="form-horizontal" action="${addBook}" modelAttribute="book">
                <div class="form-group">
                    <div class="control-label col-xs-3"><form:label path="title">Title</form:label></div>
                    <div class="col-xs-6">
                        <form:hidden path="id" value="${book.id}"/>
                        <form:input cssClass="form-control" path="title"/>
                    </div>
                </div>

                <div class="form-group">
                    <form:label path="description" cssClass="control-label col-xs-3">Decription</form:label>
                    <div class="col-xs-6">
                        <form:input cssClass="form-control" path="description"/>
                    </div>
                </div>

                <div class="form-group">
                    <form:label path="author" cssClass="control-label col-xs-3">Author</form:label>
                    <div class="col-xs-6">
                        <form:input cssClass="form-control" path="author"/>
                    </div>
                </div>

                <div class="form-group">
                    <form:label path="isbn" cssClass="control-label col-xs-3">ISBN</form:label>
                    <div class="col-xs-6">
                        <form:input cssClass="form-control" path="isbn"/>
                    </div>
                </div>

                <div class="form-group">
                    <form:label path="printYear" cssClass="control-label col-xs-3">Print Year</form:label>
                    <div class="col-xs-6">
                        <form:input cssClass="form-control" path="printYear"/>
                    </div>
                </div>



                <div class="form-group">
                    <div class="control-label col-xs-3"><form:label path="readAlready">readAlready?</form:label></div>
                    <div class="col-xs-6">
                        <form:input cssClass="form-control" path="readAlready"/>
                    </div>
                </div>

                <div class="form-group">
                    <div class="row">
                        <div class="col-xs-6">


                            <input type="submit" class="btn btn-primary"
                                   <c:if test="${empty book.title}">value="Add book"</c:if>
                                   <c:if test="${!empty book.title}">value="Edit book"</c:if>
                                   onclick="return submitBookForm();"/>

                        </div>
                    </div>
                </div>
            </form:form>
        </div>

    </div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>


<script type="text/javascript">
    function submitBookForm() {

// getting the book form values
        var title = $('#title').val().trim();
        var description = $('#description').val().trim();
        var author = $('#author').val().trim();
        var isbn = $('#isbn').val().trim();
        var printYear = $('#printYear').val();
        var readAlready = $('#isReadAlready').val();

        if (title.length == 0) {
            alert('Please enter title');
            $('#title').focus();
            return false;
        }

        if (title.length > 100) {
            alert('Title is too long');
            $('#title').focus();
            return false;
        }

        if (author.length > 100) {
            alert('Author name is too long');
            $('#author').focus();
            return false;
        }

        if (isbn.length > 20) {
            alert('ISBN is too long');
            $('#isbn').focus();
            return false;
        }

        if (printYear > 2017) {
            alert('Please enter proper printYear');
            $('#printYear').focus();
            return false;
        }

        if (readAlready < 0 || readAlready > 1) {
            alert('Please enter proper isReadAlready');
            $('#isReadAlready').focus();
            return false;
        }
        return true;
    };

    function confirmDelete() {
        if (confirm("Press Ok to DELETE BOOK")) {
            return true;
        } else return false;
    }
</script>

</body>
</html>
