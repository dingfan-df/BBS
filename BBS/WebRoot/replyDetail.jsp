<%@ page language="java" import="java.util.*,java.sql.*,com.df.bbs.*" pageEncoding="GB18030"%>
<%
request.setCharacterEncoding("GBK");
int pid=Integer.parseInt(request.getParameter("pid"));
int rootid=Integer.parseInt(request.getParameter("rootId"));
String title=request.getParameter("title");
String cont=request.getParameter("cont");
System.out.println(title);
System.out.println(cont);
Connection conn=DB.getConn();

boolean autoCommit=conn.getAutoCommit();
conn.setAutoCommit(false);

String sql="insert into article values(null,?,?,?,?,now(),?)";
PreparedStatement pstmt=DB.prepareStmt(conn, sql);
pstmt.setInt(1,pid);
pstmt.setInt(2,rootid);
pstmt.setString(3, title);
pstmt.setString(4, cont);
pstmt.setInt(5,0);

Statement stmt=DB.createStmt(conn);
stmt.executeUpdate("update article set isleaf=1 where id =" +pid);

conn.commit();
conn.setAutoCommit(autoCommit);
pstmt.executeUpdate();
DB.close(pstmt);
DB.close(conn);



%>

<script language="JavaScript1.2" type="text/javascript">
<!--
//  Place this in the 'head' section of your page.  

function delayURL(url) {
    var delay=document.getElementById("time").innerHTML;
    if(delay>0){
    	delay--;
    	document.getElementById("time").innerHTML=delay;
    }else{
    	window.top.location.href=url;
    }
    
    setTimeout("delayURL('"+url+"')",1000);
}

//-->

</script>
<span id="time" style="background:red">10</span>秒钟后自动跳转，如果不跳转，请点击下面链接
<!-- Place this in the 'body' section -->
<a href="article.jsp">主题列表</a>
<script type="text/javascript">
   delayURL("article.jsp");
</script>
