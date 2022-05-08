/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tamnxl.booking;

import java.io.Serializable;

/**
 *
 * @author TamNXL
 */
public class BookingDTO implements Serializable {
    private String bookID;
    private String username;
    private String bookDate;
    private String discountCode;
    private float discountValue;
    private String bookingStatus;

    public BookingDTO(String bookID, String username, String bookDate, String discountCode, float discountValue, String bookingStatus) {
        this.bookID = bookID;
        this.username = username;
        this.bookDate = bookDate;
        this.discountCode = discountCode;
        this.discountValue = discountValue;
        this.bookingStatus = bookingStatus;
    }

    public String getBookID() {
        return bookID;
    }

    public void setBookID(String bookID) {
        this.bookID = bookID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getBookDate() {
        return bookDate;
    }

    public void setBookDate(String bookDate) {
        this.bookDate = bookDate;
    }

    public String getDiscountCode() {
        return discountCode;
    }

    public void setDiscountCode(String discountCode) {
        this.discountCode = discountCode;
    }

    public float getDiscountValue() {
        return discountValue;
    }

    public void setDiscountValue(float discountValue) {
        this.discountValue = discountValue;
    }

    public String getBookingStatus() {
        return bookingStatus;
    }

    public void setBookingStatus(String bookingStatus) {
        this.bookingStatus = bookingStatus;
    }
    
    
}
