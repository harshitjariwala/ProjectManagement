package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.spi.DirStateFactory.Result;

import bean.ProjectBean;
import bean.StatusBean;
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
	
public void updateTaskForUser(int taskId, TaskBean task) {
		
		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement pstmt = conn.prepareStatement("UPDATE PROJECT_MANAGEMENT_TASKS SET STATUS = ? WHERE TASK_ID = ?");
			pstmt.setString(1,task.getStatus());
			pstmt.setInt(2, taskId);
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public ArrayList<TaskBean> getTaskByProjectId(int projectId) {
		ArrayList<TaskBean> list = new ArrayList<TaskBean>();
		
		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM PROJECT_MANAGEMENT_TASKS WHERE PROJECT_ID = ?");
			pstmt.setInt(1, projectId);
			
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				TaskBean task = new TaskBean();
				task.setTaskId(rs.getInt("TASK_ID"));
				task.setProjectId(projectId);
				task.setTaskDetail(rs.getString("TASK_DETAIL"));
				task.setAssignedBy(rs.getInt("ASSIGNED_BY"));
				task.setAssignedTo(rs.getInt("ASSIGNED_TO"));
				task.setRemarks(rs.getString("REMARKS"));
				task.setStatus(rs.getString("STATUS"));
				task.setAssignedDate(rs.getString("ASSIGNED_DATE"));
				task.setCompletionDate(rs.getString("COMPLETION_DATE"));
				
				list.add(task);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<StatusBean> countTaskByStatus(){
		ArrayList<StatusBean> list = new ArrayList<StatusBean>();
		
		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement pstmt = conn.prepareStatement("SELECT STATUS, COUNT(*) CNT_TASK FROM PROJECT_MANAGEMENT_TASKS GROUP BY STATUS");
			
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				StatusBean status = new StatusBean();
				status.setStatus(rs.getString("STATUS"));
				status.setNoOfTasks(rs.getInt("CNT_TASK"));
				list.add(status);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
