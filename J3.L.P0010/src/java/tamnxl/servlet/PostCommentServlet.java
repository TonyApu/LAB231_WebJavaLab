/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tamnxl.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Map;
import javax.naming.NamingException;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import tamnxl.comment.CommentDAO;

/**
 *
 * @author TamNXL
 */
@WebServlet(name = "PostCommentServlet", urlPatterns = {"/PostCommentServlet"})
public class PostCommentServlet extends HttpServlet {

    private final String VIEW_POST_DETAIL_CONTROLLER = "viewPostDetail";
    private final String LOGIN_PAGE = "try";
    static final Logger LOGGER = Logger.getLogger(PostCommentServlet.class);

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        ServletContext context = request.getServletContext();
        Map<String, String> siteMap = (Map<String, String>) context.getAttribute("SITE_MAP");
        String email = request.getParameter("txtEmail");
        String postId = request.getParameter("txtPostId");
        String content = request.getParameter("txtComment");
        HttpSession session = request.getSession();
        String user_email = (String) session.getAttribute("EMAIL");
        String url = siteMap.get(VIEW_POST_DETAIL_CONTROLLER);
        try {
            if (user_email != null || content.length() == 0) {
                CommentDAO commentDAO = new CommentDAO();
                boolean result = commentDAO.addComment(email, Integer.parseInt(postId), content);
                if (result) {
                    url = VIEW_POST_DETAIL_CONTROLLER + "?&txtPostId=" + postId;
                }
            } else {
                url = siteMap.get(LOGIN_PAGE);
            }

        } catch (SQLException ex) {
            LOGGER.error("PostCommentServlet - SQL " + ex.getMessage());
        } catch (NamingException ex) {
            LOGGER.error("PostCommentServlet - Naming " + ex.getMessage());
        } finally {
            response.sendRedirect(url);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
