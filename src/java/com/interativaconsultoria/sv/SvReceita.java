/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.interativaconsultoria.sv;

import com.interativaconsultoria.dao.DaoDespesa;
import com.interativaconsultoria.dao.DaoDespesaNivel;
import com.interativaconsultoria.objetos.Despesa;
import com.interativaconsultoria.objetos.Despesa_Niveis;
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
 *NumberFormat nf = NumberFormat.getCurrencyInstance();  
String formatado = nf.format (valor);
System.out.println(formatado);
 * @author Lamara
 */
@WebServlet(name = "SvReceita", urlPatterns = {"/SvReceita"})
public class SvReceita extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        
        try {
            if (request.getParameter("t").equals("add")) {
                String d = request.getParameter("valor").trim();
                String id = request.getParameter("id");
                String desc = request.getParameter("desc");
                String str_data = request.getParameter("data").trim();
                str_data = str_data.replace( "-" , "/");
                int idnivel = Integer.parseInt(id);
                d = d.replace( "." , "");
                d = d.replace( "," , ".");
                BigDecimal valor = new BigDecimal (d);  
                
                DateFormat formatter ; 
                Date date ; 
                formatter = new SimpleDateFormat("dd/MM/yyyy");
                date = (Date)formatter.parse(str_data); 
                
                Despesa ObDespesa = new Despesa();
                ObDespesa.setId_nivel(idnivel);
                ObDespesa.setValor(valor);
                ObDespesa.setData(date);
                ObDespesa.setDescricao(desc);
                DaoDespesa ObDaoDespesa = new DaoDespesa();
                ObDaoDespesa.Adicionar_Despesa(ObDespesa);
                response.getWriter().print(Alerta.Ok("Salvo com sucesso"));
            }
            
             if (request.getParameter("t").equals("edd")) {
                String d = request.getParameter("valor").trim();
                String id = request.getParameter("id");
                String desc = request.getParameter("desc");
                String str_data = request.getParameter("data").trim();
                int iddespesa = Integer.parseInt(id);
                d = d.replace( "." , "");
                d = d.replace( "," , ".");
             
                BigDecimal valor = new BigDecimal (d);  
                
                DateFormat formatter ; 
                Date date ; 
                formatter = new SimpleDateFormat("dd/MM/yyyy");
                date = (Date)formatter.parse(str_data); 
   
                Despesa ObDespesa = new Despesa();
                ObDespesa.setId(iddespesa);
                ObDespesa.setValor(valor);
                ObDespesa.setData(date);
                ObDespesa.setDescricao(desc);
                DaoDespesa ObDaoDespesa = new DaoDespesa();
                ObDaoDespesa.Editar_Despesa(ObDespesa);
                response.getWriter().print(Alerta.Ok("Atualizado com sucesso"));
            }
             
            if (request.getParameter("t").equals("exc")) {
                String id = request.getParameter("id");
                int iddespesa = Integer.parseInt(id);
             
                Despesa ObDespesa = new Despesa();
                ObDespesa.setId(iddespesa);
                DaoDespesa ObDaoDespesa = new DaoDespesa();
                ObDaoDespesa.Excluir_Despesa(ObDespesa);
                response.getWriter().print(Alerta.Ok("Excluido com sucesso!"));
            }

           

       
        } catch (NumberFormatException ex) {
            response.getWriter().print(Alerta.erro("Erro no formato de número", ex.toString()));
            Logger.getLogger(SvReceita.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            response.getWriter().print(Alerta.erro("PasresException", ex.toString()));
            Logger.getLogger(SvReceita.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            response.getWriter().print(Alerta.erro("Erro no sql", ex.toString()));
            Logger.getLogger(SvReceita.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            response.getWriter().print(Alerta.erro("Erro Classe não existe", ex.toString()));
            Logger.getLogger(SvReceita.class.getName()).log(Level.SEVERE, null, ex);
        }
        
        
    }

}
