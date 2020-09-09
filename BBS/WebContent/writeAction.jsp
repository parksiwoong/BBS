<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="bbs.BbsDAO" %>
    <%@ page import="java.io.PrintWriter" %>
	<% request.setCharacterEncoding("UTF-8"); %> <!-- 건너오는 모든데이터를 utf8 받을수있도록 만들어주는거 -->
	<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
	<jsp:setProperty name="bbs" property="bbsTitle"/> <!-- 로그인페이지에서 넘겨준 유저아이디를 그대로받아서 한명의 사용자에 userID에 넣어주는거-->
	<jsp:setProperty name="bbs" property="bbsContent"/>

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
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
		
	}else{
		if(bbs.getBbsTitle()==null || bbs.getBbsContent() ==null){
		
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다..')");
		script.println("history.back()");
		script.println("</script>");
	
}		else{
	BbsDAO bbsDAO = new BbsDAO();
	int result = bbsDAO.write(bbs.getBbsTitle() , userID, bbs.getBbsContent());
	if (result == -1){
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('글쓰기에 실패했습니다.')");
	script.println("history.back()");
	script.println("</script>");
	
}
	else {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("location.href='bbs.jsp'");
	script.println("</script>");
}
	}
		
		}
		
		
		%>
</body>
</html>