package util;

import java.sql.*;

public class DBUtil {
	public Connection getConnection() throws Exception {
		String driver	= "org.mariadb.jdbc.Driver";
		String dbUrl	= "jdbc:mariadb://localhost:3306/cashbook";
		String dbUser	= "root";
		String dbPw		= "java1234";
		Class.forName(driver); // 외부 드라이브 로딩
		Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPw); // db 연결
		return conn;
	}
}
