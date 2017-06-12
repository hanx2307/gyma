/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import connect.DBConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Plan;
import models.Subscription;

/**
 *
 * @author Jack2307
 */
public class SubscriptionDAO {
    public boolean addSubcription(Subscription subscription) throws SQLException{
        Connection conn = DBConnect.getConnection();
        try {
            String sql = "INSERT INTO subscription VALUES(?,?,?,?,?,?,?,?)";

            PreparedStatement ps = conn.prepareCall(sql);

            ps.setNull(1, java.sql.Types.INTEGER);
            ps.setLong(2, subscription.getUserID());
            ps.setLong(3, subscription.getPlanID());
            ps.setString(4,subscription.getPaidDate());
            ps.setString(5,subscription.getExpiry());
            ps.setLong(6,subscription.getTotal());
            ps.setLong(7,subscription.getPaid());
            ps.setString(8, subscription.getInvoice());
            ps.executeUpdate();

            return true;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return false;
    }
    
    public Subscription getInvoiceFormID(String invoice) throws SQLException {
        Connection conn = DBConnect.getConnection();
        String sql = "SELECT * FROM subscription INNER JOIN plan ON subscription.plan_id = plan.id WHERE invoice = '"+invoice+"' ";

        PreparedStatement ps = conn.prepareCall(sql);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            Subscription sub = new Subscription();
            sub.setInvoice(rs.getString("invoice"));
            sub.setPaidDate(rs.getString("paid_date"));
            sub.setExpiry(rs.getString("expiry"));
            sub.setTotal(rs.getLong("total"));
            sub.setPaid(rs.getLong("paid"));
            
            Plan plan = new Plan();
            plan.setPlanName(rs.getString("plan_day"));
            plan.setPlanRate(rs.getLong("plain_rate"));
            
            return sub;
        }
        return null;
    } 
}
