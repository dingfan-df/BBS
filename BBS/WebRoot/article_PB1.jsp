<%@page pageEncoding="GBK"%>
<%@page import="com.df.bbs.*,java.util.*,java.sql.*"%>
<% 
    boolean logined=false;
	String adminLogined=(String)session.getAttribute("adminlogined");
	if(adminLogined !=null && adminLogined.trim().equals("true")){
		logined=true;
	}
	out.println(logined);
%>

<%
    
    final int pageSize=2;
   
    String keyWords=request.getParameter("keywords");
    String strPageNo=request.getParameter("pageNo");
    
    int pageNo=1;  //页码数
    int totalPages=0;
    if(strPageNo!=null&&!strPageNo.trim().equals("")){
    	try{
    	  pageNo=Integer.parseInt(strPageNo);
    	 
    	 }catch(NumberFormatException e){
    	 	pageNo=1;
    	 }
    	   
    	
    }
    if(pageNo<=0) pageNo=1;
    
    
    int startPos=(pageNo-1)*pageSize;
	List<Article> articles=new ArrayList<Article>();
	Connection conn=DB.getConn();
	System.out.println(keyWords);
	if(keyWords==null||keyWords.trim().equals("")){
	  Statement stmtCount=DB.createStmt(conn);
	  ResultSet rsCount=DB.executeQuery(stmtCount,"select count(*) from article where pid=0");
	  rsCount.next();
	  int totalRecords=rsCount.getInt(1);
	
	  totalPages=totalRecords % pageSize ==0 ? totalRecords/pageSize :totalRecords / pageSize +1;
	  if(pageNo>totalPages)
	    pageNo=totalPages;
	
	//跟两个参数时，第一个参数确定显示的起始位置，第二个参数确定需要返回的记录条数，需要明确的是0表示从第一条记录开始，1表示从第二条记录开始
	  String sql="select * from article where pid= 0  order by pdate asc limit "+ startPos+","+pageSize;
	  Statement stmt=DB.createStmt(conn);
		ResultSet rs1=DB.executeQuery(stmt, sql);
		
		try{
			while (rs1.next()){
				Article ar=new Article();
				ar.setId(rs1.getInt("id"));
				ar.setPid(rs1.getInt("pid"));
				ar.setRootid(rs1.getInt("rootid"));
				ar.setTitle(rs1.getString("title"));
				ar.setIsleaf(rs1.getInt("isleaf")==0?true:false);
				ar.setPdate(rs1.getTimestamp("pdate"));
				ar.setGrade(0);
				articles.add(ar);
				
			}
		}catch(SQLException e){
		   
		}finally{
			DB.close(rs1);
			DB.close(stmt);
		}
   }else{
   		keyWords=new String(request.getParameter("keywords").getBytes("8859_1"),"GBK");
   		Statement stmtCount=DB.createStmt(conn);
   		ResultSet rsCount=DB.executeQuery(stmtCount,"select count(*) from article where title like '%"+keyWords+"%' or cont like '%"+keyWords+"%'");
	  rsCount.next();
	  int totalRecords=rsCount.getInt(1);
	
	  totalPages=totalRecords % pageSize ==0 ? totalRecords/pageSize :totalRecords / pageSize +1;
	  if(pageNo>totalPages)
	    pageNo=totalPages;
	    
	    //跟两个参数时，第一个参数确定显示的起始位置，第二个参数确定需要返回的记录条数，需要明确的是0表示从第一条记录开始，1表示从第二条记录开始
	  String sql="select * from article where title like '%"+keyWords+"%' or cont like '%"+keyWords+"%'   order by pdate asc limit "+ startPos+","+pageSize;
	  Statement stmt=DB.createStmt(conn);
		ResultSet rs1=DB.executeQuery(stmt, sql);
		
		try{
			while (rs1.next()){
				Article ar=new Article();
				ar.setId(rs1.getInt("id"));
				ar.setPid(rs1.getInt("pid"));
				ar.setRootid(rs1.getInt("rootid"));
				ar.setTitle(rs1.getString("title"));
				ar.setIsleaf(rs1.getInt("isleaf")==0?true:false);
				ar.setPdate(rs1.getTimestamp("pdate"));
				ar.setGrade(0);
				articles.add(ar);
				
			}
		}catch(SQLException e){
		   
		}finally{
			DB.close(rs1);
			DB.close(stmt);
		}
   
   }
	DB.close(conn);

 %>



