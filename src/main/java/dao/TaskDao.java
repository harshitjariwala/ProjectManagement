package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import bean.TaskBean;
import oracle.jdbc.proxy.annotation.Pre;
import util.DBConnection;

public class TaskDao {
	public void insertTask(TaskBean task) {
		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement pstmt = conn.prepareStatement("INSERT INTO PROJECT_MANAGEMENT_TASKS(PROJECT_ID, TASK_DETAIL, ASSIGNED_BY, ASSIGNED_TO, REMARKS, STATUS, ASSIGNED_DATE) VALUES(?,?,?,?,?,'Initialized',CURRENT_DATE)");
			pstmt.setInt(1,task.getProjectId());
			pstmt.setString(2,task.getTaskDetail());
			pstmt.setInt(3,task.getAssignedBy());
			pstmt.setInt(4,task.getAssignedTo());
			pstmt.setString(5,task.getRemarks());
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void deleteTask(int taskId) {
		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement pstmt = conn.prepareStatement("DELETE FROM PROJECT_MANAGEMENT_TASKS WHERE TASK_ID = ?");
			pstmt.setInt(1, taskId);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void updateTask(int taskId, TaskBean task) {
		
		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement pstmt = conn.prepareStatement("UPDATE PROJECT_MANAGEMENT_TASKS SET PROJECT_ID = ?, TASK_DETAIL = ?, ASSIGNED_BY = ?, ASSIGNED_TO = ?, REMARKS = ?, STATUS = ? WHERE TASK_ID = ?");
			pstmt.setInt(1,task.getProjectId());
			pstmt.setString(2, task.getTaskDetail());
			pstmt.setInt(3,task.getAssignedBy());
			pstmt.setInt(4,task.getAssignedTo());
			pstmt.setString(5,task.getRemarks());
			pstmt.setString(6,task.getStatus());
			pstmt.setInt(7, taskId);
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
