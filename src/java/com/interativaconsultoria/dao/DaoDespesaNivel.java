/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.interativaconsultoria.dao;

import com.interativaconsultoria.objetos.Despesa_Niveis;
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
public class DaoDespesaNivel {

    private PreparedStatement ps = null;
    private PreparedStatement ps2 = null;
    private ResultSet rs = null;
    private Jdbc con = new Jdbc();
    private Connection conexao;
    private String tbp;

    public DaoDespesaNivel(String tb) throws SQLException, ClassNotFoundException {
        this.tbp = tb;
        this.conexao = con.criarconexcao();
    }
     public void fechar() throws SQLException{
        con.fechar();
    
    }

    public void Adicionar_Nivel_Pai(Despesa_Niveis De) throws SQLException {

        String sql = "INSERT INTO `"+tbp+"despesa_niveis` (`id`, `nome`, `pai`, `ordem`) VALUES (NULL,?, 0,?)";

        ps = conexao.prepareStatement(sql);
        ps.setString(1, De.getNome());
        ps.setInt(2, De.getOrdem());
        ps.execute();
        ps.close();

    }

    public void Adicionar_Nivel_1(Despesa_Niveis De) throws SQLException {

        String sql = "INSERT INTO `"+tbp+"despesa_niveis` (`id`, `nome`, `pai`, `ordem`) VALUES (NULL,?, ?,?)";

        ps = conexao.prepareStatement(sql);
        ps.setString(1, De.getNome());
        ps.setInt(2, De.getPai());
        ps.setInt(3, De.getOrdem());
        ps.execute();
        ps.close();

    }

    public List<Despesa_Niveis> Consultar_Todos_Nivel() throws SQLException {

        String sql = "SELECT * FROM `"+tbp+"despesa_niveis` ORDER BY `"+tbp+"despesa_niveis`.`ordem` ASC";
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
    
     public List<Despesa_Niveis> Consultar_Nivel_1() throws SQLException {
       List<Despesa_Niveis> ls = Consultar_Todos_Nivel();
        List<Despesa_Niveis> re = new ArrayList();
        for (Despesa_Niveis d : ls) {
            if (d.getPai() == 0) {
                
                       re.add(d);
                   
                }

            
        }
        return re;
    }

    public List<Despesa_Niveis> Consultar_Nivel_Final() throws SQLException {
        List<Despesa_Niveis> ls = Consultar_Todos_Nivel();
        List<Despesa_Niveis> re = new ArrayList();
        for (Despesa_Niveis d : ls) {
            if (d.getPai() == 0) {
                for (Despesa_Niveis d2 : ls) {
                    if (d2.getPai() == d.getId()) {
                        for (Despesa_Niveis d3 : ls) {
                            if (d3.getPai() == d2.getId()) {
                                re.add(d3);
                            }
                        }
                    }
                }

            }
        }
        return re;
    }
    public List<Despesa_Niveis> Consultar_Nivel_2() throws SQLException {
        List<Despesa_Niveis> ls = Consultar_Todos_Nivel();
        List<Despesa_Niveis> re = new ArrayList();
        for (Despesa_Niveis d : ls) {
            if (d.getPai() == 0) {
                for (Despesa_Niveis d2 : ls) {
                    if (d2.getPai() == d.getId()) {
                       re.add(d2);
                    }
                }

            }
        }
        return re;
    }
    

    public List<Despesa_Niveis> Consultar_Nivel_Pai() throws SQLException {

        String sql = "SELECT * FROM `"+tbp+"despesa_niveis`  ORDER BY `"+tbp+"despesa_niveis`.`ordem` ASC";
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

        String sql = "SELECT * FROM `"+tbp+"despesa_niveis` where pai = " + id + " ORDER BY `"+tbp+"despesa_niveis`.`ordem` ASC";
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

        String sql = "UPDATE `"+tbp+"despesa_niveis` SET `nome` = ?, `ordem` = ?  WHERE `"+tbp+"despesa_niveis`.`id` =?;";

        ps = conexao.prepareStatement(sql);
        ps.setString(1, De.getNome());
        ps.setInt(2, De.getOrdem());
        ps.setInt(3, De.getId());
        ps.executeUpdate();
        ps.close();

    }

    public void Excluir_Nivel(Despesa_Niveis De) throws SQLException {

        String sql = "DELETE FROM `"+tbp+"despesa_niveis` WHERE `"+tbp+"despesa_niveis`.`id` =? ";

        ps = conexao.prepareStatement(sql);
        ps.setInt(1, De.getId());
        ps.execute();
        ps.close();

    }
}
