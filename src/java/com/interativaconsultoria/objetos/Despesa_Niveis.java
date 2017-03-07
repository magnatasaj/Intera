/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.interativaconsultoria.objetos;

import java.awt.List;

/**
 *
 * @author Lamara
 */
public class Despesa_Niveis {
    
   private int id;
   private String nome;
   private int pai;
   private int ordem;

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
     * @return the nome
     */
    public String getNome() {
        return nome;
    }

    /**
     * @param nome the nome to set
     */
    public void setNome(String nome) {
        this.nome = nome;
    }

    /**
     * @return the pai
     */
    public int getPai() {
        return pai;
    }

    /**
     * @param pai the pai to set
     */
    public void setPai(int pai) {
        this.pai = pai;
    }

    /**
     * @return the ordem
     */
    public int getOrdem() {
        return ordem;
    }

    /**
     * @param ordem the ordem to set
     */
    public void setOrdem(int ordem) {
        this.ordem = ordem;
    }

  
}
