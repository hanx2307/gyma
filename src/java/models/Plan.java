/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package models;

import java.sql.JDBCType;

/**
 *
 * @author Jack
 */
public class Plan {
    private long planID;
    private String planName;
    private String planDescription;
    private long planDay;
    private long planRate;

    public Plan() {
    }

    public Plan(long planID, String planName, String planDescription, long planDay, long planRate) {
        this.planID = planID;
        this.planName = planName;
        this.planDescription = planDescription;
        this.planDay = planDay;
        this.planRate = planRate;
    }

    public long getPlanID() {
        return planID;
    }

    public void setPlanID(long planID) {
        this.planID = planID;
    }

    public String getPlanName() {
        return planName;
    }

    public void setPlanName(String planName) {
        this.planName = planName;
    }

    public String getPlanDescription() {
        return planDescription;
    }

    public void setPlanDescription(String planDescription) {
        this.planDescription = planDescription;
    }

    public long getPlanDay() {
        return planDay;
    }

    public void setPlanDay(long planDay) {
        this.planDay = planDay;
    }

    public long getPlanRate() {
        return planRate;
    }

    public void setPlanRate(long planRate) {
        this.planRate = planRate;
    }
    
    
}
