/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.interativaconsultoria.dao;

import com.sun.jmx.snmp.BerDecoder;
import java.sql.Array;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Lamara
 */
public class DaoAno {

    private PreparedStatement ps = null;
    private PreparedStatement ps2 = null;
    private ResultSet rs = null;
    private Jdbc con = new Jdbc();
    private Connection conexao;
    
    public DaoAno() throws SQLException, ClassNotFoundException {
        this.conexao = con.criarconexcao();
    }

    public List<Integer> Lista_anos() throws SQLException {
        String sql = "SELECT MAX(data) as maior,MIN(data) as menor FROM (select data from receita UNION ALL select data from despesa) as dd";
        ps = conexao.prepareStatement(sql);
        rs = ps.executeQuery();
        int menor = 0;
        int maior = 0;
        while (rs.next()) {
            int qmenor = rs.getString("menor").indexOf("-");
            int qmaior = rs.getString("maior").indexOf("-");

                    //conta numero que compoe o ano
            //remover mês e dia
            menor = Integer.parseInt(rs.getString("menor").substring(0, qmenor));
            maior = Integer.parseInt(rs.getString("maior").substring(0, qmaior));
        }
        List<Integer> anos = new ArrayList();
        
        for (int i = menor;maior >= i ;i++) {
          anos.add(i);
          
        }
       
        return anos;
    }
    
    

}
