package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
	public static Connection getConnection() {
		String DRIVERNAME = "oracle.jdbc.driver.OracleDriver";
		String URL = "jdbc:oracle:thin:@localhost:1521:XE";
		String USERNAME = "SCOTT";
		String PASSWORD = "TIGER";
		
		try {
			Class.forName(DRIVERNAME);
			Connection conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
			return conn;
		} catch (Exception e) {
		
		}
		return null;
	}
}