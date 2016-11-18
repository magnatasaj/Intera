/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.interativaconsultoria.sv;

import com.interativaconsultoria.dao.DaoDespesaNivel;
import com.interativaconsultoria.objetos.Despesa_Niveis;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Lamara
 */
@WebServlet(name = "SvNiveis", urlPatterns = {"/SvNiveis"})
public class SvNiveis extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            if (request.getParameter("t").equals("psv")) {
                String nome = request.getParameter("nome").trim();
                int ordem = Integer.parseInt(request.getParameter("ordem").trim());
                Despesa_Niveis ObDespesa_Niveis = new Despesa_Niveis();
                ObDespesa_Niveis.setNome(nome);
                ObDespesa_Niveis.setOrdem(ordem);
                DaoDespesaNivel ObDaoDespesaNivel = new DaoDespesaNivel();
                ObDaoDespesaNivel.Adicionar_Nivel_Pai(ObDespesa_Niveis);
                response.getWriter().print(Alerta.Ok("Salvo com sucesso"));
            }

            //Salvar Nivel 1
            if (request.getParameter("t").equals("n1sv")) {
                String nome = request.getParameter("n1nome").trim();
                int ordem = Integer.parseInt(request.getParameter("n1ordem").trim());
                int idpai = Integer.parseInt(request.getParameter("n1idpai").trim());
                Despesa_Niveis ObDespesa_Niveis = new Despesa_Niveis();
                ObDespesa_Niveis.setNome(nome);
                ObDespesa_Niveis.setOrdem(ordem);
                ObDespesa_Niveis.setPai(idpai);
                DaoDespesaNivel ObDaoDespesaNivel = new DaoDespesaNivel();
                ObDaoDespesaNivel.Adicionar_Nivel_1(ObDespesa_Niveis);
                response.getWriter().print(Alerta.Ok("Salvo com sucesso"));
            }

            //Editar
            if (request.getParameter("t").equals("edt")) {
                String nome = request.getParameter("nome").trim();
                int ordem = Integer.parseInt(request.getParameter("ordem").trim());
                int id = Integer.parseInt(request.getParameter("id").trim());

                Despesa_Niveis ObDespesa_Niveis = new Despesa_Niveis();
                ObDespesa_Niveis.setNome(nome);
                ObDespesa_Niveis.setOrdem(ordem);
                ObDespesa_Niveis.setId(id);
                DaoDespesaNivel ObDaoDespesaNivel = new DaoDespesaNivel();
                ObDaoDespesaNivel.Editar_Nivel(ObDespesa_Niveis);
                response.getWriter().print(Alerta.Ok("Atualizado com sucesso"));
            }

            //excluir
            //Editar
            if (request.getParameter("t").equals("exc")) {

                int id = Integer.parseInt(request.getParameter("id").trim());
                DaoDespesaNivel ObDaoDespesaNivel = new DaoDespesaNivel();
                List<Despesa_Niveis> ls = ObDaoDespesaNivel.Consultar_Todos_Nivel();
                 for(Despesa_Niveis d : ls){
                 if(d.getId() == id){ 
                      ObDaoDespesaNivel.Excluir_Nivel(d);
                    for(Despesa_Niveis d2 : ls){
                    if(d2.getPai() == d.getId()){
                        ObDaoDespesaNivel.Excluir_Nivel(d2);
                        for(Despesa_Niveis d3 : ls){
                        if(d3.getPai() == d2.getId()){ 
                        ObDaoDespesaNivel.Excluir_Nivel(d3);
                        }}    
                        }}
                      
                  }}
               
                 
                response.getWriter().print(Alerta.Ok("Atualizado com sucesso"));
            }

        } catch (SQLException ex) {
            response.getWriter().print(Alerta.erro("Ouve algum erro", ex.toString()));
        } catch (ClassNotFoundException ex) {
            response.getWriter().print(Alerta.erro("Esta faltando class", ex.toString()));
        } catch (NumberFormatException ex) {
            response.getWriter().print(Alerta.erro("Erro no formato de número", ex.toString()));
        }

    }

}
