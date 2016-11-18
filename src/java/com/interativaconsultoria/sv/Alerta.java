/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.interativaconsultoria.sv;

/**
 *
 * @author Lamara
 */
public class Alerta {
    
    
    public static String erro(String msg,String ex){
        String t = "<div class=\"alert alert-danger alert-dismissible\">\n"
                    + "                <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-hidden=\"true\">×</button>\n"
                    + "                <h4><i class=\"icon fa fa-ban\"></i>Atenção</h4>\n"
                    + "                 "+msg+"</br> Descrição:" + ex + " \n"
                    + "              </div>";
        return t;
    }
    
     public static String Ok(String ex){
        String t = "<div class=\"alert alert-success alert-dismissible\">\n"
                    + "                <button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-hidden=\"true\">×</button>\n"
                    + "                <h4><i class=\"icon fa fa-check\"></i> Ok!</h4>\n"
                    + "                "+ex+"\n"
                    + "              </div>";
        return t;
    }
    
}
