/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.interativaconsultoria.dao;

import java.util.Properties;

/**
 *
 * @author Lamara
 */
public class Propriedade {
    private static Properties props  = new Properties();;
 
   
    public static void setprop(){
        props.setProperty("prop.nome", "Interativaconsultoria");
        props.setProperty("prop.app", "Interativaconsultoria");
      //  props.setProperty("prop.nome", "Lavoisier");
      //  props.setProperty("prop.app", "lavoisier");
        props.setProperty("prop.db", "sistema");
        props.setProperty("prop.user", "root");
        props.setProperty("prop.senha", "semanaacademica");
        props.setProperty("prop.host", "127.0.0.1");
        props.setProperty("prop.porta", "3306");
        props.setProperty("prop.tbp", "o_");
  
    }
    
    public static String getApp(){
        setprop();
        System.err.println("app:"+props.getProperty("prop.app"));
        return props.getProperty("prop.app");
    }
     public static String getDb(){
         setprop();
        return props.getProperty("prop.db");
    }
     
      public static String getUser(){
          setprop();
        return props.getProperty("prop.user");
    }
     public static String getSenha(){
         setprop();
        return props.getProperty("prop.senha");
    }  
     public static String getHost(){
         setprop();
        return props.getProperty("prop.host");
    }
     public static String getPorta(){
         setprop();
        return props.getProperty("prop.porta");
    }
    public static String getNome(){
         setprop();
        return props.getProperty("prop.nome");
    }
    public static String getTbp(){
         setprop();
        return props.getProperty("prop.tbp");
    } 
     
}
