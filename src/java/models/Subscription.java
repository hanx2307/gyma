/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import java.sql.Date;

/**
 *
 * @author Jack
 */
public class Subscription {
    private long subID;
    private long userID;
    private long planID;
    private String paidDate;
    private String expiry;
    private long total;
    private long paid;
    private String invoice;

    public Subscription() {
    }

    public Subscription(long subID, long userID, long planID, String paidDate, String expiry, long total, long paid, String invoice) {
        this.subID = subID;
        this.userID = userID;
        this.planID = planID;
        this.paidDate = paidDate;
        this.expiry = expiry;
        this.total = total;
        this.paid = paid;
        this.invoice = invoice;
    }


    public long getSubID() {
        return subID;
    }

    public void setSubID(long subID) {
        this.subID = subID;
    }

    public long getUserID() {
        return userID;
    }

    public void setUserID(long userID) {
        this.userID = userID;
    }

    public long getPlanID() {
        return planID;
    }

    public void setPlanID(long planID) {
        this.planID = planID;
    }

    public String getPaidDate() {
        return paidDate;
    }

    public void setPaidDate(String paidDate) {
        this.paidDate = paidDate;
    }

    public String getExpiry() {
        return expiry;
    }

    public void setExpiry(String expiry) {
        this.expiry = expiry;
    }

    public long getTotal() {
        return total;
    }

    public void setTotal(long total) {
        this.total = total;
    }

    public long getPaid() {
        return paid;
    }

    public void setPaid(long paid) {
        this.paid = paid;
    }

    public String getInvoice() {
        return invoice;
    }

    public void setInvoice(String invoice) {
        this.invoice = invoice;
    }
    
    
}
