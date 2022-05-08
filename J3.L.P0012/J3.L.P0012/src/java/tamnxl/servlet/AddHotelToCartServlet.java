/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tamnxl.servlet;

import java.io.IOException;
import java.text.ParseException;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.log4j.Logger;
import tamnxl.cart.CartObject;
import tamnxl.cart.Items;
import tamnxl.util.DateHelper;

/**
 *
 * @author TamNXL
 */
@WebServlet(name = "AddHotelToCartServlet", urlPatterns = {"/AddHotelToCartServlet"})
public class AddHotelToCartServlet extends HttpServlet {
    
    private final String SEARCH_CONTROLLER = "search";
    static final Logger LOGGER = Logger.getLogger(AddHotelToCartServlet.class);
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
        String typeID = request.getParameter("txtTypeID");
        String hotelID = request.getParameter("txtHotelID");
        String typeName = request.getParameter("txtTypeName");
        String hotelName = request.getParameter("txtHotelName");
        String price = request.getParameter("txtPrice");
        String amount = request.getParameter("txtAmount");
        String checkInDate = request.getParameter("txtCheckInDate");
        String checkOutDate = request.getParameter("txtCheckOutDate");
        HttpSession session = request.getSession();
        ServletContext context = request.getServletContext();
        Map<String, String> siteMap = (Map<String, String>) context.getAttribute("SITE_MAP");
        String url = siteMap.get(SEARCH_CONTROLLER);
        try {
            DateHelper dateHelper = new DateHelper();
            long totalDay = dateHelper.getDaysBetween(checkInDate, checkOutDate);
            Items items = new Items(hotelID, hotelName, typeID, typeName, Integer.parseInt(amount), Float.parseFloat(price), totalDay, checkInDate, checkOutDate);
            CartObject cartObject = (CartObject) session.getAttribute("cartObject");
            if (cartObject == null) {
                cartObject = new CartObject();
            }
            boolean rs = cartObject.addHotelToCart(items);
            if (rs) {
                session.setAttribute("cartObject", cartObject);
                request.setAttribute("success", true);
            } else {
                request.setAttribute("success", false);
            }
        } catch (ParseException ex) {
            LOGGER.error("AddHotelToCartServlet - Parse " + ex.getMessage());
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
