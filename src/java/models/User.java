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
public class User {

    private long userID;
    private String userName;
    private String userAddress;
    private String userEmail;
    private String userPhone;
    private Byte userSex;
    private String userAge;
    private String userDateJoin;
    private String userAvatar;
    private String userProof;

    public User() {
    }

    public User(long userID, String userName, String userAddress, String userEmail, String userPhone, Byte userSex, String userAge, String userDateJoin, String userAvatar, String userProof) {
        this.userID = userID;
        this.userName = userName;
        this.userAddress = userAddress;
        this.userEmail = userEmail;
        this.userPhone = userPhone;
        this.userSex = userSex;
        this.userAge = userAge;
        this.userDateJoin = userDateJoin;
        this.userAvatar = userAvatar;
        this.userProof = userProof;
    }

    public long getUserID() {
        return userID;
    }

    public void setUserID(long userID) {
        this.userID = userID;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserAddress() {
        return userAddress;
    }

    public void setUserAddress(String userAddress) {
        this.userAddress = userAddress;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }

    public Byte getUserSex() {
        return userSex;
    }

    public void setUserSex(Byte userSex) {
        this.userSex = userSex;
    }

    public String getUserDateJoin() {
        return userDateJoin;
    }

    public void setUserDateJoin(String userDateJoin) {
        this.userDateJoin = userDateJoin;
    }

    public String getUserProof() {
        return userProof;
    }

    public void setUserProof(String userProof) {
        this.userProof = userProof;
    }

    public String getUserAge() {
        return userAge;
    }

    public void setUserAge(String userAge) {
        this.userAge = userAge;
    }

    public String getUserAvatar() {
        return userAvatar;
    }

    public void setUserAvatar(String userAvatar) {
        this.userAvatar = userAvatar;
    }
    
}
