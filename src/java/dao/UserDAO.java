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
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Subscription;
import models.User;

/**
 *
 * @author Jack
 */
public class UserDAO {

    public ArrayList<User> getListUser() throws SQLException {
        Connection conn = DBConnect.getConnection();
        String sql = "SELECT * FROM user ORDER BY id DESC";

        PreparedStatement ps = conn.prepareCall(sql);
        ResultSet rs = ps.executeQuery();

        ArrayList<User> list = new ArrayList<>();
        while (rs.next()) {
            User user = new User();
            user.setUserID(rs.getLong("id"));
            user.setUserName(rs.getString("name"));
            user.setUserAddress(rs.getString("address"));
            user.setUserEmail(rs.getString("email"));
            user.setUserPhone(rs.getString("phone"));
            user.setUserSex(rs.getByte("sex"));
            user.setUserAge(rs.getString("age"));
            user.setUserDateJoin(rs.getString("date_join"));
            user.setUserAvatar(rs.getString("avatar"));
            user.setUserProof(rs.getString("proof"));
            list.add(user);
        }
        return list;

    }

    public boolean addUser(User user) throws SQLException {
        Connection conn = DBConnect.getConnection();
        try {
            String sql = "INSERT INTO user VALUES(?,?,?,?,?,?,?,?,?,?)";
            PreparedStatement ps = conn.prepareCall(sql);
            ps.setLong(1, user.getUserID());
            ps.setString(2, user.getUserName());
            ps.setString(3, user.getUserAddress());
            ps.setString(4, user.getUserEmail());
            ps.setString(5, user.getUserPhone());
            ps.setByte(6, user.getUserSex());
            ps.setString(7, user.getUserAge());
            ps.setString(8, user.getUserDateJoin());
            ps.setString(9, user.getUserAvatar());
            ps.setString(10, user.getUserProof());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return false;
    }
    public User getLastID() throws SQLException {
        Connection conn = DBConnect.getConnection();
        try {
            String sql = "SELECT id FROM user ORDER BY id DESC LIMIT 1";

            PreparedStatement ps = conn.prepareCall(sql);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                User user = new User();
                user.setUserID(rs.getLong("id"));
                return user;
            }          
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return null;
    }
    public boolean updateUser(User user) throws SQLException {
        Connection conn = DBConnect.getConnection();
        String sql = "UPDATE user SET name = ? ,address = ?, email = ?, phone = ?, sex = ?, age = ?, date_join = ?, avatar = ?, proof = ? WHERE  id = ?";
        try {
            PreparedStatement ps = conn.prepareCall(sql);
            ps.setString(1, user.getUserName());
            ps.setString(2, user.getUserAddress());
            ps.setString(3, user.getUserEmail());
            ps.setString(4, user.getUserPhone());
            ps.setByte(5, user.getUserSex());
            ps.setString(6, user.getUserAge());
            ps.setString(7, user.getUserDateJoin());
            ps.setString(8, user.getUserAvatar());
            ps.setString(9, user.getUserProof());
            ps.setLong(10, user.getUserID());

            return ps.executeUpdate() == 1;
        } catch (SQLException ex) {
            Logger.getLogger(PlanDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return false;
    }
    public User getListPlanFromID(Long id) throws SQLException {
        Connection conn = DBConnect.getConnection();
        String sql = "SELECT * FROM user WHERE id = '"+id+"' ";

        PreparedStatement ps = conn.prepareCall(sql);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            User user = new User();
            user.setUserID(rs.getLong("id"));
            user.setUserName(rs.getString("name"));
            user.setUserAddress(rs.getString("address"));
            user.setUserEmail(rs.getString("email"));
            user.setUserPhone(rs.getString("phone"));
            user.setUserSex(rs.getByte("sex"));
            user.setUserAge(rs.getString("age"));
            user.setUserDateJoin(rs.getString("date_join"));
            user.setUserAvatar(rs.getString("avatar"));
            user.setUserProof(rs.getString("proof"));
            return user;
        }
        return null;
    }
}
