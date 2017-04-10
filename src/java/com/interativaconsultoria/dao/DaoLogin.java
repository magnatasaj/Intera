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
 * @author lubuntu
 */
public class DaoLogin {

    private PreparedStatement ps = null;
    private ResultSet rs = null;
    private Jdbc con = new Jdbc();
    private Connection conexao;
    private String tbp;

    public DaoLogin(String tb) throws SQLException, ClassNotFoundException {
        this.tbp = tb;
        this.conexao = con.criarconexcao();
    }

    public int Consultar_Login(String email, String senha) throws SQLException {

        String sql = "SELECT * FROM `"+tbp+"alunos` WHERE `email` = '" + email + "' AND `senha` = '" + senha + "' ";
        ps = conexao.prepareStatement(sql);
        rs = ps.executeQuery();
        int id = 0;
        while (rs.next()) {
            id = rs.getInt("id");
        }

        return id;
    }

    public boolean Consultar_Email(String email) throws SQLException {

        String sql = "SELECT * FROM `"+tbp+"alunos` WHERE `email` = '" + email + "'";
        ps = conexao.prepareStatement(sql);
        rs = ps.executeQuery();

        return rs.first();
    }

    public boolean Consultar_cpf(String cpf) throws SQLException {

        String sql = "SELECT * FROM `"+tbp+"alunos` WHERE `cpf` = '" + cpf + "'";
        ps = conexao.prepareStatement(sql);
        rs = ps.executeQuery();

        return rs.first();
    }

}
