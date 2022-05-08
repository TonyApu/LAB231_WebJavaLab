/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tamnxl.comment;

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
public class CommentDAO implements Serializable {

    public int countComment(int postId) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int count = 0;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT COUNT(comment_id) FROM Comment WHERE post_id = ? AND comment_status = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, postId);
                stm.setString(2, "Active");
                rs = stm.executeQuery();
                if (rs.next()) {
                    count = rs.getInt(1);
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
        return count;
    }

    public boolean checkYourComment(int commentId, String email) 
            throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT comment_id FROM Comment WHERE comment_id = ? AND email = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, commentId);
                stm.setString(2, email);
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
    
    public boolean addComment(String email, int postId, String content) throws SQLException, NamingException {
        boolean result = false;
        Connection con = null;
        PreparedStatement stm = null;
        Timestamp time = new Timestamp(new Date().getTime());
        try {
            con = DBHelper.makeConnection();
            String sql = "INSERT INTO Comment(email, post_id, content, date_created) VALUES(?,?,?,?)";
            stm = con.prepareStatement(sql);
            stm.setString(1, email);
            stm.setInt(2, postId);
            stm.setString(3, content);
            stm.setTimestamp(4, time);
            int row = stm.executeUpdate();
            if (row > 0) {
                result = true;
            }
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return result;
    }
    
    public ArrayList<CommentDTO> getComment(int postId) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ArrayList<CommentDTO> listComment = new ArrayList<>();
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT comment_id, email, post_id, content, date_created FROM Comment WHERE post_id = ? AND comment_status = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, postId);
                stm.setString(2, "Active");
                rs = stm.executeQuery();
                while (rs.next()) {
                    listComment.add(new CommentDTO(rs.getInt("comment_id"), rs.getString("email"),
                        rs.getInt("post_id"), rs.getString("content"), rs.getTimestamp("date_created")));
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
        return listComment;
    }
    
}
