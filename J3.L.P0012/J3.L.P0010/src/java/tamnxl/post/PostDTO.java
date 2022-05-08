/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tamnxl.post;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Timestamp;

/**
 *
 * @author TamNXL
 */
public class PostDTO implements Serializable {
    private int postId;
    private String title;
    private String content;
    private String email;
    private String status;
    private Timestamp dateCreated;
    private Date dateUpdated;
    private String shortDescription;

    public PostDTO(int postId, String title, String content, String email, String status, Timestamp dateCreated, String shortDescription) {
        this.postId = postId;
        this.title = title;
        this.content = content;
        this.email = email;
        this.status = status;
        this.dateCreated = dateCreated;
        this.shortDescription = shortDescription;
    }

    public int getPostId() {
        return postId;
    }

    public void setPostId(int postId) {
        this.postId = postId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(Timestamp dateCreated) {
        this.dateCreated = dateCreated;
    }

    public Date getDateUpdated() {
        return dateUpdated;
    }

    public void setDateUpdated(Date dateUpdated) {
        this.dateUpdated = dateUpdated;
    }

    public String getShortDescription() {
        return shortDescription;
    }

    public void setShortDescription(String shortDescription) {
        this.shortDescription = shortDescription;
    }
    
    
}
