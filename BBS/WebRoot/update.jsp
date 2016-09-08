<%@page pageEncoding="GBK" import="java.sql.*,java.util.*,com.df.bbs.*"%>


<% 
	
	String strId=request.getParameter("id");
	String url=request.getParameter("url");
	if(strId!=null&&strId.trim().equals("")){
		out.println("Error Id");
		return;
	}
	int id=0;
	try{
		id=Integer.parseInt(strId);
	}catch(NumberFormatException e){
		out.println("Error Id");
		return;
	}
	System.out.println("跳转页面"+id);
	Connection conn=DB.getConn();
	Statement stmt=DB.createStmt(conn);
	String sql="select title,cont from article where id="+id;
	ResultSet rs=DB.executeQuery(stmt, sql);
	Article a=new Article();
	try{
	  while(rs.next()){
		a.setTitle(rs.getString("title"));
		a.setCont(rs.getString("cont"));
   	 }
   	}catch(Exception e){
   	}
   	DB.close(rs);
   	DB.close(stmt);
   	DB.close(conn);
   	

 %>

 

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>Java|Java世界_中文论坛|ChinaJavaWorld技术论坛 : 初学java遇一难题！！望大家能帮忙一下 ...</title>
<meta http-equiv="content-type" content="text/html; charset=GBK">
<link rel="stylesheet" type="text/css" href="images/style.css" title="Integrated Styles">
<script language="JavaScript" type="text/javascript" src="images/global.js"></script>


	
<link rel="alternate" type="application/rss+xml" title="RSS" href="http://bbs.chinajavaworld.com/rss/rssmessages.jspa?threadID=744236">
</head>
<body>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td width="140"><a href="http://bbs.chinajavaworld.com/index.jspa"><img src="images/header-left.gif" alt="Java|Java世界_中文论坛|ChinaJavaWorld技术论坛" border="0"></a></td>
      <td><img src="images/header-stretch.gif" alt="" border="0" height="57" width="100%"></td>
      <td width="1%"><img src="images/header-right.gif" alt="" border="0"></td>
    </tr>
  </tbody>
</table>
<br>
<div id="jive-flatpage">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr valign="top">
        <td width="99%"><p class="jive-breadcrumbs"> <a href="http://bbs.chinajavaworld.com/index.jspa">首页</a> &#187; <a href="http://bbs.chinajavaworld.com/forumindex.jspa?categoryID=1">ChinaJavaWorld技术论坛|Java世界_中文论坛</a> &#187; <a href="http://bbs.chinajavaworld.com/category.jspa?categoryID=2">Java 2 Platform, Standard Edition (J2SE)</a> &#187; <a href="http://bbs.chinajavaworld.com/forum.jspa?forumID=20&amp;start=0">Java语言*初级版</a> </p>
         </td>
        <td width="1%"><div class="jive-accountbox"></div></td>
      </tr>
    </tbody>
  </table>
 
  <br>
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr valign="top">
        <td width="99%"><div id="jive-message-holder">
            <div class="jive-message-list">
              <div class="jive-table">
                <div class="jive-messagebox">
                  <form action="update_post.jsp" method="post">
                  	<input type="hidden" name="id" value="<%=id %>"/>
                  	<input type="hidden" name="url" value="<%=url %>"/>
                  	标题：<input type="text" name="title"  value="<%=a.getTitle() %>"/><br>
                  	内容：<textarea rows="15" cols="80" name="cont" ><%=a.getCont() %></textarea><br>
                  	<input type="submit"  name="提交" value="提交"/>
                  </form>
                </div>
              </div>
            </div>
           
          </div></td>
        <td width="1%"></td>
      </tr>
    </tbody>
  </table>
</div>
</body>
</html>

