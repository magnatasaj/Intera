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
import java.util.ArrayList;
import java.util.List;

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
    public String tbp;

    public DaoUser(String tb) throws SQLException, ClassNotFoundException {
        this.tbp = tb;
        this.conexao = con.criarconexcao();
    }

    public void Aluno_Salvar(User al) throws SQLException, ClassNotFoundException {

        String sql = "INSERT INTO " + tbp + "alunos (`id`, `nome`, `email`, `senha`, `tipo`) VALUES (NULL, ?, ?, ?,?)";
        ps = conexao.prepareStatement(sql);
        ps.setString(1, al.getNome());
        ps.setString(2, al.getEmail());
        ps.setString(3, al.getSenha());
        ps.setInt(4, al.getTipo());
        
        ps.execute();
        ps.close();
    }
    
    public void Aluno_atualizar(User al) throws SQLException, ClassNotFoundException {

        String sql = "UPDATE " + tbp + "alunos SET `nome` = ?, `email` = ?, `senha` = ?, `tipo` = ? WHERE " + tbp + "alunos.id = ?;";
        ps = conexao.prepareStatement(sql);
        ps.setString(1, al.getNome());
        ps.setString(2, al.getEmail());
        ps.setString(3, al.getSenha());
        ps.setInt(4, al.getTipo());
        ps.setInt(5, al.getId());
        
        ps.executeUpdate();
        ps.close();
    }
    
     public void Aluno_excluir(int id) throws SQLException, ClassNotFoundException {

        String sql = "DELETE FROM " + tbp + "alunos WHERE " + tbp + "alunos.id = ?";
        ps = conexao.prepareStatement(sql);
       
        ps.setInt(1, id);
        ps.execute();
        ps.close();
    }

    public List<User> Aluno_Listar() throws SQLException, ClassNotFoundException {

        String sql = "SELECT * FROM " + tbp + "alunos";
        List<User> alunos = new ArrayList();
        ps = conexao.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            User us = new User();
            us.setId(rs.getInt("id"));
            us.setNome(rs.getString("nome"));
            us.setSenha(rs.getString("senha"));
            us.setEmail(rs.getString("email"));
            us.setTipo(rs.getInt("tipo"));
            alunos.add(us);

        }
        ps.close();
        return alunos;
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
