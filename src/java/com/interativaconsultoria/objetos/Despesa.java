/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.interativaconsultoria.objetos;

import java.math.BigDecimal;
import java.util.Calendar;
import java.util.Date;

/**
 *
 * @author Lamara
 */
public class Despesa {
    private int id;
    private BigDecimal valor;
    private Date data;
    private int id_nivel;
    private String descricao;
    private String nome_despesa;

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
     * @return the id_nivel
     */
    public int getId_nivel() {
        return id_nivel;
    }

    /**
     * @param id_nivel the id_nivel to set
     */
    public void setId_nivel(int id_nivel) {
        this.id_nivel = id_nivel;
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
     * @return the nome_despesaString
     */
    public String getNome_despesa() {
        return nome_despesa;
    }

    /**
     */
    public void setNome_despesa(String nome_despesa) {
        this.nome_despesa = nome_despesa;
    }
    
}
