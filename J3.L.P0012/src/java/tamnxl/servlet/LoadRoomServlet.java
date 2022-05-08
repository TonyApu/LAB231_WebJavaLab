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
import tamnxl.areas.AreasDAO;
import tamnxl.hotel.HotelDAO;
import tamnxl.hotel.HotelDTO;
import tamnxl.roomType.RoomTypeDAO;

/**
 *
 * @author TamNXL
 */
@WebServlet(name = "LoadRoomServlet", urlPatterns = {"/LoadRoomServlet"})
public class LoadRoomServlet extends HttpServlet {

    private final String BOOKING_PAGE = "bookingPage";
    static final Logger LOGGER = Logger.getLogger(LoginServlet.class);

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
        String url = siteMap.get(BOOKING_PAGE);
        HttpSession session = request.getSession();
        try {
            RoomTypeDAO roomTypeDAO = new RoomTypeDAO();
            ArrayList<String> listRoomType = roomTypeDAO.getListRoomType();
            AreasDAO areasDAO = new AreasDAO();
            ArrayList<String> listAreas = areasDAO.getListAreas();
            session.setAttribute("listRoomType", listRoomType);
            session.setAttribute("listAreas", listAreas);
            HotelDAO hotelDAO = new HotelDAO();
            ArrayList<HotelDTO> listHotels = (ArrayList<HotelDTO>) hotelDAO.getListHotel();
            if (listHotels != null) {
                request.setAttribute("listHotels", listHotels);
            }
        } catch (NamingException ex) {
            LOGGER.error("LoadRoomServlet - Naming " + ex.getMessage());
        } catch (SQLException ex) {
            LOGGER.error("LoadRoomServlet - SQL " + ex.getMessage());
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
