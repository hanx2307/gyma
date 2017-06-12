/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import connect.DBConnect;
import java.sql.Connection;
import static java.sql.JDBCType.NULL;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Plan;
import models.User;

/**
 *
 * @author Jack
 */
public class PlanDAO {

    public ArrayList<Plan> getListPlan() throws SQLException {
        Connection conn = DBConnect.getConnection();
        String sql = "SELECT * FROM plan";

        PreparedStatement ps = conn.prepareCall(sql);
        ResultSet rs = ps.executeQuery();

        ArrayList<Plan> list = new ArrayList<>();
        while (rs.next()) {
            Plan plan = new Plan();
            plan.setPlanID(rs.getLong("id"));
            plan.setPlanDescription(rs.getString("plan_description"));
            plan.setPlanName(rs.getString("plan_name"));
            plan.setPlanDay(rs.getLong("plan_day"));
            plan.setPlanRate(rs.getLong("plan_rate"));
            list.add(plan);
        }
        return list;
    }
    public Plan getListPlanFromID(Long id) throws SQLException {
        Connection conn = DBConnect.getConnection();
        String sql = "SELECT * FROM plan WHERE id = '"+id+"' ";

        PreparedStatement ps = conn.prepareCall(sql);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            Plan plan = new Plan();
            plan.setPlanID(rs.getLong("id"));
            plan.setPlanDescription(rs.getString("plan_description"));
            plan.setPlanName(rs.getString("plan_name"));
            plan.setPlanDay(rs.getLong("plan_day"));
            plan.setPlanRate(rs.getLong("plan_rate"));
            return plan;
        }
        return null;
    }
    
     public Plan getdayPlanFromID(Long id) throws SQLException {
        Connection conn = DBConnect.getConnection();
        String sql = "SELECT plan_day FROM plan WHERE id = '"+id+"' ";

        PreparedStatement ps = conn.prepareCall(sql);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            Plan plan = new Plan();
            plan.setPlanDay(rs.getLong("plan_day"));
            return plan;
        }
        return null;
    }

    public boolean insertPlan(Plan p) throws SQLException {
        Connection conn = DBConnect.getConnection();
        String sql = "INSERT INTO plan VALUES(?,?,?,?,?)";
        try {
            PreparedStatement ps = conn.prepareCall(sql);
            ps.setNull(1,  java.sql.Types.INTEGER);
            ps.setString(2, p.getPlanName());
            ps.setString(3, p.getPlanDescription());
            ps.setLong(4, p.getPlanDay());
            ps.setLong(5, p.getPlanRate());
            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(PlanDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return false;
    }
    public boolean updatePlan(Plan p) throws SQLException {
        Connection conn = DBConnect.getConnection();
        String sql = "UPDATE plan SET plan_name = ? ,plan_description = ?, plan_day = ?, plan_rate = ? WHERE  id = ?";
        try {
            PreparedStatement ps = conn.prepareCall(sql);
            ps.setString(1, p.getPlanName());
            ps.setString(2, p.getPlanDescription());
            ps.setLong(3, p.getPlanDay());
            ps.setLong(4, p.getPlanRate());
            ps.setLong(5, p.getPlanID());

            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(PlanDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return false;
    }

    public static void main(String[] args) throws SQLException {
//        PlanDAO dao = new PlanDAO();
//        dao.insertPlan(new Plan(1,"VIP","Day la Vip",30,150000));
    }
}
