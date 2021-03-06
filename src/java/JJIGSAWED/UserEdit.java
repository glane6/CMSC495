/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package JJIGSAWED;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author jmehl
 */
@WebServlet(name = "UserEdit", urlPatterns = {"/UserEdit"})
public class UserEdit extends HttpServlet {
    
    private static final String DRIVER = DBInteraction.getDBDriver();
    private static final String CONNECT = DBInteraction.getDBConnect();
    private static final String USER = DBInteraction.getDBUsername(); 
    private static final String PWORD = DBInteraction.getDBPassword(); 
    private static Statement statement;
    private static PreparedStatement prepStatement;
    private static Connection con;

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
        
            
        String userName = request.getParameter("user_name");
        String userRole = request.getParameter("user_role");

        String originalUserName = request.getParameter("OriginalUserName");
        String originalUserRole = request.getParameter("OriginalUserRole");
        
        // get task ID from name and priority
        int userID = User.getUserID(originalUserName, originalUserRole);
        System.out.println(userID);
            
         try {
             Class.forName(DRIVER);
             con = DriverManager.getConnection(CONNECT, USER, PWORD);

             prepStatement = con.prepareStatement("UPDATE CMSC495.Users"
                     + " SET Name = ?, Role = ?"
                     + " WHERE UserID = ?");

             prepStatement.setString(1, userName);
             prepStatement.setString(2, userRole);
             prepStatement.setInt(3, userID);

             prepStatement.execute(); // perform update

             // redirect to success page
             response.sendRedirect("UserSuccess.jsp");
            } catch (ClassNotFoundException | SQLException ex) {
                System.out.println("An exception occured");
                System.out.println(ex);
                response.sendRedirect("UserFail.jsp");
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
