/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tamnxl.order;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import javax.naming.NamingException;
import tamnxl.util.DBHelper;

/**
 *
 * @author TamNXL
 */
public class OrderDAO implements Serializable {

    public boolean checkExistOrderId(String orderId) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT order_id FROM OrderCake WHERE order_id = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, orderId);
                rs = stm.executeQuery();
                if (rs.next()) {
                    return true;
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
        return false;
    }

    public boolean addOrder(String orderId, String username, String fullName, String phone, String address, int total) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        Timestamp time = new Timestamp(new Date().getTime());
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "INSERT INTO OrderCake(order_id, username, full_name, phone, address, total, order_date) VALUES(?,?,?,?,?,?,?)";
                stm = con.prepareStatement(sql);
                stm.setString(1, orderId);
                stm.setString(2, username);
                stm.setString(3, fullName);
                stm.setString(4, phone);
                stm.setString(5, address);
                stm.setInt(6, total);
                stm.setTimestamp(7, time);
                int row = stm.executeUpdate();
                if (row > 0) {
                    return true;
                }
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return false;
    }

    public OrderDTO getOrder(String orderId, String username) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        OrderDTO orderDTO = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT order_id, username, full_name, phone, address, total, order_date, order_status FROM OrderCake WHERE order_id = ? AND username = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, orderId);
                stm.setString(2, username);
                rs = stm.executeQuery();
                if (rs.next()) {
                    orderDTO = new OrderDTO(rs.getString("order_id"), rs.getString("username"), rs.getString("full_name"), rs.getString("phone"), rs.getString("address"),
                            rs.getInt("total"), rs.getTimestamp("order_date"), rs.getString("order_status"));
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
        return orderDTO;
    }

    public ArrayList<OrderDTO> getListOrder(String username) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ArrayList<OrderDTO> listOrder = new ArrayList<>();
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT order_id, username, full_name, phone, address, total, order_date, order_status FROM OrderCake WHERE username = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, username);
                rs = stm.executeQuery();
                while (rs.next()) {
                    listOrder.add(new OrderDTO(rs.getString("order_id"), rs.getString("username"), rs.getString("full_name"), rs.getString("phone"), rs.getString("address"),
                            rs.getInt("total"), rs.getTimestamp("order_date"), rs.getString("order_status")));
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
        return listOrder;
    }
}
