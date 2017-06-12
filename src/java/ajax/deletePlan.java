/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ajax;

import connect.DBConnect;
import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.sql.Connection;
import java.sql.PreparedStatement;
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
@WebServlet(urlPatterns = {"/deletePlan"})
public class deletePlan extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/plain");
        int id = Integer.parseInt(req.getParameter("id"));
        Connection conn;
        try {
            conn = DBConnect.getConnection();
            String sql = "DELETE FROM plan WHERE id = ?";
            PreparedStatement ps = conn.prepareCall(sql);
            ps.setLong(1, id);
            ps.executeUpdate();
            PrintWriter out = resp.getWriter();
            out.println(id);

        } catch (SQLException ex) {
            Logger.getLogger(deletePlan.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

}
