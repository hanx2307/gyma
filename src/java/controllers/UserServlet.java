/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import com.mysql.jdbc.StringUtils;
import dao.PlanDAO;
import dao.SubscriptionDAO;
import dao.UserDAO;
import java.io.IOException;
import static java.lang.System.currentTimeMillis;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import static javafx.util.Duration.millis;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.Plan;
import models.Subscription;
import models.User;

/**
 *
 * @author Jack
 */
@WebServlet(urlPatterns = {"/UserServlet"})
public class UserServlet extends HttpServlet {

    UserDAO userDAO = new UserDAO();
    SubscriptionDAO subDAO = new SubscriptionDAO();
    PlanDAO planDAO = new PlanDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("add-user.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            resp.setContentType("text/html;charset=UTF-8");
            req.setCharacterEncoding("utf-8");
            String action = req.getParameter("action");
            String url = "";

            // Xử lí thành viên
            // Lay thanh vien moi nhat
            User user = userDAO.getLastID();
            long userID = user.getUserID() + 1;
            String userName = req.getParameter("userName");
            String userEmail = req.getParameter("userEmail");
            String userAddress = req.getParameter("userAddress");
            String userPhone = req.getParameter("userPhone");
            Byte userSex = Byte.parseByte(req.getParameter("userSex"));
            String userAge = req.getParameter("userAge");
            Date date = new Date(System.currentTimeMillis());
            DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
            String userJoinDate = df.format(date);
            String userAvatar = req.getParameter("userAvatar");
            String userProof = req.getParameter("userProof");
//            if (userAvatar.equals("")) {
//                
//            }

            // Xử lí sub
            long subID = 1;
            long planID = Long.parseLong(req.getParameter("subsciptionPlan"));
            String paidDate = df.format(date);
            // Set day plan
            Plan plan = planDAO.getdayPlanFromID(planID);
            long planDay = plan.getPlanDay();
            // Set expriry
            Calendar c = Calendar.getInstance();
            c.add(Calendar.DAY_OF_YEAR, (int) planDay);
            String expiry = df.format(c.getTime());

            long totalRate = Long.parseLong(req.getParameter("subsciptionTotal"));
            long totalPaid = Long.parseLong(req.getParameter("subsciptionPaid"));
            String invoice = "inv_" + currentTimeMillis();

            Map<String, String> errors = new HashMap<String, String>();
            /* Validate */
            if (userName.equals("")) {
                errors.put("username", "Vui lòng nhập họ tên");
            }
            if (userAddress.equals("")) {
                errors.put("useraddress", "Vui lòng nhập địa chỉ.");
            }
            if (userAge.equals("")) {
                errors.put("userphone", "Vui lòng nhập số điện thoại");
            } else {
                if(userPhone.length() > 11){
                    errors.put("userphone", "Số điện thoại phải nhỏ hơn 11 số");
                }
            }
            if (userAge.equals("")) {
                errors.put("userage", "Vui lòng nhập năm sinh");
            } else {
                if(userAge.length() > 4){
                    errors.put("userage", "Năm sinh không chính xác");
                }
            }
            if (userAvatar.equals("")) {
                errors.put("useravatar", "Vui lòng chụp ảnh đại diện");
            }
            if (errors.isEmpty()) {
                // Them vao database
                try {
                    switch (action) {
                        case "insert":
                            userDAO.addUser(new User(userID, userName, userAddress, userEmail, userPhone, userSex, userAge, userJoinDate, userAvatar, userProof));
                            subDAO.addSubcription(new Subscription(subID, userID, planID, paidDate, expiry, totalRate, totalPaid, invoice));
                            url = "invoice.jsp?id=" + invoice;
                            break;
                    }
                } catch (SQLException ex) {
                    Logger.getLogger(PlanServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                resp.sendRedirect(url);
            } else {
                req.setAttribute("errors", errors);
                req.getRequestDispatcher("add-user.jsp").forward(req, resp);
            }
            /* End validate */
        } catch (SQLException ex) {
            Logger.getLogger(UserServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
