/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.interativaconsultoria.dao;

import com.interativaconsultoria.objetos.Despesa_Niveis;
import com.interativaconsultoria.objetos.Receita;
import com.interativaconsultoria.objetos.ReceitaOrigem;
import java.sql.Array;
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
public class DaoReceitaOrigem {

    private PreparedStatement ps = null;
    private PreparedStatement ps2 = null;
    private ResultSet rs = null;
    private Jdbc con = new Jdbc();
    private Connection conexao;

    public DaoReceitaOrigem() throws SQLException, ClassNotFoundException {
        this.conexao = con.criarconexcao();
    }

    public void Adicionar_Nivel_Pai(Despesa_Niveis De) throws SQLException {

        String sql = "INSERT INTO `despesa_niveis` (`id`, `nome`, `pai`, `ordem`) VALUES (NULL,?, 0,?)";

        ps = conexao.prepareStatement(sql);
        ps.setString(1, De.getNome());
        ps.setInt(2, De.getOrdem());
        ps.execute();
        ps.close();

    }

    public void Adicionar_Nivel_1(Despesa_Niveis De) throws SQLException {

        String sql = "INSERT INTO `despesa_niveis` (`id`, `nome`, `pai`, `ordem`) VALUES (NULL,?, ?,?)";

        ps = conexao.prepareStatement(sql);
        ps.setString(1, De.getNome());
        ps.setInt(2, De.getPai());
        ps.setInt(3, De.getOrdem());
        ps.execute();
        ps.close();

    }

    public List<ReceitaOrigem> Consultar_Todas_Origens() throws SQLException {

        String sql = "SELECT * FROM `receita_origem`";
        ps = conexao.prepareStatement(sql);
        rs = ps.executeQuery();
        List<ReceitaOrigem> ls = new ArrayList();
        while (rs.next()) {
            ReceitaOrigem Obs = new ReceitaOrigem();
            Obs.setId(rs.getInt("id"));
            Obs.setNome(rs.getString("nome_origem"));
            
            ls.add(Obs);
        }

        rs.close();
        return ls;
    }

    
    public List<Despesa_Niveis> Consultar_Nivel_Pai() throws SQLException {

        String sql = "SELECT * FROM `despesa_niveis`  ORDER BY `despesa_niveis`.`ordem` ASC";
        ps = conexao.prepareStatement(sql);
        rs = ps.executeQuery();
        List<Despesa_Niveis> ls = new ArrayList();
        while (rs.next()) {
            Despesa_Niveis Obs = new Despesa_Niveis();
            Obs.setId(rs.getInt("id"));
            Obs.setNome(rs.getString("nome"));
            Obs.setPai(rs.getInt("pai"));
            Obs.setOrdem(rs.getInt("ordem"));
            ls.add(Obs);
        }

        rs.close();
        return ls;
    }

    public List<Despesa_Niveis> Consultar_Nivel(int id) throws SQLException {

        String sql = "SELECT * FROM `despesa_niveis` where pai = " + id + " ORDER BY `despesa_niveis`.`ordem` ASC";
        ps = conexao.prepareStatement(sql);
        rs = ps.executeQuery();
        List<Despesa_Niveis> ls = new ArrayList();
        while (rs.next()) {
            Despesa_Niveis Obs = new Despesa_Niveis();
            Obs.setId(rs.getInt("id"));
            Obs.setNome(rs.getString("nome"));
            Obs.setPai(rs.getInt("pai"));
            Obs.setOrdem(rs.getInt("ordem"));
            ls.add(Obs);
        }

        rs.close();
        return ls;
    }

    public void Editar_Nivel(Despesa_Niveis De) throws SQLException {

        String sql = "UPDATE `despesa_niveis` SET `nome` = ?, `ordem` = ?  WHERE `despesa_niveis`.`id` =?;";

        ps = conexao.prepareStatement(sql);
        ps.setString(1, De.getNome());
        ps.setInt(2, De.getOrdem());
        ps.setInt(3, De.getId());
        ps.executeUpdate();
        ps.close();

    }

    public void Excluir_Nivel(Despesa_Niveis De) throws SQLException {

        String sql = "DELETE FROM `despesa_niveis` WHERE `despesa_niveis`.`id` =? ";

        ps = conexao.prepareStatement(sql);
        ps.setInt(1, De.getId());
        ps.execute();
        // ps.close();

    }
}
