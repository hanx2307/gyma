/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ajax;

import static com.sun.org.apache.bcel.internal.classfile.Utility.printArray;
import connect.DBConnect;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Jack
 */
@WebServlet(urlPatterns = {"/getPricePlan"})
public class getPricePlan extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json");
        String id = req.getParameter("id");

        Connection conn;
        try {
            conn = DBConnect.getConnection();
            String sql = "SELECT plan_rate FROM plan WHERE id = '" + id + "'";

            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String result = rs.getString("plan_rate");
                PrintWriter out = resp.getWriter();
                out.print(result);
            }

        } catch (SQLException ex) {
            Logger.getLogger(getPricePlan.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

}
