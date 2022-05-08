/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tamnxl.post;

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
public class PostDAO implements Serializable {

    public boolean addNewPost(String email, String title, String content, String shortDescription)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        Timestamp time = new Timestamp(new Date().getTime());
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Insert into Post(email, title, content, date_created, short_description) values(?,?,?,?,?)";
                stm = con.prepareStatement(sql);
                stm.setString(1, email);
                stm.setString(2, title);
                stm.setString(3, content);
                stm.setTimestamp(4, time);
                stm.setString(5, shortDescription);
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

    public int countAllPost() throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int numberPost = 0;
        try {
            con = DBHelper.makeConnection();
            String sql = "Select count(post_id) from Post where post_status = ?";
            if (con != null) {
                stm = con.prepareStatement(sql);
                stm.setString(1, "Active");
                rs = stm.executeQuery();
                if (rs.next()) {
                    numberPost = rs.getInt(1);
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
        return numberPost;
    }
    
    public int countAllPostForAdmin() throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int numberPost = 0;
        try {
            con = DBHelper.makeConnection();
            String sql = "Select count(post_id) from Post";
            if (con != null) {
                stm = con.prepareStatement(sql);
                rs = stm.executeQuery();
                if (rs.next()) {
                    numberPost = rs.getInt(1);
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
        return numberPost;
    }

    public int countSearchPost(String searchValue) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int numberPost = 0;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select count(post_id) from Post where post_status = ? and content like ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, "Active");
                stm.setString(2, "%" + searchValue + "%");
                rs = stm.executeQuery();
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
        return numberPost;
    }
    
    public int countSearchPostForAdmin(String searchValue) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        int numberPost = 0;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select count(post_id) from Post where content like ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, "%" + searchValue + "%");
                rs = stm.executeQuery();
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
        return numberPost;
    }

    public ArrayList<PostDTO> getAllPost(String pageNumber)
            throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ArrayList<PostDTO> listPost = new ArrayList<>();
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select post_id, title, content, email, post_status, date_created, short_description FROM "
                        + "(select ROW_NUMBER() OVER (ORDER BY date_created DESC) as rowNum, post_id, title, content, email, post_status, date_created, short_description "
                        + "FROM Post WHERE post_status = ?) AS RowConstrainedResult "
                        + "WHERE rowNum > ? AND rowNum <= ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, "Active");
                stm.setInt(2, 10 * ((Integer.parseInt(pageNumber)) - 1));
                stm.setInt(3, 10 * (Integer.parseInt(pageNumber)));
                rs = stm.executeQuery();
                while (rs.next()) {
                    listPost.add(new PostDTO(rs.getInt("post_id"), rs.getString("title"),
                            rs.getString("content"), rs.getString("email"), rs.getString("post_status"), rs.getTimestamp("date_created"), rs.getString("short_description")));
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
        return listPost;
    }
    
    public ArrayList<PostDTO> getAllPostForAdmin(String pageNumber)
            throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ArrayList<PostDTO> listPost = new ArrayList<>();
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select post_id, title, content, email, post_status, date_created, short_description FROM "
                        + "(select ROW_NUMBER() OVER (ORDER BY date_created DESC) as rowNum, post_id, title, content, email, post_status, date_created, short_description "
                        + "FROM Post) AS RowConstrainedResult "
                        + "WHERE rowNum > ? AND rowNum <= ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, 10 * ((Integer.parseInt(pageNumber)) - 1));
                stm.setInt(2, 10 * (Integer.parseInt(pageNumber)));
                rs = stm.executeQuery();
                while (rs.next()) {
                    listPost.add(new PostDTO(rs.getInt("post_id"), rs.getString("title"),
                            rs.getString("content"), rs.getString("email"), rs.getString("post_status"), rs.getTimestamp("date_created"), rs.getString("short_description")));
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
        return listPost;
    }

    public ArrayList<PostDTO> getSearchPost(String pageNumber, String searchValue)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ArrayList<PostDTO> listPost = new ArrayList<>();
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select post_id, title, content, email, post_status, date_created, short_description from "
                        + "(select ROW_NUMBER() OVER (ORDER BY date_created DESC) as rowNum, post_id, title, content, email, post_status, date_created, short_description "
                        + "FROM Post WHERE post_status = ? and content like ?) AS RowConstrainedResult "
                        + "WHERE rowNum >= ? AND rowNum <= ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, "Active");
                stm.setString(2, "%" + searchValue + "%");
                stm.setInt(3, 10 * ((Integer.parseInt(pageNumber)) - 1));
                stm.setInt(4, 10 * (Integer.parseInt(pageNumber)));
                rs = stm.executeQuery();
                while (rs.next()) {
                    listPost.add(new PostDTO(rs.getInt("post_id"), rs.getString("title"),
                            rs.getString("content"), rs.getString("email"), rs.getString("post_status"), rs.getTimestamp("date_created"), rs.getString("short_description")));
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
        return listPost;
    }
    
