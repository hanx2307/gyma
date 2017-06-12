/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package connect;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author Jack
 */
public class DBConnect {
    
    public static Connection getConnection() throws SQLException {
        final String url = "jdbc:mysql://localhost:3306/gyma?characterEncoding=UTF-8";
        final String user = "root";
        final String pass = "root";
        try {
            Class.forName("com.mysql.jdbc.Driver");
            return DriverManager.getConnection(url,user,pass);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
   
    
    
}
