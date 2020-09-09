<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="user.UserDAO" %>
    <%@ page import="java.io.PrintWriter" %>
	<% request.setCharacterEncoding("UTF-8"); %> <!-- 건너오는 모든데이터를 utf8 받을수있도록 만들어주는거 -->
	<jsp:useBean id="user" class="user.User" scope="page" />
	<jsp:setProperty name="user" property="userID"/> <!-- 로그인페이지에서 넘겨준 유저아이디를 그대로받아서 한명의 사용자에 userID에 넣어주는거-->
	<jsp:setProperty name="user" property="userPassword"/>
<!DOCTYPE html>
<html>
<head> 
<meta http-equiv="Content-Type" content="test/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String userID = null;
	if(session.getAttribute("userID") != null){ //정상적으로 유저아이디의 변수가 자신에게 할당된 세션아이디를 담을수 있도록 만들어 주는거 
		userID = (String) session.getAttribute("userID");
	}
	if(userID != null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인이 되어있습다.')");
		script.println("location.href = 'main.jsp'");
		script.println("</script>");
		
	}
		UserDAO userDAO= new UserDAO();
		int result = userDAO.login(user.getUserID(), user.getUserPassword());
		if (result == 1){
			session.setAttribute("userID",user.getUserID());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href ='main.jsp'");
			script.println("</script>");
			
		}
		else if(result == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else if(result == -2){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생했습니다..')");
			script.println("history.back()");
			script.println("</script>");
		}
		
		%>
</body>
</html>