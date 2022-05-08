/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tamnxl.userInfor;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.naming.NamingException;
import tamnxl.util.DBHelper;

/**
 *
 * @author TamNXL
 */
public class UserInforDAO implements Serializable {

    private UserInforDTO dto;

    public UserInforDTO getDto() {
        return dto;
    }

    public void setDto(UserInforDTO dto) {
        this.dto = dto;
    }

    public boolean checkLogin(String email, String passwordEncoded)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select email, password, full_name, user_role, user_status "
                        + "from UserInfor where "
                        + "email = ? and password = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, email);
                stm.setString(2, passwordEncoded);
                rs = stm.executeQuery();
                if (rs.next()) {
                    String fullName = rs.getString("full_name");
                    String role = rs.getString("user_role");
                    this.dto = new UserInforDTO(email, role, fullName, role, "Active");
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

    public boolean createAccount(String email, String passwordEncoded, String fullName)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Insert into UserInfor(email, password, full_name) "
                        + "Values (?, ?, ?) ";
                stm = con.prepareStatement(sql);
                stm.setString(1, email);
                stm.setString(2, passwordEncoded);
                stm.setString(3, fullName);
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
    
    public String getName(String email) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String name = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select full_name "
                        + "from UserInfor where "
                        + "email = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, email);

                rs = stm.executeQuery();
                if (rs.next()) {
                    name = rs.getString("full_name");

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
        return name;
    }
    
    public boolean checkNewAccount(String email) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT email, user_status FROM UserInfor WHERE email=? AND user_status = 'New'";
                stm = con.prepareStatement(sql);
                stm.setString(1, email);
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
    
    public boolean activeAccount(String email) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "UPDATE UserInfor SET user_status = 'Active' WHERE email = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, email);
                int row = stm.executeUpdate();
                if (row > 0) {
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
}
