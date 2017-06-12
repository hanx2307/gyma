/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

/**
 *
 * @author Jack
 */
public class Login {
    private String username;
    private String password;
    private String name;
    private String lock_screen_password;

    public Login() {
    }

    public Login(String username, String password, String name, String lock_screen_password ) {
        this.username = username;
        this.password = password;
        this.name = name;
        this.lock_screen_password = lock_screen_password;
        
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLock_screen_password() {
        return lock_screen_password;
    }

    public void setLock_screen_password(String lock_screen_password) {
        this.lock_screen_password = lock_screen_password;
    }
    
    
}
