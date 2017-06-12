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
import models.Login;

/**
 *
 * @author Jack
 */
public class LoginDAO {
    public Login checkLogin(String username, String password) throws SQLException {
        Connection conn = DBConnect.getConnection();
        String sql = "SELECT * FROM admin WHERE username ='"+username+"' AND password ='"+password+"' ";
        
        PreparedStatement ps = conn.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        
        if(rs.next()){
            Login login = new Login();
            login.setUsername(rs.getString("username"));
            login.setPassword(rs.getString("password"));
            login.setName(rs.getString("name"));
            login.setLock_screen_password(rs.getString("look_screen_password"));
            conn.close();
            return login;
        }
        
        return null;   
    }
    
}
