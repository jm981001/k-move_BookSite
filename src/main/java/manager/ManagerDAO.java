package manager;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.InitialContext;
import javax.sql.DataSource;


public class ManagerDAO {
private static ManagerDAO instance = new ManagerDAO();
	
	public static ManagerDAO getInstance() {
		return instance;
	}
	
	private ManagerDAO() { }
	
	private Connection getConnection() {		
		try {
			InitialContext ic = new InitialContext(); // JNDI 서버 객체 생성 
			DataSource ds = (DataSource)ic.lookup("java:comp/env/jdbc/BookSite"); // connection 객체 찾기
			Connection conn = ds.getConnection(); // connection 객체를 할당 받음
			return conn;
		} catch(Exception e) {
			System.out.println("데이터베이스 연결에 문제가 발생했습니다.");
			return null;
		}	
	}
	
	public int userCheck(String id, String passwd) {
		Connection conn = null;
		PreparedStatement pstmt = null; // query 실행
		ResultSet rs = null;
		int result = -1;
		
		try {
			conn = getConnection();
					
			String sql = "select passwd from manager where id=?";
			pstmt = conn.prepareStatement(sql); //3. sql query를 실행하기 위한 객체 생성하기
			pstmt.setString(1, id);
			rs = pstmt.executeQuery(); //4. sql query 실행
			
			if(rs.next()) {				
				String rpasswd = rs.getString("passwd");
				if(passwd.equals(rpasswd)) {
					result = 1; //인증 성공
				} else {
					result = 0; //패스워드 틀림
				}
			} else {
				result = -1; //해당 아이디 없음
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			//5. 자원 해제
			if(rs != null) try {rs.close();} catch(SQLException se) { }		
			if(pstmt != null) try {pstmt.close();} catch(SQLException se) { }
			if(conn != null) try {conn.close();} catch(SQLException se) { } //연결 해제
		}
		
		return result;
	}
}
