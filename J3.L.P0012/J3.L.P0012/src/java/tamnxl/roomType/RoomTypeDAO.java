/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tamnxl.roomType;

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
public class RoomTypeDAO implements Serializable {
    
    public ArrayList<String> getListRoomType() throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ArrayList<String> listRoomType = new ArrayList<>();
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT DISTINCT typeName FROM RoomType";
                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    listRoomType.add(rs.getString("typeName"));
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
        return listRoomType;
    }
    
    public ArrayList<RoomTypeDTO> getListRoomTypeByHotelNameAndType(String hotelName, String typeName)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ArrayList<RoomTypeDTO> listRoomType = new ArrayList<>();
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT typeID, typeName, r.description, price, r.hotelID FROM "
                        + "RoomType r INNER JOIN Hotels h ON r.hotelID = h.hotelID WHERE hotelName like ? and typeName = ? ";
                stm = con.prepareStatement(sql);
                stm.setString(1, "%" + hotelName + "%");
                stm.setString(2, typeName);
                rs = stm.executeQuery();
                while (rs.next()) {
                    listRoomType.add(new RoomTypeDTO(rs.getString("typeID"), rs.getString("typeName"), rs.getString("description"), rs.getFloat("price"), rs.getString("hotelID")));
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
        return listRoomType;
    }
}
