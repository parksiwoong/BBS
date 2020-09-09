package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;



public class UserDAO {
		
	private Connection conn; //데이터베이스에 접근할수있게 해주는 하나의 개체
	private PreparedStatement pstmt;	
	private ResultSet rs;//어떠한정보를 담을수있는 객체
	
	public UserDAO() { //dao를 하나의 객체로 만들었을때 자동으로 데이터베이스 커넥션이 이뤄질수잇도록 해주는거
		try {
//			String dbURL = "jdbc:mysql://localhost:3306/BBS?serverTimezone=Asia/Seoul";						//  
			String dbURL = "jdbc:mysql://localhost:/tldnd8989";
			String dbID = "tldnd8989";
			String dbPassword  = "Qazplm12";
			Class.forName("com.mysql.jdbc.Driver");
//			conn = DriverManager.getConnection("jdbcURL", "root", "admin");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword); //dburl에 디비아이디에 디비페스워드로 접속하게 할수있게 해주는거
		}catch (Exception e) {
			e.printStackTrace();
		}
	}

		public int login(String userID, String userPassword) {
			String SQL = "SELECT userPassword FROM USER WHERE userID = ? "; //해킹기법을 방어하기위한 기법으로서  PreparedStatement pstmt 이용함
			try {
				pstmt = conn.prepareStatement(SQL); //어떤한 정해진 sql 문장을 데이터베이스에 삽입하는 인스턴스
				pstmt.setNString(1, userID);
				rs = pstmt.executeQuery(); //하나의 객체에다가 실행한결과를 넣어줌
				 if(rs.next()) {
					 if(rs.getString(1).equals(userPassword)) {
						 return 1; //로그인 성공
					 }
					 else
						 return 0; //비밀번호 불일치
				 }
				 return -1; //아이디가 없음
			}catch (Exception e) {
				e.printStackTrace();	//예외처리한거 해당예외처리 내용 출력
				
			}
			return -2; //-2는 데이터베이스의 오류
		}
		public int join(User user) {
			String SQL = "INSERT INTO USER VALUES(?,?,?,?,?)";
			try {
				pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, user.getUserID());
				pstmt.setString(2, user.getUserPassword());
				pstmt.setString(3, user.getUserName());
				pstmt.setString(4, user.getUserGender());
				pstmt.setString(5, user.getUserEmail());
				return pstmt.executeUpdate();
			}catch (Exception e) {
				e.printStackTrace();
			}
			return -1; // 데이터베이스 오류
		}
}
