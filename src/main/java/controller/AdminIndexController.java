package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import bean.JoinBean;
import bean.ProjectBean;
import dao.JoinDao;
import dao.ProjectDao;

/**
 * AdminIndexController is responsible for fetching all projects and 
 * their associated tasks to display on the admin dashboard.
 */
@WebServlet("/AdminIndexController")
public class AdminIndexController extends HttpServlet {

    /**
     * Handles GET requests to load project list and corresponding task list.
     * Retrieves project data and tasks associated with each project,
     * then forwards the data to AdminIndex.jsp for rendering.
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Fetch all projects from the database
        ProjectDao projectDao = new ProjectDao();
        ArrayList<ProjectBean> projectList = projectDao.listProject();

        // Prepare list of task lists (grouped by project)
        JoinDao joinDao = new JoinDao();
        ArrayList<ArrayList<JoinBean>> taskListsByProject = new ArrayList<>();

        // For each project, fetch its corresponding tasks
        for (ProjectBean project : projectList) {
            taskListsByProject.add(joinDao.listTaskByProjectId(project.getProjectId()));
        }

        // Set project and task data as request attributes
        request.setAttribute("projectList", projectList);
        request.setAttribute("joinList", taskListsByProject);

        // Forward the request to admin dashboard JSP
        request.getRequestDispatcher("AdminIndex.jsp").forward(request, response);
    }
}
