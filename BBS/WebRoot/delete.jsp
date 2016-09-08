<%@page pageEncoding="GBK"%>
<%@page import="com.df.bbs.*,java.util.*,java.sql.*"%>

<%@ include file="_sessioncheck.jsp"

 %>

<% 
	String url=request.getParameter("url");
	System.out.println(url);
	String  strId=request.getParameter("id");
	Boolean isLeaf=Boolean.parseBoolean(request.getParameter("isLeaf"));
	int pid=Integer.parseInt(request.getParameter("pid"));
    Connection conn=null;
	boolean autoCommit=true;
 	Statement stmt=null;
 	ResultSet rs=null;
  try{	
	if(strId==null||strId.trim().equals("")){
		out.println("Error Id");
		return;
	}
	int id;
	try{
		id=Integer.parseInt(strId);
	}catch(NumberFormatException e){
		out.println("Error Id");
		return;
	}
    conn=DB.getConn();
    autoCommit=conn.getAutoCommit();
	conn.setAutoCommit(false); 
	
	delete(conn,id,isLeaf);
    stmt=DB.createStmt(conn);
    String sql="select count(*) from article where pid="+pid;
    rs=DB.executeQuery(stmt, sql);
    rs.next();
    if(rs.getInt(1)==0){
      Statement stmt1=DB.createStmt(conn);
      DB.executeUpdate(stmt, "update article set isleaf =0 where id="+pid);
      DB.close(stmt1);
     
    }
    
    conn.commit();
   
  }finally{  
   conn.setAutoCommit(autoCommit);
    DB.close(rs);
    DB.close(stmt);
    DB.close(conn);
  }
  
  response.sendRedirect(url);
%>
<%!
	private void delete(Connection conn,int id,Boolean isLeaf){
		//delete all the children
		//delete(conn,child's id)
		//delete self
		if(!isLeaf){
			String sql="select * from article where pid="+id;
			Statement stmt=DB.createStmt(conn);
			ResultSet rs=DB.executeQuery(stmt, sql);
			try{
			 while(rs.next()){
				delete(conn,rs.getInt("id"),rs.getInt("isLeaf")==0);
			 }
			}catch(SQLException e){
				e.printStackTrace();
			}finally{
				DB.close(rs);
				DB.close(stmt);
			}
		}
		
		   Statement stmt1=DB.createStmt(conn);
		   DB.executeUpdate(stmt1, "delete from article where id="+id);
	       DB.close(stmt1);
	
	}
%>

