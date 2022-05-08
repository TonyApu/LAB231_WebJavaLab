/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tamnxl.post;

import java.io.Serializable;

/**
 *
 * @author TamNXL
 */
public class PostArticleError implements Serializable {
    private String invalidTitle;
    private String invalidShortDescripton;
    private String invalidContent;

    public String getInvalidTitle() {
        return invalidTitle;
    }

    public void setInvalidTitle(String invalidTitle) {
        this.invalidTitle = invalidTitle;
    }

    public String getInvalidShortDescripton() {
        return invalidShortDescripton;
    }

    public void setInvalidShortDescripton(String invalidShortDescripton) {
        this.invalidShortDescripton = invalidShortDescripton;
    }

    public String getInvalidContent() {
        return invalidContent;
    }

    public void setInvalidContent(String invalidContent) {
        this.invalidContent = invalidContent;
    }
    
}
