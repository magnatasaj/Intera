/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.interativaconsultoria.funcao;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author Lamara
 */
public class Data {
    
    public static String MudarFormatoDeData(Date d) throws ParseException{
        SimpleDateFormat formatoDesejado = new SimpleDateFormat("dd/MM/yyyy");

String dataFormatada = null;

dataFormatada = formatoDesejado.format(d);
                return  dataFormatada;
    }
    
}
