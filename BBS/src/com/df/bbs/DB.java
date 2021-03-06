package com.df.bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DB {
	public static Connection getConn(){
		Connection conn=null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection("jdbc:mysql://localhost:3306/bbs", "root", "df0502");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return conn;
	}
	public static Statement createStmt(Connection conn){
		Statement stmt=null;
		try {
			stmt=conn.createStatement();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return stmt;
	}
	public static ResultSet executeQuery(Statement stmt,String sql){
		
		ResultSet rs=null;
		try {
			rs=stmt.executeQuery(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}
	public static int executeUpdate(Statement stmt,String sql){
		int num=0;
		try {
			num=stmt.executeUpdate(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return num;
	}
      public static void execute(Statement stmt,String sql){
		
	    try {
			if(stmt.execute(sql)){
				System.out.print("�ɹ�");
			}else{
				System.out.print("ʧ��");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
      
      public  static PreparedStatement prepareStmt(Connection conn,String sql){
    	 
    	  PreparedStatement pstmt =null;
    	  try {
			pstmt=conn.prepareStatement(sql);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	  return pstmt;
      }
      
      
      public  static PreparedStatement prepareStmt(Connection conn,String sql,int autoGeneratedkeys){
     	 
    	  PreparedStatement pstmt =null;
    	  try {
			pstmt=conn.prepareStatement(sql,autoGeneratedkeys);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	  return pstmt;
      }
      
	
	
	public static void close(Connection conn){
		if(conn !=null){
			try {
				conn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			conn=null;
		}
	}
	
	public static void close(Statement stmt){
		if(stmt !=null){
			try {
				stmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			stmt=null;
		}
	}
	
	public static void close(ResultSet rs){
		if(rs !=null){
			try {
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			rs=null;
		}
	}
}
