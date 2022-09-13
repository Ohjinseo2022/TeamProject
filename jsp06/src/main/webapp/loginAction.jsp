<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="user.UserDAO" %>
    <%@page import="java.io.PrintWriter" %>
    <%request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		String userID= null;
		if(session.getAttribute("UserID")!=null){
			userID = (String)session.getAttribute("UserID");
		}
		if(userID !=null){
			PrintWriter script = response.getWriter();
			script.println("<script>alert('이미 로그인 되어있습니다.'); location.href = 'main.jsp';</script>");
		}
		UserDAO userDAO = new UserDAO();
		int result = userDAO.login(user.getUserID(), user.getUserPassword());
		if(result == 1){
			session.setAttribute("UserID", user.getUserID());
			PrintWriter script = response.getWriter();
			script.println("<script>alert('로그인성공'); location.href = 'main.jsp'</script>");
			System.out.print(session.getAttribute("UserID"));
		}else if(result == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>alert('비밀번호가 틀립니다.'); history.back()</script>");
		}else if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>alert('아이디가 존재하지 않습니다.'); history.back();</script>");
		}else if(result == -2){
			PrintWriter script = response.getWriter();
			script.println("<script>alert('데이터베이스 오류가 발생했습니다.'); history.back();</script>");
		}
	%>
</body>
</html>