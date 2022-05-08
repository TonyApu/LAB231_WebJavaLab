/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tamnxl.bookingDetail;

import java.io.Serializable;

/**
 *
 * @author TamNXL
 */
public class BookingDetailDTO implements Serializable {
    private String bookID;
    private String roomID;
    private String checkInDate;
    private String checkOutDate;
    private float price;
    private String bookingDetailStatus;

    public BookingDetailDTO(String bookID, String roomID, String checkInDate, String checkOutDate, float price, String bookingDetailStatus) {
        this.bookID = bookID;
        this.roomID = roomID;
        this.checkInDate = checkInDate;
        this.checkOutDate = checkOutDate;
        this.price = price;
        this.bookingDetailStatus = bookingDetailStatus;
    }

    public String getBookID() {
        return bookID;
    }

    public void setBookID(String bookID) {
        this.bookID = bookID;
    }

    public String getRoomID() {
        return roomID;
    }

    public void setRoomID(String roomID) {
        this.roomID = roomID;
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

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public String getBookingDetailStatus() {
        return bookingDetailStatus;
    }

    public void setBookingDetailStatus(String bookingDetailStatus) {
        this.bookingDetailStatus = bookingDetailStatus;
    }
    
    
}
