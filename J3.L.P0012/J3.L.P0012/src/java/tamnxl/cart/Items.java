/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tamnxl.cart;

import java.io.Serializable;

/**
 *
 * @author TamNXL
 */
public class Items implements Serializable {
    private String hotelID;
    private String hotelName;
    private String typeID;
    private String typeName;
    private int amount;
    private float price;
    private long totalDay;
    private String checkInDate;
    private String checkOutDate;

    public Items(String hotelID, String hotelName, String typeID, String typeName, int amount, float price, long totalDay, String checkInDate, String checkOutDate) {
        this.hotelID = hotelID;
        this.hotelName = hotelName;
        this.typeID = typeID;
        this.typeName = typeName;
        this.amount = amount;
        this.price = price;
        this.totalDay = totalDay;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
    }

    public String getHotelID() {
        return hotelID;
    }

    public void setHotelID(String hotelID) {
        this.hotelID = hotelID;
    }

    public String getHotelName() {
        return hotelName;
    }

    public void setHotelName(String hotelName) {
        this.hotelName = hotelName;
    }

    public String getTypeID() {
        return typeID;
    }

    public void setTypeID(String typeID) {
        this.typeID = typeID;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public long getTotalDay() {
        return totalDay;
    }

    public void setTotalDay(long totalDay) {
        this.totalDay = totalDay;
    }

    public String getCheckInDate() {
        return checkInDate;
    }

    public void setCheckInDate(String checkInDate) {
        this.checkInDate = checkInDate;
    }

    public String getCheckOutDate() {
        return checkOutDate;
    }

    public void setCheckOutDate(String checkOutDate) {
        this.checkOutDate = checkOutDate;
    }
    
    
}
