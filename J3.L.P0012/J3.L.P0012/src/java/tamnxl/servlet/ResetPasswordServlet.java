/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tamnxl.servlet;

import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.Map;
import javax.mail.MessagingException;
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
import tamnxl.userInfor.UserInforDAO;
import tamnxl.userInfor.UserInforDTO;
import tamnxl.util.EmailHelper;
import tamnxl.util.Encryption;

/**
 *
 * @author TamNXL
 */
@WebServlet(name = "ResetPasswordServlet", urlPatterns = {"/ResetPasswordServlet"})
public class ResetPasswordServlet extends HttpServlet {
    private final String RESET_PAGE = "resetPage";
    static final Logger LOGGER = Logger.getLogger(ResetPasswordServlet.class);
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
        String url = siteMap.get(RESET_PAGE);
        String password = request.getParameter("txtPassword");
        String newPassword  = request.getParameter("txtNewPassword");
        String confirm = request.getParameter("txtConfirm");
        HttpSession session = request.getSession();
        UserInforDTO user = (UserInforDTO) session.getAttribute("user");
        try {
            Encryption encryption = new Encryption();
            String passwordEncoded = encryption.encode(password);
            boolean foundErr = false;
            if (user != null) {
                if (!passwordEncoded.equals(user.getPassword())) {
                    request.setAttribute("invalidPassword", "Sai mật khẩu!");
                    foundErr = true;
                }
                if (newPassword.trim().length() < 6 || newPassword.trim().length() > 30) {
                    request.setAttribute("invalidNewPassword", "Mật khẩu mới phải từ 6 đến 30 kí tự!");
                    foundErr = true;
                } else if (!newPassword.equals(confirm)) {
                    request.setAttribute("invalidConfirm", "Xác nhận phải giống mật khẩu mới!");
                    foundErr = true;
                }
                if (!foundErr) {
                    String newPasswordEncoded = encryption.encode(newPassword);
                    UserInforDAO userInforDAO = new UserInforDAO();
                    userInforDAO.saveNewPassword(user.getUsername(), newPasswordEncoded);
                    EmailHelper emailHelper = new EmailHelper(user.getEmail());
                    emailHelper.sendConfirmResetPasswordMail(user.getUsername(), newPasswordEncoded);
                    request.setAttribute("success", "Check Your Mail To Confirm New Password!");
                }
            }
        } catch (MessagingException ex) {
            LOGGER.error("ResetPasswordServlet - Messagin " + ex.getMessage());
        } catch (NamingException ex) {
            LOGGER.error("ResetPasswordServlet - Naming " + ex.getMessage());
        } catch (SQLException ex) {
            LOGGER.error("ResetPasswordServlet - SQL " + ex.getMessage());
        } catch (NoSuchAlgorithmException ex) {
            LOGGER.error("ResetPasswordServlet - NoSuchAlgorithm " + ex.getMessage());
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