<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>Java|Java世界_中文论坛|ChinaJavaWorld技术论坛 : Java语言*初级版</title>
<meta http-equiv="content-type" content="text/html; charset=GBK">
<link rel="stylesheet" type="text/css" href="images/style.css" title="Integrated Styles">
<script language="JavaScript" type="text/javascript" src="images/global.js"></script>
<link rel="alternate" type="application/rss+xml" title="RSS" href="http://bbs.chinajavaworld.com/rss/rssmessages.jspa?forumID=20">
<script language="JavaScript" type="text/javascript" src="images/common.js"></script>
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
<div id="jive-forumpage">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr valign="top">
        <td width="98%"><p class="jive-breadcrumbs">论坛: Java语言*初级版
            (模仿)</p>
          <p class="jive-description"> 探讨Java语言基础知识,基本语法等 大家一起交流 共同提高！谢绝任何形式的广告 </p>
          </td>
      </tr>
    </tbody>
  </table>
  <div class="jive-buttons">
    <table summary="Buttons" border="0" cellpadding="0" cellspacing="0">
      <tbody>
        <tr>
          <td class="jive-icon"><a href="post.jsp"><img src="images/post-16x16.gif" alt="发表新主题" border="0" height="16" width="16"></a></td>
          <td class="jive-icon-label"><a id="jive-post-thread" href="post.jsp">发表新主题</a> <a href="http://bbs.chinajavaworld.com/forum.jspa?forumID=20&amp;isBest=1"></a></td>
        </tr>
      </tbody>
    </table>
  </div>
  <br>
  <table border="0" cellpadding="3" cellspacing="0" width="100%">
    <tbody>
      <tr valign="top">
        <td style="width: 272px; "><span class="jive-paginator"> [ <a href="article_PB1.jsp?pageNo=1&keywords=<%=keyWords %> ">首页</a> | <a href="article_PB1.jsp?pageNo=<%=pageNo-1>0?pageNo-1:1 %>&keywords=<%=keyWords %>">上一页</a>  | <a href="article_PB1.jsp?pageNo=<%=pageNo+1>totalPages?totalPages:pageNo+1 %>&keywords=<%=keyWords %>">下一页</a>  | <a href="article_PB1.jsp?pageNo=<%=totalPages %>&keywords=<%=keyWords %>">末页</a> </span>
        </td>
        </tr>
        <tr>
         <td> <form name="form1" action="article_PB1.jsp">
          <select name="pageNo" onchange="document.form1.submit()">
              <%
                for(int i=1;i<=totalPages;i++)
                {
               %>
              <option value=<%=i%> <%=(pageNo == i)? "selected" :"" %>> 第<%=i%>页</option>
              <% 
              }
              %>
              
              </select>
              </form></td>
             <td>
              <form name="form2" action="article_PB1.jsp">
              	<input type="text" size=4 name="pageNo" />
              	<input type="submit" value="go"/>
              
              </form>
            </td>
        </tr>
        <tr>
        	<form name="form3" action="article_PB1.jsp">
        	<input type="text" name="keywords"/>
        	<input type="submit" value="模糊查询"/>
        	</form>
        </tr>
    </tbody>
  </table>
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr valign="top">
        <td width="99%"><div class="jive-thread-list">
            <div class="jive-table">
              <table summary="List of threads" cellpadding="0" cellspacing="0" width="100%">
                <thead>
                  <tr>
                    <th class="jive-first" colspan="3"> 主题 </th>
                    <th class="jive-author"> <nobr> 作者
                      &nbsp; </nobr> </th>
                    <th class="jive-view-count"> <nobr> 浏览
                      &nbsp; </nobr> </th>
                    <th class="jive-msg-count" nowrap="nowrap"> 回复 </th>
                    <th class="jive-last" nowrap="nowrap"> 最新帖子 </th>
                  </tr>
                </thead>
                <tbody>
                  <% 
                    int i=0;
                  	for(Iterator<Article> it=articles.iterator(); it.hasNext();){
                  		Article a=it.next();
                    String classStr=i%2==0?"jive-even":"jive-odd";
                  %>
                  <tr class="<%=classStr %>">
                    <td class="jive-first" nowrap="nowrap" width="1%"><div class="jive-bullet"> <img src="images/read-16x16.gif" alt="已读" border="0" height="16" width="16">
                        <!-- div-->
                      </div></td>
                      <%  if(logined){
                      %>
                    <td nowrap="nowrap" width="1%">
                    	<%
                    	   String url=request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
                    	   url+=request.getContextPath();
                    	   url+=request.getServletPath();
                    	   
                    	   url+="/" +request.getQueryString()==null?"":("?"+request.getQueryString());
                    	   
                    	   System.out.println(url);
                    	   
                    	 %>
                    	 
                    	<a href ="delete.jsp?id=<%=a.getId() %>&url=<%=url%>">DEL</a>
                        
                    </td>
              
                     
                    <td nowrap="nowrap" width="1%">
                    	 
                    	<a href ="update.jsp?id=<%=a.getId() %>&isLeaf=<%=a.getIsleaf()%>&pid=<%=a.getPid() %>&url=<%=url%>">更新</a>
                        
                    </td>
                    <% }
                        %>
                    <td class="jive-thread-name" width="95%"><a id="jive-thread-1" href="article_PBDetail.jsp?id=<%=a.getId() %>"><%=a.getTitle()%></a></td>
                    <td class="jive-author" nowrap="nowrap" width="1%"><span class=""> <a href="http://bbs.chinajavaworld.com/profile.jspa?userID=226030">df</a> </span></td>
                    <td class="jive-view-count" width="1%"> 104</td>
                    <td class="jive-msg-count" width="1%"> 5</td>
                    <td class="jive-last" nowrap="nowrap" width="1%"><div class="jive-last-post"><%=new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(a.getPdate())%> <br>
                        by: <a href="http://bbs.chinajavaworld.com/thread.jspa?messageID=780182#780182" title="jingjiangjun" style="">jingjiangjun &#187;</a> </div></td>
                  </tr>
                 
                </tbody>
                <% i++;
                   }
                %>
                
              </table>
              
               共<%=totalPages %>页  第<%= pageNo %>页 
            </div>
          </div>
          <div class="jive-legend"></div></td>
      </tr>
      
    </tbody>
  </table>
  <br>
  <br>
</div>
</body>
</html>
