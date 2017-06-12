/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import dao.PlanDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.Plan;

/**
 *
 * @author Jack
 */
@WebServlet(urlPatterns = {"/PlanServlet"})

public class PlanServlet extends HttpServlet {

    PlanDAO planDAO = new PlanDAO();

//    @Override
//    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        req.setCharacterEncoding("utf-8");
//        resp.setCharacterEncoding("utf-8");
//        String action = req.getParameter("action");
//        long planID = Long.parseLong(req.getParameter("id"));
//        String planName = req.getParameter("planName");
//        String planDescription = req.getParameter("planDescription");
//        int planDay = Integer.parseInt(req.getParameter("planDay"));
//        int planRate = Integer.parseInt(req.getParameter("planRate"));
//        String url = "";
//        try {
//            switch (action) {
//                
//            }
//        } catch (SQLException ex) {
//            Logger.getLogger(PlanServlet.class.getName()).log(Level.SEVERE, null, ex);
//        }
//    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");
        resp.setCharacterEncoding("utf-8");
        String url = "";
        String action = req.getParameter("action");
        long planIDOld = Long.parseLong(req.getParameter("planID"));
        int planIDNew = 1;
        String planName = req.getParameter("planName");
        String planDescription = req.getParameter("planDescription");
        long planDay = Long.parseLong(req.getParameter("planDay"));
        long planRate = Long.parseLong(req.getParameter("planRate"));
                
        try {
            switch (action) {
                case "insert":
                    planDAO.insertPlan(new Plan(planIDNew, planName, planDescription, planDay, planRate));
                    url = "add-plan.jsp";
                    req.setAttribute("sussess", "Thêm thành công");
                    break;
                case "edit":
                    planDAO.updatePlan(new Plan(planIDOld, planName, planDescription, planDay, planRate));
                    url = "edit-plan.jsp?id="+planIDOld;
                    req.setAttribute("sussess", "Cập nhật thành công");
                    break;
            }
        } catch (SQLException ex) {
            Logger.getLogger(PlanServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        req.getRequestDispatcher(url).forward(req, resp);
    }
}
