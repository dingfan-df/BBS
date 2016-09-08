<%@page pageEncoding="GBK"%>
<%@page import="java.sql.*,java.util.*,com.df.bbs.*,java.util.Date" %>

<%
	String path=request.getContextPath();
	String strId=request.getParameter("id");
	int id=Integer.parseInt(strId);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>回复</title>
</head>

<body>
<div align="center">
 <form action="<%=path%>/servlet/AddServlet?id=<%=id %>" name="form1" method="post">
  <table width="412" height="159" border="1">
    <tr>
      <td width="75" height="40">title</td>
      <td width="321"><input name="title" type="text" maxlength="30" /></td>
    </tr>
    <tr>
      <td>cont</td>
      <td><textarea name="cont" cols="50" rows="10"></textarea></td>
    </tr>
    <tr>
      <td style="text-align:center" colspan="2"><input name="submit" type="submit" value="提交" /></td>
    </tr>
  </table>
 </form>
</div>
</body>
</html>
