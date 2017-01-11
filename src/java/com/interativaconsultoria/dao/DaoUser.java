/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.interativaconsultoria.dao;

import com.interativaconsultoria.objetos.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author lubuntu
 */
public class DaoUser {

    private PreparedStatement ps = null;
    private PreparedStatement ps2 = null;
    private ResultSet rs = null;
    private Jdbc con = new Jdbc();
    private Connection conexao;
    private String tbp = Propriedade.getTbp();

    public DaoUser() throws SQLException, ClassNotFoundException {
        this.conexao = con.criarconexcao();
    }

    public void Aluno_Salvar(User al) throws SQLException, ClassNotFoundException {

        String sql = "";
        String sql_idgerado = "SELECT * FROM " + tbp + "alunos WHERE id =(SELECT LAST_INSERT_ID())";

        ps = conexao.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
        ps.executeUpdate();
        ResultSet rs = ps.getGeneratedKeys();
        ps.close();
    }

    public User Obj_Aluno(String id) throws SQLException {

        String sql = "SELECT * FROM `" + tbp + "alunos` WHERE `id` = '" + id + "'";
        ps = conexao.prepareStatement(sql);
        rs = ps.executeQuery();
        User us = new User();
        while (rs.next()) {
            us.setId(rs.getInt("id"));
            us.setNome(rs.getString("nome"));
            us.setSenha(rs.getString("senha"));
            us.setEmail(rs.getString("email"));
            us.setTipo(rs.getInt("tipo"));
        }

        ps.close();
        return us;
    }

}
