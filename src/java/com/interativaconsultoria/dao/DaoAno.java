/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.interativaconsultoria.dao;

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
    private String tbp;

    public DaoAno(String tb) throws SQLException, ClassNotFoundException {
        this.tbp = tb;
        this.conexao = con.criarconexcao();
    }
    
     public void fechar() throws SQLException{
        con.fechar();
    
    }

    public List<Integer> Lista_anos() throws SQLException {
        String sql = "SELECT MAX(data) as maior,MIN(data) as menor FROM (SELECT data from "+tbp+"receita UNION ALL select data from "+tbp+"despesa) as dd";
        ps = conexao.prepareStatement(sql);
        rs = ps.executeQuery();
        int menor = 0;
        int maior = 0;
        while (rs.next()) {
            if (rs.getString("menor") != null && rs.getString("maior") != null ) {
                int qmenor = rs.getString("menor").indexOf("-");
                int qmaior = rs.getString("maior").indexOf("-");

                    //conta numero que compoe o ano
                //remover mês e dia
                menor = Integer.parseInt(rs.getString("menor").substring(0, qmenor));
                maior = Integer.parseInt(rs.getString("maior").substring(0, qmaior));
            } else {

                menor = 2016;
                maior = 2016;

            }
        }
        List<Integer> anos = new ArrayList();

        for (int i = maior; menor <= i; i--) {
            anos.add(i);

        }
        rs.close();
        return anos;
    }

}
