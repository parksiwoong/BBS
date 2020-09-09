<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="user.UserDAO" %>
    <%@ page import="java.io.PrintWriter" %>
	<% request.setCharacterEncoding("UTF-8"); %> <!-- 건너오는 모든데이터를 utf8 받을수있도록 만들어주는거 -->
	<jsp:useBean id="user" class="user.User" scope="page" />
	<jsp:setProperty name="user" property="userID"/> <!-- 로그인페이지에서 넘겨준 유저아이디를 그대로받아서 한명의 사용자에 userID에 넣어주는거-->
	<jsp:setProperty name="user" property="userPassword"/>
	<jsp:setProperty name="user" property="userName"/>
	<jsp:setProperty name="user" property="userGender"/>
	<jsp:setProperty name="user" property="userEmail"/>
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
		if(user.getUserID()==null || user.getUserPassword()==null || user.getUserName()==null
		||user.getUserGender()==null||user.getUserEmail()==null){
			
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다..')");
				script.println("history.back()");
				script.println("</script>");
			
		}		else
		{UserDAO userDAO= new UserDAO();
			int result = userDAO.join(user);
			if (result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 존재하는 아이디입니다.')");
			script.println("history.back()");
			script.println("</script>");
			
		}
			else {
			session.setAttribute("userID",user.getUserID());
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href='main.jsp'");
			script.println("</script>");
		}
			
		}
		
		
		%>
</body>
</html>