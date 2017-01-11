/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.interativaconsultoria.sv;

import com.interativaconsultoria.dao.DaoLogin;
import com.interativaconsultoria.dao.DaoUser;
import com.interativaconsultoria.objetos.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author magteclu
 */
@WebServlet(name = "SvEntrar", urlPatterns = {"/SvEntrar"})
public class SvEntrar extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
  

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
             response.setContentType("text/plain");
            DaoLogin dlo = new DaoLogin();
            DaoUser dal = new DaoUser();
            String e = request.getParameter("email");
            String s = request.getParameter("senha");
            int id = dlo.Consultar_Login(request.getParameter("email"),request.getParameter("senha"));
            if(id == 0){
                        response.getWriter().write("Email ou Senha estão incoretos!");

            }else{
            User als = new User();
            als = dal.Obj_Aluno(Integer.toString(id));
            HttpSession session = request.getSession(true);
          //passa nome para a sessão
         session.setAttribute("nome",als);   
         response.getWriter().write(e);
            }
        } catch (SQLException ex) {
            Logger.getLogger(SvEntrar.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(SvEntrar.class.getName()).log(Level.SEVERE, null, ex);
        }
       
        
        
    }

   
}
