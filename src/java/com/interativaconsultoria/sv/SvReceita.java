/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.interativaconsultoria.sv;

import com.interativaconsultoria.dao.DaoDespesa;
import com.interativaconsultoria.dao.DaoDespesaNivel;
import com.interativaconsultoria.dao.DaoReceita;
import com.interativaconsultoria.objetos.Despesa;
import com.interativaconsultoria.objetos.Despesa_Niveis;
import com.interativaconsultoria.objetos.Receita;
import com.interativaconsultoria.objetos.ReceitaOrigem;
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
@WebServlet(name = "SvReceita", urlPatterns = {"/SvReceita"})
public class SvReceita extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            if (request.getParameter("t").equals("add")) {
                String d = request.getParameter("valor").trim();
                String receita_origem = request.getParameter("tipoRadios");
                String debito_credito = request.getParameter("apRadios");
                String vendido_recebido = request.getParameter("vrRadios");

                String desc = request.getParameter("desc");
                String str_data = request.getParameter("data").trim();
                str_data = str_data.replace("-", "/");
                
                int receita_origem_id = Integer.parseInt(receita_origem);
                int debito_creditoI = Integer.parseInt(debito_credito);
                int vendido_recebidoI = Integer.parseInt(vendido_recebido);

                d = d.replace(".", "");
                d = d.replace(",", ".");
                BigDecimal valor = new BigDecimal(d);

                DateFormat formatter;
                Date date;
                formatter = new SimpleDateFormat("dd/MM/yyyy");
                date = (Date) formatter.parse(str_data);
                //criando os objetos receita e origem
                Receita ObReceita = new Receita();
                ReceitaOrigem ObOrigem = new ReceitaOrigem();
                ObOrigem.setId(receita_origem_id);
                //passando valroes para o objeto
                ObReceita.setReceita_origem(ObOrigem);
                ObReceita.setDebito_credito(debito_creditoI);
                ObReceita.setVendido_recebido(vendido_recebidoI);
                ObReceita.setValor(valor);
                ObReceita.setData(date);
                ObReceita.setDescricao(desc);
                DaoReceita ObDaoReceita = new DaoReceita();
                ObDaoReceita.Adicionar_Receita(ObReceita);
                response.getWriter().print(Alerta.Ok("Adicionado com sucesso. Espero que sempre seja assim"));
            }

            if (request.getParameter("t").equals("edd")) {
                String idS = request.getParameter("id").trim();
                int idI = Integer.parseInt(idS);
                String d = request.getParameter("valor").trim();
                String receita_origem = request.getParameter("tipoRadios");
                String debito_credito = request.getParameter("apRadios");
                String vendido_recebido = request.getParameter("vrRadios");

                String desc = request.getParameter("desc");
                String str_data = request.getParameter("data").trim();
                str_data = str_data.replace("-", "/");
                
                int receita_origem_id = Integer.parseInt(receita_origem);
                int debito_creditoI = Integer.parseInt(debito_credito);
                int vendido_recebidoI = Integer.parseInt(vendido_recebido);

                d = d.replace(".", "");
                d = d.replace(",", ".");
                BigDecimal valor = new BigDecimal(d);

                DateFormat formatter;
                Date date;
                formatter = new SimpleDateFormat("dd/MM/yyyy");
                date = (Date) formatter.parse(str_data);
                //criando os objetos receita e origem
                Receita ObReceita = new Receita();
                ReceitaOrigem ObOrigem = new ReceitaOrigem();
                ObOrigem.setId(receita_origem_id);
                //passando valroes para o objeto
                ObReceita.setId(idI);
                ObReceita.setReceita_origem(ObOrigem);
                ObReceita.setDebito_credito(debito_creditoI);
                ObReceita.setVendido_recebido(vendido_recebidoI);
                ObReceita.setValor(valor);
                ObReceita.setData(date);
                ObReceita.setDescricao(desc);
                DaoReceita ObDaoReceita = new DaoReceita();
                ObDaoReceita.Editar_Receita(ObReceita);
                response.getWriter().print(Alerta.Ok("As alterações foram salvas. Isso é bom!"));
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
            response.getWriter().print(Alerta.erro("Erro no formato de número, hoje o dia não esta bom", ex.toString()));
            Logger.getLogger(SvReceita.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            response.getWriter().print(Alerta.erro("PasresException", ex.toString()));
            Logger.getLogger(SvReceita.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            response.getWriter().print(Alerta.erro("Erro no sql. Vix, é melhor chamar o suporte ", ex.toString()));
            Logger.getLogger(SvReceita.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ClassNotFoundException ex) {
            response.getWriter().print(Alerta.erro("Erro Classe não existe. Vix, é melhor chamar o suporte", ex.toString()));
            Logger.getLogger(SvReceita.class.getName()).log(Level.SEVERE, null, ex);
        }catch(NullPointerException ex){
            response.getWriter().print(Alerta.erro("Valor Vazío. Os campos tem que está preenchidos", ex.toString()));
            Logger.getLogger(SvReceita.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

}
