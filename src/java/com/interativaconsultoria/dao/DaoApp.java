/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.interativaconsultoria.dao;

import com.interativaconsultoria.objetos.App;
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
public class DaoApp {

    private PreparedStatement ps = null;
    private PreparedStatement ps2 = null;
    private ResultSet rs = null;
    private Jdbc con = new Jdbc();
    private Connection conexao;

    public DaoApp() throws SQLException, ClassNotFoundException {
        this.conexao = con.criarconexcao();
    }
    
     public void fechar() throws SQLException{
        con.fechar();
    
    }

    public App obj_app(String nome) throws SQLException {
        String sql = "SELECT * FROM `apps` WHERE `nome_sistema` LIKE '"+nome+"'";
        ps = conexao.prepareStatement(sql);
        rs = ps.executeQuery();
        App app = new App();
        while (rs.next()) {
          app.setId_app(rs.getInt("id_app"));
          app.setNome(rs.getString("nome"));
          app.setNome_sistema(rs.getString("nome_sistema"));
          app.setPrefixo_tb(rs.getString("prefixo_tb"));
            
        }
        
        rs.close();
        return app;
    }

}
