/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tamnxl.servlet;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Date;
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
import tamnxl.cake.CakeDAO;
import tamnxl.cake.CreateAndUpdateCakeError;
import tamnxl.user.UserDTO;
import tamnxl.util.FileHelper;

/**
 *
 * @author TamNXL
 */
@WebServlet(name = "CreateCakeServlet", urlPatterns = {"/CreateCakeServlet"})
public class CreateCakeServlet extends HttpServlet {

    private final String CHOOSE_IMAGE_CONTROLLER = "chooseImage";
    private final String CREATE_CAKE_PAGE = "create";
    private final String LOGIN_PAGE = "try";
    static final Logger LOGGER = Logger.getLogger(CreateCakeServlet.class);

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
        try (PrintWriter out = response.getWriter()) {
            String name = request.getParameter("txtName");
            String description = request.getParameter("txtDescription");
            String price = request.getParameter("txtPrice");
            String quantity = request.getParameter("txtQuantity");
            String date = request.getParameter("txtExpirationDate");
            String categoryId = request.getParameter("txtCategoryId");
            String image = request.getParameter("txtImage");
            String btnChoose = request.getParameter("btnChoose");
            String btnCreate = request.getParameter("btnCreate");
            ServletContext context = request.getServletContext();
            Map<String, String> siteMap = (Map<String, String>) context.getAttribute("SITE_MAP");
            String url = siteMap.get(CREATE_CAKE_PAGE);
            HttpSession session = request.getSession();
            UserDTO user = (UserDTO) session.getAttribute("user");
            try {
                if (user == null) {
                    url = siteMap.get(LOGIN_PAGE);
                } else {
                    if (user.getRoleId().equals("Cus")) {
                        url = siteMap.get(LOGIN_PAGE);
                    } else {
                        Timestamp expirationDate = new Timestamp(new Date().getTime());
                        if (btnChoose != null) {
                            url = siteMap.get(CHOOSE_IMAGE_CONTROLLER);
                        }
                        if (btnCreate != null) {
                            CreateAndUpdateCakeError error = new CreateAndUpdateCakeError();
                            boolean foundErr = false;
                            if (name.trim().length() == 0) {
                                foundErr = true;
                                error.setEmptyName("Tên không thể bỏ trống");
                            }
                            
                            if (description.trim().length() == 0) {
                                foundErr = true;
                                error.setEmptyDescription("Mô tả không thể bỏ trống");
                            }
                            
                            if (price.trim().length() == 0) {
                                foundErr = true;
                                error.setEmptyPrice("Giá không thể bỏ trống");
                            }
                            
                            if (quantity.trim().length() == 0) {
                                foundErr = true;
                                error.setEmptyQuantity("Số lượng không thể bỏ trống");
                            }
                            
                            if (image.trim().length() == 0) {
                                foundErr = true;
                                error.setEmptyImage("Hình ảnh không thể bỏ trống");
                            } else if (!image.contains(".png") && !image.contains(".jpg") && !image.contains(".img")) {
                                foundErr = true;
                                error.setInvalidImage("Ảnh không hợp lệ");
                            }
                            
                            if (date.trim().length() == 0) {
                                foundErr = true;
                                error.setEmptyExpirationDate("HSD không thể bỏ trống");
                            } else {
                                expirationDate = Timestamp.valueOf(date + " 00:00:00");
                                if (expirationDate.compareTo(new Timestamp(new Date().getTime())) <= 0) {
                                    error.setInvalidExpirationDate("HSD không hợp lệ");
                                }
                            }
                            
                            if (foundErr) {
                                request.setAttribute("error", error);
                            } else {
                                File source = new File(image);
                                String fileName = source.getName();
                                
                                //lưu ảnh trong thư mục chứa project tại máy.
                                File dest = new File("D:\\CN8\\LAB231\\J3.L.P0011\\web\\images\\" + fileName);
                                
                                FileHelper.copyFileUsingStream(source, dest);
                                
                                image = "images\\" + fileName;
                                CakeDAO cakeDAO = new CakeDAO();
                                cakeDAO.createCake(name, description, Integer.parseInt(price), Integer.parseInt(quantity), expirationDate, Integer.parseInt(categoryId), image);
                                request.setAttribute("success", true);
                            }
                        }
                    }
                }
            } catch (SQLException ex) {
                LOGGER.error("CreateCakeServlet - SQL " + ex.getMessage());
            } catch (NamingException ex) {
                LOGGER.error("CreateCakeServlet - Naming " + ex.getMessage());
            } finally {
                RequestDispatcher rd = request.getRequestDispatcher(url);
                rd.forward(request, response);
            }
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
