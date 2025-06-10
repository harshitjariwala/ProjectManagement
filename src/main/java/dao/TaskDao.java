package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import bean.TaskBean;
import util.DBConnection;

public class TaskDao {
	public void insertTask(TaskBean task) {
		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement pstmt = conn.prepareStatement("INSERT INTO PROJECT_MANAGEMENT_TASKS(PROJECT_ID, TASK_DETAIL, ASSIGNED_BY, ASSIGNED_TO, REMARKS, STATUS, ASSIGNED_DATE) VALUES(?,?,?,?,?,'INIT',CURRENT_DATE)");
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
}
