/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tamnxl.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
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
import tamnxl.comment.CommentDAO;
import tamnxl.post.Post;
import tamnxl.post.PostDAO;
import tamnxl.post.PostDTO;
import tamnxl.userInfor.UserInforDAO;

/**
 *
 * @author TamNXL
 */
@WebServlet(name = "ShowPostServlet", urlPatterns = {"/ShowPostServlet"})
public class ShowPostServlet extends HttpServlet {

    private final String SEARCH_PAGE = "searchPage";
    private final String MANAGE_PAGE = "managePage";
    static final Logger LOGGER = Logger.getLogger(ShowPostServlet.class);

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
        String page = request.getParameter("page");
        int numberAllPost;
        int numberOfPage;
        HttpSession session = request.getSession();
        String searchValue = request.getParameter("txtSearchValue");
        String status = request.getParameter("txtStatus");
        ArrayList<Post> listPost = new ArrayList<>();
        String email = (String) session.getAttribute("EMAIL");
        String role = (String) session.getAttribute("ROLE");
        PostDAO postDAO = new PostDAO();
        UserInforDAO userInforDAO = new UserInforDAO();
        CommentDAO commentDAO = new CommentDAO();
        ArrayList<PostDTO> listResult = new ArrayList<>();
        ArrayList<String> listStatus = new ArrayList<>();
        session.setAttribute("CURRENT_PAGE", page);
        String url = siteMap.get(MANAGE_PAGE);
        
        System.out.println(page);
        try {
            if (page == null) {
                page = "1";
            }
            if (role == null) {
                role = "GUEST";
            }

            if (role.equals("Admin")) {
                listStatus.add("");
                listStatus.add("New");
                listStatus.add("Active");
                listStatus.add("Deleted");
                session.setAttribute("LIST_STATUS", listStatus);
                if (searchValue == null & status == null) {
                    listResult = postDAO.getAllPostForAdmin(page);
                    numberAllPost = postDAO.countAllPostForAdmin();
                } else {
                    if (!searchValue.equals("") & status.equals("")) {
                        listResult = postDAO.getSearchPostByContentForAdmin(page, searchValue);
                        numberAllPost = postDAO.countSearchPostForAdmin(searchValue);
                    } else if (searchValue.equals("") & !status.equals("")) {
                        listResult = postDAO.getSearchPostByStatusForAdmin(page, status);
                        numberAllPost = postDAO.countSearchPostForAdmin(searchValue);
                    } else if (!searchValue.equals("") & !status.equals("")) {
                        listResult = postDAO.getSearchPostForAdmin(page, searchValue, status);
                        numberAllPost = postDAO.countSearchPostForAdmin(searchValue);
                    } else {
                        listResult = postDAO.getAllPostForAdmin(page);
                        numberAllPost = postDAO.countAllPostForAdmin();
                    }
                }
            } else {
                url = siteMap.get(SEARCH_PAGE);
                if (searchValue == null) {
                    listResult = postDAO.getAllPost(page);
                    numberAllPost = postDAO.countAllPost();
                } else {
                    if (!searchValue.equals("")) {
                        listResult = postDAO.getSearchPost(page, searchValue);
                        numberAllPost = postDAO.countSearchPost(searchValue);
                    } else {
                        listResult = postDAO.getAllPost(page);
                        numberAllPost = postDAO.countAllPost();
                    }                    
                }
            }
            for (PostDTO postDTO : listResult) {
                String name = userInforDAO.getName(postDTO.getEmail());
                int comment = commentDAO.countComment(postDTO.getPostId());
                boolean isYourPost = postDAO.checkYourPost(postDTO.getPostId(), email);
                listPost.add(new Post(name, postDTO, comment, null, isYourPost));
            }
            session.setAttribute("LIST_POST", listPost);
            session.setAttribute("NUMBER_ALL_POST", numberAllPost);
            double tmp = numberAllPost;
            numberOfPage = (int) Math.ceil(tmp / 10);
            session.setAttribute("NUMBER_OF_PAGE", numberOfPage);

        } catch (NamingException ex) {
            LOGGER.error("ShowPostServlet - Naming " + ex.getMessage());
        } catch (SQLException ex) {
            LOGGER.error("ShowPostServlet - SQL " + ex.getMessage());
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
