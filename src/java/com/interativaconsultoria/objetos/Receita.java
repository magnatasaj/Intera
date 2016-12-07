/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.interativaconsultoria.objetos;

import java.math.BigDecimal;
import java.util.Date;

/**
 *
 * @author Lamara
 */
public class Receita {

    private int id;
    private BigDecimal valor;
    private Date data;
    private int vendido_recebido;
    private int debito_credito;
    private String  descricao;
    private ReceitaOrigem receita_origem;

    /**
     * @return the id
     */
    public int getId() {
        return id;
    }

    /**
     * @param id the id to set
     */
    public void setId(int id) {
        this.id = id;
    }

    /**
     * @return the valor
     */
    public BigDecimal getValor() {
        return valor;
    }

    /**
     * @param valor the valor to set
     */
    public void setValor(BigDecimal valor) {
        this.valor = valor;
    }

    /**
     * @return the data
     */
    public Date getData() {
        return data;
    }

    /**
     * @param data the data to set
     */
    public void setData(Date data) {
        this.data = data;
    }

   
    /**
     * @return the vendido_recebido
     */
    public int getVendido_recebido() {
        return vendido_recebido;
    }
    
    public String getVendido_recebido_st(int vr) {
        String resultado = "";
        switch (vr){
            case 1 : resultado = "Recebido"; break;
            case 2 : resultado = "Vendido"; break;
                
        }
        
        return resultado;
    }

    /**
     * @param vendido_recebido the vendido_recebido to set
     */
    public void setVendido_recebido(int vendido_recebido) {
        this.vendido_recebido = vendido_recebido;
    }

    /**
     * @return the debito_credito
     */
    public int getDebito_credito() {
        return debito_credito;
    }
    public String getDebito_credito_st(int v) {
       String resultado = "";
        switch (v){
            case 1 : resultado = "Á vista"; break;
            case 2 : resultado = "A prazo"; break;
                
        }
        
        return resultado;
    }

    /**
     * @param debito_credito the debito_credito to set
     */
    public void setDebito_credito(int debito_credito) {
        this.debito_credito = debito_credito;
    }

    /**
     * @return the descricao
     */
    public String getDescricao() {
        return descricao;
    }

    /**
     * @param descricao the descricao to set
     */
    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    /**
     * @return the receita_origem
     */
    public ReceitaOrigem getReceita_origem() {
        return receita_origem;
    }

    /**
     * @param receita_origem the receita_origem to set
     */
    public void setReceita_origem(ReceitaOrigem receita_origem) {
        this.receita_origem = receita_origem;
    }

}
