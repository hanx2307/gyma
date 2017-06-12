/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import dao.UserDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.User;

/**
 *
 * @author Jack2307
 */
@WebServlet(urlPatterns = {"/UpdateUserServlet"})
public class UpdateUserServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        req.setCharacterEncoding("utf-8");
        String url = "";
        
        long userID = Long.parseLong(req.getParameter("userID"));
        String userName = req.getParameter("userName");
        String userEmail = req.getParameter("userEmail");
        String userAddress = req.getParameter("userAddress");
        String userPhone = req.getParameter("userPhone");
        Byte userSex = Byte.parseByte(req.getParameter("userSex"));
        String userAge = req.getParameter("userAge");
        String userJoinDate = req.getParameter("userDateJoin");
        String userAvatar = req.getParameter("userAvatar");
        String userProof = req.getParameter("userProof");
        
        UserDAO userDAO = new UserDAO();
        try {
            userDAO.updateUser(new User(userID, userName, userAddress, userEmail, userPhone, userSex, userAge, userJoinDate, userAvatar, userProof));
            req.setAttribute("success", "Cập nhật thành công");
            url = "edit-user.jsp?id="+userID;
        } catch (SQLException ex) {
            Logger.getLogger(UpdateUserServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        req.getRequestDispatcher(url).forward(req, resp);
    }

}
