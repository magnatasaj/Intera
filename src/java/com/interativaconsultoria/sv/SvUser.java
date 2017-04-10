/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.interativaconsultoria.sv;

import com.interativaconsultoria.dao.DaoAno;
import com.interativaconsultoria.dao.DaoDespesa;
import com.interativaconsultoria.dao.DaoDespesaNivel;
import com.interativaconsultoria.dao.DaoReceita;
import com.interativaconsultoria.dao.DaoUser;
import com.interativaconsultoria.objetos.App;
import com.interativaconsultoria.objetos.Despesa;
import com.interativaconsultoria.objetos.Despesa_Niveis;
import com.interativaconsultoria.objetos.Receita;
import com.interativaconsultoria.objetos.ReceitaOrigem;
import com.interativaconsultoria.objetos.User;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.NumberFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * NumberFormat nf = NumberFormat.getCurrencyInstance(); String formatado =
 * nf.format (valor); System.out.println(formatado);
 *
 * @author Lamara
 */
@WebServlet(name = "SvUser", urlPatterns = {"/SvUser"})
public class SvUser extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            App app = (App)request.getSession().getAttribute("app");
            if (request.getParameter("t").equals("add")) {
                String nome = request.getParameter("nome").trim();
                String email = request.getParameter("email");
                String senha = request.getParameter("senha");
                String tipo = request.getParameter("tipo").trim();
                
                User user = new User();
                
                user.setNome(nome);
                user.setEmail(email);
                user.setSenha(senha);
                user.setTipo(Integer.parseInt(tipo));
                
                DaoUser daoUser = new DaoUser(app.getPrefixo_tb());
                daoUser.Aluno_Salvar(user);
                
                response.getWriter().print(Alerta.Ok("Adicionado com sucesso."));
            }

            if (request.getParameter("t").equals("edd")) {
                String id = request.getParameter("id").trim();
                String nome = request.getParameter("nome").trim();
                String email = request.getParameter("email");
                String senha = request.getParameter("senha");
                String tipo = request.getParameter("tipo").trim();
                
                User user = new User();
                
                user.setId(Integer.parseInt(id));
                user.setNome(nome);
                user.setEmail(email);
                user.setSenha(senha);
                user.setTipo(Integer.parseInt(tipo));
                
                DaoUser daoUser = new DaoUser(app.getPrefixo_tb());
                daoUser.Aluno_atualizar(user);
                
                response.getWriter().print(Alerta.Ok("As alterações foram salvas!"));
            }

            if (request.getParameter("t").equals("exc")) {
                String id = request.getParameter("id").trim();
                DaoUser daoUser = new DaoUser(app.getPrefixo_tb());
                daoUser.Aluno_excluir(Integer.parseInt(id));
                response.getWriter().print(Alerta.Ok("Foi excluido com sucesso!"));
            }

        } catch (NumberFormatException ex) {
            response.getWriter().print(Alerta.erro("Erro no formato de número, digite um valor válido.", ex.toString()));
            Logger.getLogger(SvUser.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            response.getWriter().print(Alerta.erro("Erro no sql. Tente novamente", ex.toString()));
            Logger.getLogger(SvUser.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            response.getWriter().print(Alerta.erro("Erro Classe não existe. Tente novamente", ex.toString()));
            Logger.getLogger(SvUser.class.getName()).log(Level.SEVERE, null, ex);
        }catch(NullPointerException ex){
            response.getWriter().print(Alerta.erro("Valor Vazío. Os campos tem que está preenchidos", ex.toString()));
            Logger.getLogger(SvUser.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

}
