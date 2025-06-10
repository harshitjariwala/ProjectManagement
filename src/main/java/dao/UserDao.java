package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import bean.UserBean;
import util.DBConnection;

public class UserDao {
	public void insertUser(UserBean user) {
		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement pstmt = conn.prepareStatement("INSERT INTO PROJECT_MANAGEMENT_USERS (FIRST_NAME, LAST_NAME, EMAIL, PASSWORD, ROLE) VALUES (?,?,?,?,?)");
			
			pstmt.setString(1,user.getFirstName());
			pstmt.setString(2,user.getLastName());
			pstmt.setString(3,user.getEmail());
			pstmt.setString(4,user.getPassword());
			pstmt.setString(5,user.getRole());
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
	
	public UserBean checkUniqueEmail(String email) {
		UserBean user = null;
		
		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM PROJECT_MANAGEMENT_USERS WHERE EMAIL = ?");
			pstmt.setString(1, email);
			
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				user = new UserBean();
				user.setUserId(rs.getInt("USER_ID"));
				user.setFirstName(rs.getString("FIRST_NAME"));
				user.setLastName("LAST_NAME");
				user.setEmail(rs.getString("EMAIL"));
				user.setPassword(rs.getString("PASSWORD"));
				user.setRole(rs.getString("ROLE"));
				
				return user;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return user;
	}
	
	public UserBean authenticateUser(String email, String password) {
		UserBean user = null;
		
		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM PROJECT_MANAGEMENT_USERS WHERE EMAIL = ? AND PASSWORD = ?");
			pstmt.setString(1,email);
			pstmt.setString(2, password);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				user = new UserBean();
				user.setUserId(rs.getInt("USER_ID"));
				user.setFirstName(rs.getString("FIRST_NAME"));
				user.setLastName(rs.getString("LAST_NAME"));
				user.setEmail(rs.getString("EMAIL"));
				user.setPassword(rs.getString("PASSWORD"));
				user.setRole(rs.getString("ROLE"));
				
				return user;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return user;
	}
	
	public void updatePassword(int userId, String password) {
		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement pstmt = conn.prepareStatement("UPDATE PROJECT_MANAGEMENT_USERS SET PASSWORD = ? WHERE USER_ID = ?");
			pstmt.setString(1, password);
			pstmt.setInt(2,userId);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<UserBean> listUser(){
		ArrayList<UserBean> list = new ArrayList<UserBean>();
		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM PROJECT_MANAGEMENT_USERS");
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {	
				UserBean user = new UserBean();
				user.setUserId(rs.getInt("USER_ID"));
				user.setFirstName(rs.getString("FIRST_NAME"));
				user.setLastName(rs.getString("LAST_NAME"));
				user.setEmail(rs.getString("EMAIL"));
				user.setPassword(rs.getString("PASSWORD"));
				user.setRole(rs.getString("ROLE"));
				list.add(user);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public UserBean getUserById(int userId) {
		UserBean user = new UserBean();
		
		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM PROJECT_MANAGEMENT_USERS WHERE USER_ID = ?");
			pstmt.setInt(1, userId);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				user.setUserId(rs.getInt("USER_ID"));
				user.setFirstName(rs.getString("FIRST_NAME"));
				user.setLastName(rs.getString("LAST_NAME"));
				user.setEmail(rs.getString("EMAIL"));
				user.setPassword(rs.getString("PASSWORD"));
				user.setRole(rs.getString("ROLE"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return user;
	}
}