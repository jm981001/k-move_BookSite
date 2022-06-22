package book;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BookDAO {

	private static BookDAO instance = new BookDAO();
	
	public static BookDAO getInstance() {
		return instance;
	}
	
	private BookDAO() { }
	
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
	
	public void insertBoard(BookVO article) {		
		Connection conn = null;
		PreparedStatement pstmt = null; // query 실행
		
		try {			
			conn = getConnection();
			
			//insert into book(bnum, bkind, btitle, author, pubcom, pubdate, page, bimage, bcontent)
			//values (book_seq.nextval, '100', '미분적분학:대학수학의 첫걸음', '수학교재편찬위원회', '한빛아카데미', '2021-01-06', 620, '미분적분학.jsp', '이공계 신입생을 위한 미분적분학 맞춤 기본서...');
			String sql = "insert into book(bnum, bkind, btitle, author, pubcom, pubdate, page, bimage, bcontent)";
			sql += "values (book_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql); //3. sql query를 실행하기 위한 객체 생성하기
			pstmt.setString(1, article.getBkind());
			pstmt.setString(2, article.getBtitle());
			pstmt.setString(3, article.getAuthor());
			pstmt.setString(4, article.getPubcom());
			pstmt.setTimestamp(5, article.getPubdate());
			pstmt.setInt(6, article.getPage());
			pstmt.setString(7, article.getBimage());
			pstmt.setString(8, article.getBcontent());
			
			pstmt.executeUpdate(); //4. sql query 실행
			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("book 테이블에 새로운 레코드 추가에 실패했습니다.");
		} finally {
			//5. 자원 해제
			if(pstmt != null) try {pstmt.close();} catch(SQLException se) { }
			if(conn != null) try {conn.close();} catch(SQLException se) { }
		}
	}
	
	public List<BookVO> getArticles(int start, int end) {
		Connection conn = null;
		PreparedStatement pstmt = null; // query 실행
		ResultSet rs = null;
		List<BookVO> articleList = null;
		//System.out.println(start + " - " + end);
		try {			
			conn = getConnection();			
			
			//select b.* 
			//from ( select rownum as rnum, a.*
			//	     from (select * from board order by num desc) a ) b
			//where b.rnum >= 1 and b.rnum <= 10;
			String sql = "select b.*";
			sql += " from ( select rownum as rnum, a.*";
			sql += " from (select * from book order by bnum desc) a ) b";
			sql += " where b.rnum >= ? and b.rnum <= ?";
			pstmt = conn.prepareStatement(sql); //3. sql query를 실행하기 위한 객체 생성하기
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery(); //4. sql query 실행
			
			if(rs.next()) {
				articleList = new ArrayList<BookVO>();
				do {
					BookVO article = new BookVO();
					article.setBnum(rs.getInt("bnum"));
					article.setBkind(rs.getString("bkind"));
					article.setBtitle(rs.getString("btitle"));
					article.setAuthor(rs.getString("author"));
					article.setPubcom(rs.getString("pubcom"));
					article.setPubdate(rs.getTimestamp("pubdate"));
					article.setPage(rs.getInt("page"));
					article.setBimage(rs.getString("bimage"));
					article.setBcontent(rs.getString("bcontent"));
					
					articleList.add(article);
				} while(rs.next());				
			}
			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("book 테이블에 새로운 레코드 추가를 실패했습니다.");
		} finally {
			//5. 자원 해제
			if(rs != null) try {rs.close();} catch(SQLException se) { }
			if(pstmt != null) try {pstmt.close();} catch(SQLException se) { }
			if(conn != null) try {conn.close();} catch(SQLException se) { }
		}
		
		return articleList;
	}
	
	public int getArticleCount() {
		Connection conn = null;
		PreparedStatement pstmt = null; // query 실행
		ResultSet rs = null;
		int result = 0;
		
		try {			
			conn = getConnection();			
			
			String sql = "select count(*) from book";
			pstmt = conn.prepareStatement(sql); //3. sql query를 실행하기 위한 객체 생성하기
			rs = pstmt.executeQuery(); //4. sql query 실행
			
			if(rs.next()) {
				result = rs.getInt(1);				
			} 			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("book 테이블의 레코드 전체수 검색을 실패했습니다.");
		} finally {
			//5. 자원 해제
			if(rs != null) try {rs.close();} catch(SQLException se) { }
			if(pstmt != null) try {pstmt.close();} catch(SQLException se) { }
			if(conn != null) try {conn.close();} catch(SQLException se) { }
		}
		
		return result;
	}
	
	public BookVO getArticle(int num) {
		Connection conn = null;
		PreparedStatement pstmt = null; // query 실행
		ResultSet rs = null;
		BookVO article = null;
		
		try {			
			conn = getConnection();	
			
			String sql = "select * from book where bnum=?";
			pstmt = conn.prepareStatement(sql); //3. sql query를 실행하기 위한 객체 생성하기
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery(); //4. sql query 실행
			
			if(rs.next()) {
				article = new BookVO();
				article.setBnum(rs.getInt("bnum"));
				article.setBkind(rs.getString("bkind"));
				article.setBtitle(rs.getString("btitle"));
				article.setAuthor(rs.getString("author"));
				article.setPubcom(rs.getString("pubcom"));
				article.setPubdate(rs.getTimestamp("pubdate"));
				article.setPage(rs.getInt("page"));
				article.setBimage(rs.getString("bimage"));
				article.setBcontent(rs.getString("bcontent"));			
			}
			
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("book 테이블에 상세보기의 레코드 검색을 실패했습니다.");
		} finally {
			//5. 자원 해제
			if(rs != null) try {rs.close();} catch(SQLException se) { }
			if(pstmt != null) try {pstmt.close();} catch(SQLException se) { }
			if(conn != null) try {conn.close();} catch(SQLException se) { }
		}
		
		return article;
	}	

	public void updateBook(BookVO article) {		
		Connection conn = null;
		PreparedStatement pstmt = null; // query 실행
		ResultSet rs = null;
		
		try {			
			conn = getConnection();
			
			String sql = "update book set bkind=?, btitle=?, author=?, pubcom=?, pubdate=?, page=?, bimage=? , bcontent=? where bnum=?";
			pstmt = conn.prepareStatement(sql); //3. sql query를 실행하기 위한 객체 생성하기
			pstmt.setString(1, article.getBkind());
			pstmt.setString(2, article.getBtitle());
			pstmt.setString(3, article.getAuthor());					
			pstmt.setString(4, article.getPubcom());
			pstmt.setTimestamp(5, article.getPubdate());
			pstmt.setInt(6, article.getPage());
			pstmt.setString(7, article.getBimage());
			pstmt.setString(8, article.getBcontent());
			pstmt.setInt(9, article.getBnum());
			
			pstmt.executeUpdate(); //4. sql query 실행

		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("book 테이블의 글 수정을 실패했습니다.");
		} finally {
			//5. 자원 해제
			if(rs != null) try {rs.close();} catch(SQLException se) { }
			if(pstmt != null) try {pstmt.close();} catch(SQLException se) { }
			if(conn != null) try {conn.close();} catch(SQLException se) { }
		}

	}
	
	public void deleteBook(int num) {		
		Connection conn = null;
		PreparedStatement pstmt = null; // query 실행
		ResultSet rs = null;
		
		try {			
			conn = getConnection();

			String sql = "delete from book where bnum=?";
			pstmt = conn.prepareStatement(sql); //3. sql query를 실행하기 위한 객체 생성하기
			pstmt.setInt(1, num);
			
			pstmt.executeUpdate(); //4. sql query 실행

		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("book 테이블의 글 삭제를 실패했습니다.");
		} finally {
			//5. 자원 해제
			if(rs != null) try {rs.close();} catch(SQLException se) { }
			if(pstmt != null) try {pstmt.close();} catch(SQLException se) { }
			if(conn != null) try {conn.close();} catch(SQLException se) { }
		}

	}
}
