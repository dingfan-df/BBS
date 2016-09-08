<%@page pageEncoding="GBK"%>
<%@page import="com.df.bbs.*,java.util.*,java.sql.*"%>

<%@ include file="_sessioncheck.jsp" 
%>

<%  
    request.setCharacterEncoding("GBK");
		String url=request.getParameter("url");
		String title=request.getParameter("title");
		String cont=request.getParameter("cont");
		
		int id=Integer.parseInt(request.getParameter("id"));
		System.out.println("id="+id);
		Connection conn=DB.getConn();
	    Statement stmt=DB.createStmt(conn);
	    String sql="update article set title='" + title + "' ,cont='"+ cont + "' where id="+id;
	    DB.executeUpdate(stmt, sql);
	    DB.close(stmt);
	    DB.close(conn);	
	  	response.sendRedirect(url);
%>



