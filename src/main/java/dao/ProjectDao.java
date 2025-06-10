package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import bean.ProjectBean;
import util.DBConnection;

public class ProjectDao {
	public void insertProject(ProjectBean project) {
		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement pstmt = conn.prepareStatement("INSERT INTO PROJECT_MANAGEMENT_PROJECTS(TITLE, DESCRIPTION, ACTIVE) VALUES(?,?,?)");
			pstmt.setString(1, project.getTitle());
			pstmt.setString(2,project.getDescription());
			pstmt.setString(3,project.getActive());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<ProjectBean> listProject(){
		ArrayList<ProjectBean> list = new ArrayList<ProjectBean>();
		
		try {
			Connection conn = DBConnection.getConnection();
			PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM PROJECT_MANAGEMENT_PROJECTS WHERE ACTIVE='True'");
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProjectBean project = new ProjectBean();
				project.setProjectId(rs.getInt("PROJECT_ID"));
				project.setTitle(rs.getString("TITLE"));
				project.setDescription(rs.getString("DESCRIPTION"));
				project.setActive(rs.getString("ACTIVE"));
				
				list.add(project);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
