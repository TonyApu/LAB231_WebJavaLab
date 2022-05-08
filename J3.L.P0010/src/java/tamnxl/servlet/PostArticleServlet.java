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
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import tamnxl.post.PostArticleError;
import tamnxl.post.PostDAO;

/**
 *
 * @author TamNXL
 */
@WebServlet(name = "PostArticleServlet", urlPatterns = {"/PostArticleServlet"})
public class PostArticleServlet extends HttpServlet {
    
    private final String POST_PAGE = "postPage";
    private final String LOGIN_PAGE = "try";
    static final Logger LOGGER = Logger.getLogger(PostArticleServlet.class);
    
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
        String title = request.getParameter("txtTitle");
        String shortDesciption = request.getParameter("txtShortDescription");
        String content = request.getParameter("txtContent");
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("EMAIL");
        String url = siteMap.get(POST_PAGE);
        boolean foundErr = false;
        PostArticleError errors = new PostArticleError();
        try {
            if (email != null) {
                if (title.trim().length() < 1 || title.trim().length() > 100) {
                    foundErr = true;
                    errors.setInvalidTitle("Tên bài viết phải từ 1 đến 100 kí tự");
                }
                if (shortDesciption.trim().length() < 1 || shortDesciption.trim().length() > 200) {
                    foundErr = true;
                    errors.setInvalidShortDescripton("Mô tả phải từ 1 đến 200 kí tự");
                }
                if (content.trim().length() < 1 || content.trim().length() > 2000) {
                    foundErr = true;
                    errors.setInvalidShortDescripton("Mô tả phải từ 1 đến 2000 kí tự");
                }
                if (foundErr) {
                    request.setAttribute("ERROR", errors);
                } else {
                    PostDAO postDAO = new PostDAO();
                    boolean result = postDAO.addNewPost(email, title, content, shortDesciption);
                    if (result) {
                        request.setAttribute("SUCCESS", "Bài viết đã được đăng lên hệ thống. Mọi người sẽ nhìn thấy bài viết của bạn khi Admin duyệt xong.");
                    }
                }
            } else {
                url = siteMap.get(LOGIN_PAGE);
            }
        } catch (NamingException ex) {
            LOGGER.error("PostArticleServlet - Naming " + ex.getMessage());
        } catch (SQLException ex) {
            LOGGER.error("PostArticleServlet - SQL " + ex.getMessage());
        } finally {
            RequestDispatcher rd = request.getRequestDispatcher(url);
            rd.forward(request, response);
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
