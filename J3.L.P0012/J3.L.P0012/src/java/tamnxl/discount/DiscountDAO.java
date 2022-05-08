/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tamnxl.discount;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.NamingException;
import tamnxl.util.DBHelper;

/**
 *
 * @author TamNXL
 */
public class DiscountDAO implements Serializable {
    public void createDiscount(String code, String name, float value, String date)
            throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "INSERT INTO Discounts(discountCode, discountName, discountValue, expiredDate) VALUES(?,?,?,?)";
                stm = con.prepareStatement(sql);
                stm.setString(1, code);
                stm.setString(2, name);
                stm.setFloat(3, value);
                stm.setString(4, date);
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
    
    public float checkDiscountCode(String discountCode) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        float value = 0;
        long millis = System.currentTimeMillis();
        Date date = new Date(millis);
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT discountValue FROM Discounts WHERE discountCode = ? AND expiredDate > ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, discountCode);
                stm.setDate(2, date);
                rs = stm.executeQuery();
                if (rs.next()) {
                    value = rs.getFloat("discountValue");
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
        return value;
    } 
}
