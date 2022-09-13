<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="bbs.BbsDAO" %>
    <%@page import="java.io.PrintWriter" %>
    <%request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty name="Bbs" property="bbsTitle" />
<jsp:setProperty name="Bbs" property="bbsContent" />
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
		if(userID == null){
			PrintWriter script = response.getWriter();
			script.println("<script>alert('로그인을 하세요'); location.href = 'login.jsp';</script>");
		}else{
			if(bbs.getBbsTitle() == null || bbs.getBbsContent() == null){
				PrintWriter script = response.getWriter();
				script.println("<script>alert('입력이 안 된 사항이 있습니다.'); history.back()</script>");
			}else{
				BbsDAO bbsDAO = new BbsDAO();
				int result = bbsDAO.write(bbs.getBbsTitle(), userID, bbs.getBbsContent());
				if(result == -1){
					PrintWriter script = response.getWriter();
					script.println("<script>alert('글쓰기에 실패했습니다.'); history.back()</script>");
				}else{
					PrintWriter script = response.getWriter();
					script.println("<script>location.href='bbs.jsp'</script>");
				}
			}
		}
		
		
		
	%>
</body>
</html>