    public ArrayList<PostDTO> getSearchPostByContentForAdmin(String pageNumber, String searchValue)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ArrayList<PostDTO> listPost = new ArrayList<>();
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select post_id, title, content, email, post_status, date_created, short_description from "
                        + "(select ROW_NUMBER() OVER (ORDER BY date_created DESC) as rowNum, post_id, title, content, email, post_status, date_created, short_description "
                        + "FROM Post WHERE content like ?) AS RowConstrainedResult "
                        + "WHERE rowNum >= ? AND rowNum <= ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, "%" + searchValue + "%");
                stm.setInt(2, 10 * ((Integer.parseInt(pageNumber)) - 1));
                stm.setInt(3, 10 * (Integer.parseInt(pageNumber)));
                rs = stm.executeQuery();
                while (rs.next()) {
                    listPost.add(new PostDTO(rs.getInt("post_id"), rs.getString("title"),
                            rs.getString("content"), rs.getString("email"), rs.getString("post_status"), rs.getTimestamp("date_created"), rs.getString("short_description")));
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
        return listPost;
    }
    
    public ArrayList<PostDTO> getSearchPostByStatusForAdmin(String pageNumber, String status)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ArrayList<PostDTO> listPost = new ArrayList<>();
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select post_id, title, content, email, post_status, date_created, short_description from "
                        + "(select ROW_NUMBER() OVER (ORDER BY date_created DESC) as rowNum, post_id, title, content, email, post_status, date_created, short_description "
                        + "FROM Post WHERE post_status = ?) AS RowConstrainedResult "
                        + "WHERE rowNum >= ? AND rowNum <= ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, status);
                stm.setInt(2, 10 * ((Integer.parseInt(pageNumber)) - 1));
                stm.setInt(3, 10 * (Integer.parseInt(pageNumber)));
                rs = stm.executeQuery();
                while (rs.next()) {
                    listPost.add(new PostDTO(rs.getInt("post_id"), rs.getString("title"),
                            rs.getString("content"), rs.getString("email"), rs.getString("post_status"), rs.getTimestamp("date_created"), rs.getString("short_description")));
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
        return listPost;
    }
    
    public ArrayList<PostDTO> getSearchPostForAdmin(String pageNumber, String searchValue, String status)
            throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        ArrayList<PostDTO> listPost = new ArrayList<>();
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "Select post_id, title, content, email, post_status, date_created, short_description from "
                        + "(select ROW_NUMBER() OVER (ORDER BY date_created DESC) as rowNum, post_id, title, content, email, post_status, date_created, short_description "
                        + "FROM Post WHERE content like ? AND post_status = ?) AS RowConstrainedResult "
                        + "WHERE rowNum >= ? AND rowNum <= ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, "%" + searchValue + "%");
                stm.setString(2, status);
                stm.setInt(3, 10 * ((Integer.parseInt(pageNumber)) - 1));
                stm.setInt(4, 10 * (Integer.parseInt(pageNumber)));
                rs = stm.executeQuery();
                while (rs.next()) {
                    listPost.add(new PostDTO(rs.getInt("post_id"), rs.getString("title"),
                            rs.getString("content"), rs.getString("email"), rs.getString("post_status"), rs.getTimestamp("date_created"), rs.getString("short_description")));
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
        return listPost;
    }

    public boolean checkYourPost(int postId, String email)
            throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "SELECT post_id FROM Post WHERE post_id = ? AND email = ?";
                stm = con.prepareStatement(sql);
                stm.setInt(1, postId);
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

    public boolean deletePost(int postId) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "UPDATE Post SET post_status = ? WHERE post_id = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, "Deleted");
                stm.setInt(2, postId);
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
    
    public boolean activePost(int postId) throws NamingException, SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBHelper.makeConnection();
            if (con != null) {
                String sql = "UPDATE Post SET post_status = ? WHERE post_id = ?";
                stm = con.prepareStatement(sql);
                stm.setString(1, "Active");
                stm.setInt(2, postId);
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

    public PostDTO getPost(int postId) throws SQLException, NamingException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        PostDTO postDTO = null;
        try {
            con = DBHelper.makeConnection();
            String sql = "SELECT post_id, title, content, email, post_status, date_created, short_description FROM Post WHERE post_id = ?";
            stm = con.prepareStatement(sql);
            stm.setInt(1, postId);
            rs = stm.executeQuery();
            if (rs.next()) {
                postDTO = new PostDTO(postId, rs.getString("title"), rs.getString("content"), rs.getString("email"), rs.getString("post_status"), rs.getTimestamp("date_created"), rs.getString("short_description"));
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
        return postDTO;

    }

}
