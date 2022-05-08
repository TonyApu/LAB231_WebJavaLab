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
import org.apache.log4j.Logger;
import tamnxl.userInfor.CreateNewAccountError;
import tamnxl.userInfor.UserInforDAO;
import tamnxl.util.EmailHelper;
import tamnxl.util.Encryption;

/**
 *
 * @author TamNXL
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/RegisterServlet"})
public class RegisterServlet extends HttpServlet {
    
    private final String ERROR_PAGE = "registerPage";
    private final String REGISTER_SUCCESS_PAGE = "registerPage";
    static final Logger LOGGER = Logger.getLogger(RegisterServlet.class);
    
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
        String password = request.getParameter("txtPassword");
        String fullName = request.getParameter("txtFullname");
        String confirm = request.getParameter("txtConfirm");
        Encryption encryption = new Encryption();
        CreateNewAccountError errors = new CreateNewAccountError();
        String url = siteMap.get(ERROR_PAGE);
        
        try {
            String passwordEncoded = encryption.encode(password);
            boolean foundErr = false;
            if (!email.matches("[A-Za-z0-9._]+@\\w+(\\.[a-z]{2,3}){1,2}")) {
                foundErr = true;
                errors.setEmailIsIncorrectFormat("Email không hợp lệ!");
            }
            if (password.trim().length() < 6 || password.trim().length() > 30) {

                foundErr = true;

                errors.setPasswordLengtErr("Mật khẩu phải từ 6 đến 30 kí tự!");
            } else if (!confirm.trim().equals(password.trim())) {
                foundErr = true;
                errors.setConfirmNotMatched("Xác nhận mật khẩu không đúng!");
            }
            if (fullName.trim().length() < 3 || fullName.trim().length() > 50) {
                foundErr = true;
                errors.setFullNameLengtErr("Họ và tên phải từ 3 đến 50 kí tự! ");
            }
            if (foundErr) {
                request.setAttribute("CREATE_ERRORS", errors);
            } else {
                UserInforDAO userInforDAO = new UserInforDAO();
                boolean result = userInforDAO.createAccount(email, passwordEncoded, fullName);
                if (result) {
                    EmailHelper emailHelper = new EmailHelper(email);
                    emailHelper.sendMail();
                    url = siteMap.get(REGISTER_SUCCESS_PAGE);
                    request.setAttribute("message", "Chúc mừng bạn đã đăng kí thành công!");
                }
                
            }
        } catch (NoSuchAlgorithmException ex) {
            LOGGER.error("RegisterServlet - NoSuchAlgorithm " + ex.getMessage());
        } catch (MessagingException ex) {
            LOGGER.error("RegisterServlet - Messaging " + ex.getMessage());
        } catch (NamingException ex) {
            LOGGER.error("RegisterServlet - Naming " + ex.getMessage());
        } catch (SQLException ex) {
            String msg = ex.getMessage();
            LOGGER.error("RegisterServlet - SQL " + msg);
            if (msg.contains("duplicate")) {
                errors.setEmailIsExisted(email + " is Existed!");
                request.setAttribute("CREATE_ERRORS", errors);
            }
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
