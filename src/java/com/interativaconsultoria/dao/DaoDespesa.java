/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.interativaconsultoria.dao;

import com.interativaconsultoria.objetos.Despesa;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.regex.Pattern;

/**
 *
 * @author lubuntu
 */
public class DaoDespesa {

    private PreparedStatement ps = null;
    private PreparedStatement ps2 = null;
    private ResultSet rs = null;
    private Jdbc con = new Jdbc();
    private Connection conexao;

    public DaoDespesa() throws SQLException, ClassNotFoundException {
        this.conexao = con.criarconexcao();
    }

    public void Adicionar_Despesa(Despesa De) throws SQLException {

        String sql = "INSERT INTO `despesa` (`id`, `valor`, `data`, `id_nivel`,`descricao`) VALUES (NULL, ?, ?, ?,?);";
        java.util.Date d = De.getData();
        ps = conexao.prepareStatement(sql);
        ps.setBigDecimal(1, De.getValor());
        ps.setDate(2, new java.sql.Date(De.getData().getTime()));
        ps.setInt(3, De.getId_nivel());
        ps.setString(4, De.getDescricao());
        ps.execute();
        ps.close();

    }

    public void Editar_Despesa(Despesa De) throws SQLException {

        String sql = "UPDATE `despesa` SET `valor` = ?, `data` = ?, `descricao` = ? WHERE `despesa`.`id` = ?;";

        ps = conexao.prepareStatement(sql);
        ps.setBigDecimal(1, De.getValor());
        ps.setDate(2, new java.sql.Date(De.getData().getTime()));
        ps.setString(3, De.getDescricao());
        ps.setInt(4, De.getId());
        ps.executeUpdate();
        ps.close();

    }

    public List<Despesa> Consultar_Despesa_all(String valor, int op) throws SQLException, ParseException {

        if (op == 1) {
            valor = valor.replace(".", "");
            valor = valor.replace(",", ".");
            valor = valor.replace(".00", "");
            System.out.println("valor:" + valor);
            String sql = "SELECT data,nome,id_nivel,despesa.id,valor, descricao FROM `despesa`,`despesa_niveis` WHERE `valor` LIKE '%" + valor + "%' and id_nivel = despesa_niveis.id";
            ps = conexao.prepareStatement(sql);
            rs = ps.executeQuery();
        }
        if (op == 2) {
            String data[];
            data = valor.split(Pattern.quote("-"));

            DateFormat formatter;
            Date date1;
            Date date2;
            formatter = new SimpleDateFormat("dd/MM/yyyy");
            date1 = (Date) formatter.parse(data[0]);
            date2 = (Date) formatter.parse(data[1]);

            String sql = "SELECT data,nome,id_nivel,despesa.id,valor, descricao FROM `despesa`,`despesa_niveis` WHERE `data` BETWEEN ? AND ? and id_nivel = despesa_niveis.id";
            ps = conexao.prepareStatement(sql);
            ps.setDate(1, new java.sql.Date(date1.getTime()));
            ps.setDate(2, new java.sql.Date(date2.getTime()));
            rs = ps.executeQuery();
        }
        if (op == 3) {
            String sql = "SELECT data,nome,id_nivel,despesa.id,valor, descricao FROM `despesa`,`despesa_niveis` WHERE `descricao` LIKE ? and id_nivel = despesa_niveis.id";
            ps = conexao.prepareStatement(sql);
            ps.setString(1, "%" + valor + "%");
            rs = ps.executeQuery();
        }
        List<Despesa> ls = new ArrayList();
        while (rs.next()) {
            Despesa Obs = new Despesa();
            Obs.setId(rs.getInt("id"));
            Obs.setValor(rs.getBigDecimal("valor"));
            Obs.setData(rs.getDate("data"));
            Obs.setDescricao(rs.getString("descricao"));
            Obs.setNome_despesa(rs.getString("nome"));
            ls.add(Obs);
        }

        rs.close();
        return ls;
    }

    public List<Despesa> Consultar_Despesa_pelo_nivel(int id) throws SQLException {

        String sql = "SELECT * FROM `despesa` WHERE `id_nivel` = " + id + " ORDER BY `despesa`.`data` DESC";
        ps = conexao.prepareStatement(sql);
        rs = ps.executeQuery();
        List<Despesa> ls = new ArrayList();
        while (rs.next()) {
            Despesa Obs = new Despesa();
            Obs.setId(rs.getInt("id"));
            Obs.setValor(rs.getBigDecimal("valor"));
            Obs.setData(rs.getDate("data"));
            Obs.setDescricao(rs.getString("descricao"));
            ls.add(Obs);
        }

        rs.close();
        return ls;
    }

    public BigDecimal Consultar_Despesa_mes_atual(int id_nivel) throws SQLException {
        String sql = "SELECT SUM(valor) as total FROM `despesa` WHERE MONTH(data) = MONTH(now()) AND id_nivel = " + id_nivel + "";
        ps = conexao.prepareStatement(sql);
        rs = ps.executeQuery();
        BigDecimal total = new BigDecimal("0");
        BigDecimal re = new BigDecimal("0");
        while (rs.next()) {
           if(rs.getString("total") != null){
               String valor = rs.getBigDecimal("total").toString();
                       System.out.println("valor:" +valor);

             re =  total.add(new BigDecimal(valor));
           }

        }

        rs.close();
        System.out.println("total:" +re);

        return re;
    }

}
