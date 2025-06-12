
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import bean.JoinBean;
import bean.TaskBean;
import bean.UserBean;
import util.DBConnection;

public class JoinDao {
	public ArrayList<JoinBean> listTaskByProjectId(int projectId){
		ArrayList<JoinBean> list = new ArrayList<>();
		
		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement pstmt = conn.prepareStatement("SELECT TASK_ID, TASK_DETAIL, ASB.FIRST_NAME ASB_FIRST_NAME, ASB.LAST_NAME ASB_LAST_NAME, AST.FIRST_NAME AST_FIRST_NAME, AST.LAST_NAME AST_LAST_NAME, REMARKS, STATUS, ASSIGNED_DATE, COMPLETION_DATE, PR.TITLE "
					+ "FROM PROJECT_MANAGEMENT_TASKS TS "
					+ "JOIN PROJECT_MANAGEMENT_USERS ASB ON ASSIGNED_BY = ASB.USER_ID "
					+ "JOIN PROJECT_MANAGEMENT_USERS AST ON ASSIGNED_TO = AST.USER_ID "
					+ "JOIN PROJECT_MANAGEMENT_PROJECTS PR ON TS.PROJECT_ID = PR.PROJECT_ID "
					+ "WHERE TS.PROJECT_ID = ? ORDER BY TASK_ID");
			pstmt.setInt(1, projectId);
			
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				JoinBean join = new JoinBean();
				join.setTaskId(rs.getInt("TASK_ID"));
				join.setProjectId(projectId);
				join.setTaskDetail(rs.getString("TASK_DETAIL"));
				join.setAssignedByFirstName(rs.getString("ASB_FIRST_NAME"));
				join.setAssignedByLastName(rs.getString("ASB_LAST_NAME"));
				join.setAssignedToFirstName(rs.getString("AST_FIRST_NAME"));
				join.setAssignedToLastName(rs.getString("AST_LAST_NAME"));
				join.setStatus(rs.getString("STATUS"));
				join.setRemarks(rs.getString("REMARKS"));
				join.setAssignedDate(rs.getString("ASSIGNED_DATE"));
				join.setCompletionDate(rs.getString("COMPLETION_DATE"));
				join.setTitle(rs.getString("TITLE"));
			
				list.add(join);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public JoinBean getTaskById(int taskId) {
		JoinBean join = new JoinBean();
		
		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement pstmt = conn.prepareStatement("SELECT PR.PROJECT_ID PROJECT_ID, TASK_ID, TASK_DETAIL, ASB.FIRST_NAME ASB_FIRST_NAME, ASB.LAST_NAME ASB_LAST_NAME, AST.FIRST_NAME AST_FIRST_NAME, AST.LAST_NAME AST_LAST_NAME, REMARKS, STATUS, ASSIGNED_DATE, COMPLETION_DATE, PR.TITLE "
					+ "FROM PROJECT_MANAGEMENT_TASKS TS "
					+ "JOIN PROJECT_MANAGEMENT_USERS ASB ON ASSIGNED_BY = ASB.USER_ID "
					+ "JOIN PROJECT_MANAGEMENT_USERS AST ON ASSIGNED_TO = AST.USER_ID "
					+ "JOIN PROJECT_MANAGEMENT_PROJECTS PR ON TS.PROJECT_ID = PR.PROJECT_ID "
					+ "WHERE TASK_ID = ?");
			
			pstmt.setInt(1, taskId);
			
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				join.setTaskId(rs.getInt("TASK_ID"));
				join.setProjectId(rs.getInt("PROJECT_ID"));
				join.setTaskDetail(rs.getString("TASK_DETAIL"));
				join.setAssignedByFirstName(rs.getString("ASB_FIRST_NAME"));
				join.setAssignedByLastName(rs.getString("ASB_LAST_NAME"));
				join.setAssignedToFirstName(rs.getString("AST_FIRST_NAME"));
				join.setAssignedToLastName(rs.getString("AST_LAST_NAME"));
				join.setStatus(rs.getString("STATUS"));
				join.setRemarks(rs.getString("REMARKS"));
				join.setAssignedDate(rs.getString("ASSIGNED_DATE"));
				join.setCompletionDate(rs.getString("COMPLETION_DATE"));
				join.setTitle(rs.getString("TITLE"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return join;
	}
	
	public ArrayList<JoinBean> listTaskByProjectIdForUser(int projectId, UserBean user){
		ArrayList<JoinBean> list = new ArrayList<>();
		
		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement pstmt = conn.prepareStatement("SELECT TASK_ID, TASK_DETAIL, ASB.FIRST_NAME ASB_FIRST_NAME, ASB.LAST_NAME ASB_LAST_NAME, AST.FIRST_NAME AST_FIRST_NAME, AST.LAST_NAME AST_LAST_NAME, REMARKS, STATUS, ASSIGNED_DATE, COMPLETION_DATE, PR.TITLE "
					+ "FROM PROJECT_MANAGEMENT_TASKS TS "
					+ "JOIN PROJECT_MANAGEMENT_USERS ASB ON ASSIGNED_BY = ASB.USER_ID "
					+ "JOIN PROJECT_MANAGEMENT_USERS AST ON ASSIGNED_TO = AST.USER_ID "
					+ "JOIN PROJECT_MANAGEMENT_PROJECTS PR ON TS.PROJECT_ID = PR.PROJECT_ID "
					+ "WHERE TS.PROJECT_ID = ? AND (CONCAT(ASB.FIRST_NAME, ASB.LAST_NAME) = ? OR CONCAT(AST.FIRST_NAME, AST.LAST_NAME) = ?) ORDER BY TASK_ID");
			pstmt.setInt(1, projectId);
			pstmt.setString(2, user.getFirstName().concat(user.getLastName()));
			pstmt.setString(3, user.getFirstName().concat(user.getLastName()));
			
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				JoinBean join = new JoinBean();
				join.setTaskId(rs.getInt("TASK_ID"));
				join.setProjectId(projectId);
				join.setTaskDetail(rs.getString("TASK_DETAIL"));
				join.setAssignedByFirstName(rs.getString("ASB_FIRST_NAME"));
				join.setAssignedByLastName(rs.getString("ASB_LAST_NAME"));
				join.setAssignedToFirstName(rs.getString("AST_FIRST_NAME"));
				join.setAssignedToLastName(rs.getString("AST_LAST_NAME"));
				join.setStatus(rs.getString("STATUS"));
				join.setRemarks(rs.getString("REMARKS"));
				join.setAssignedDate(rs.getString("ASSIGNED_DATE"));
				join.setCompletionDate(rs.getString("COMPLETION_DATE"));
				join.setTitle(rs.getString("TITLE"));
			
				list.add(join);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
