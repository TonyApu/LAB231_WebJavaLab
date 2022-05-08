/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tamnxl.post;

import java.io.Serializable;
import java.util.ArrayList;
import tamnxl.comment.Comment;

/**
 *
 * @author TamNXL
 */
public class Post implements Serializable {
    
    private String name;
    private PostDTO postDTO;
    private int comment;
    private ArrayList<Comment> commentList;
    private boolean isYourPost;

    public Post(String name, PostDTO postDTO, int comment, ArrayList<Comment> commentList, boolean isYourPost) {
        this.name = name;
        this.postDTO = postDTO;
        this.comment = comment;
        this.commentList = commentList;
        this.isYourPost = isYourPost;
    }
    
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public PostDTO getPostDTO() {
        return postDTO;
    }

    public void setPostDTO(PostDTO postDTO) {
        this.postDTO = postDTO;
    }

    public int getComment() {
        return comment;
    }

    public void setComment(int comment) {
        this.comment = comment;
    }

    public ArrayList<Comment> getCommentList() {
        return commentList;
    }

    public void setCommentList(ArrayList<Comment> commentList) {
        this.commentList = commentList;
    }

    public boolean isIsYourPost() {
        return isYourPost;
    }

    public void setIsYourPost(boolean isYourPost) {
        this.isYourPost = isYourPost;
    }
    
    
}
