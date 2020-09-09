<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="user.UserDAO" %>
    <%@ page import="java.io.PrintWriter" %>
	<% request.setCharacterEncoding("UTF-8"); %> <!-- 건너오는 모든데이터를 utf8 받을수있도록 만들어주는거 -->

<!DOCTYPE html>
<html>
<head> 
<meta http-equiv="Content-Type" content="test/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>

<%
session.invalidate(); //세션을 빼았기도록 만들어주는거
%>
<script>
location.href = 'main.jsp';
</script>
<body>
</body>
</html>