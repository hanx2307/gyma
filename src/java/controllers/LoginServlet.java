/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import dao.LoginDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.Login;
import tools.MD5;

/**
 *
 * @author Jack
 */
@WebServlet(urlPatterns = {"/loginservlet"})
public class LoginServlet extends HttpServlet {

    LoginDAO loginDAO = new LoginDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String url = "";
        String username = req.getParameter("username");
        String password = MD5.encryption(req.getParameter("password"));
        HttpSession session = req.getSession();
        Login login = new Login();
        try {
            login = loginDAO.checkLogin(username, password);
            if (login != null) {
                session.setAttribute("username", username);
                resp.sendRedirect("index.jsp");
            } else {
                req.setAttribute("error", "Tài khoản hoặc mật khẩu không hợp lệ");
                req.getRequestDispatcher("login.jsp").forward(req,resp);
            }
        } catch (SQLException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
