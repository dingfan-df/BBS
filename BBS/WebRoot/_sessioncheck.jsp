
<%
	String adminLogined=(String)session.getAttribute("adminlogined");
	if(adminLogined ==null || !adminLogined.trim().equals("true")){
		response.sendRedirect("login.jsp");	
		return;
	}
	
%>