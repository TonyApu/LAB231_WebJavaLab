/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tamnxl.bookingDetail;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.naming.NamingException;
import tamnxl.util.DBHelper;

/**
 *
 * @author TamNXL
 */
public class BookingDetailDAO implements Serializable {

    public void addBookingDetail(String bookID, String roomID, String checkInDate, String checkOutDate, float price)
            throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "INSERT INTO BookingDetails(bookID, roomID, checkInDate, checkOutDate, price) VALUES(?,?,?,?,?)";
                stm = con.prepareStatement(sql);
                stm.setString(1, bookID);
                stm.setString(2, roomID);
                stm.setString(3, checkInDate);
                stm.setString(4, checkOutDate);
                stm.setFloat(5, price);
                stm.executeUpdate();
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }
    
    public void confirmBookingDetail(String bookID) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBHelper.makeConnection();
            String sql = "UPDATE BookingDetails SET bookingDetailStatus = 'Confirmed' WHERE bookID = ?";
            stm = con.prepareStatement(sql);
            stm.setString(1, bookID);
            stm.executeUpdate();
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }
    
    public ArrayList<BookingDetailDTO> getListBookingDetail(String bookId) 
            throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ArrayList<BookingDetailDTO> listBookingDetail = new ArrayList<>();
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT bookID, roomID, checkInDate, checkOutDate, price, bookingDetailStatus "
                        + "FROM BookingDetails Where bookID = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, bookId);
                rs = stm.executeQuery();
                while (rs.next()) {
                    listBookingDetail.add(new BookingDetailDTO(bookId, rs.getString("roomID"), rs.getString("checkInDate"), rs.getString("checkOutDate"), rs.getFloat("price"), rs.getString("bookingDetailStatus")));
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return listBookingDetail;
    }
}
