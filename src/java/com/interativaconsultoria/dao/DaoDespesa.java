/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.interativaconsultoria.dao;

import com.interativaconsultoria.funcao.Cores;
import com.interativaconsultoria.objetos.Despesa;
import com.interativaconsultoria.objetos.Despesa_Niveis;
import java.awt.Color;
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
    
    public void Excluir_Despesa(Despesa De) throws SQLException {

        String sql = "DELETE FROM `despesa` WHERE `despesa`.`id` = ?";

        ps = conexao.prepareStatement(sql);
        ps.setInt(1, De.getId());
        ps.execute();
        ps.close();

    }

    public String Gerar_Grafico_despesa(String ano) throws SQLException {

        String dados = "";
        for (int i = 1; i <= 12; i++) {
            if (i == 12) {
                dados += Consultar_Despesa_mes(i,ano);
            } else {
                dados += Consultar_Despesa_mes(i,ano) + ",";
            }
        }

        ps.close();
        return dados;
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
            if (rs.getString("total") != null) {
                String valor = rs.getBigDecimal("total").toString();
                System.out.println("valor:" + valor);

                re = total.add(new BigDecimal(valor));
            }

        }

        rs.close();
        System.out.println("total:" + re);

        return re;
    }

    public BigDecimal Consultar_Despesa_mes(int mes,String ano) throws SQLException {
        String sql = "SELECT SUM(valor) as total FROM `despesa` WHERE MONTH(data) = MONTH('2016-" + mes + "-01') AND YEAR(data) = YEAR('"+ano+"-" + mes + "-01')";
        ps = conexao.prepareStatement(sql);
        rs = ps.executeQuery();
        BigDecimal total = new BigDecimal("0");
        BigDecimal re = new BigDecimal("0");
        while (rs.next()) {
            if (rs.getString("total") != null) {
                String valor = rs.getBigDecimal("total").toString();

                re = total.add(new BigDecimal(valor));
            }

        }

        rs.close();
        return re;
    }

    public String Consultar_Despesa_mes_e_nivel(int id_nivel,String ano) throws SQLException {
        BigDecimal total = new BigDecimal("0");
        BigDecimal re = new BigDecimal("0");
        String res = "";
        for (int i = 1; i <= 12; i++) {
            String sql = "SELECT SUM(valor) as total FROM `despesa` WHERE MONTH(data) = MONTH('2016-" + i + "-01') AND YEAR(data) = YEAR('"+ano+"-" + i + "-01') AND id_nivel = " + id_nivel + "";
            ps = conexao.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                if (rs.getString("total") != null) {
                    String valor = rs.getBigDecimal("total").toString();
                    re = total.add(new BigDecimal(valor));
                    if (i == 12) {
                        res += re;
                    } else {
                        res += re + ",";
                    }

                } else {
                    if (i == 12) {
                        res += "";
                    } else {
                        res += ",";
                    }
                }

            }
        }
        rs.close();

        return res;
    }

    public String Consultar_Despesa_mes_e_nivel2(String id_nivel_array,String ano) throws SQLException {
        BigDecimal total = new BigDecimal("0");
        BigDecimal re = new BigDecimal("0");
        String res = "";
        for (int i = 1; i <= 12; i++) {
            String sql = "SELECT SUM(valor) as total FROM `despesa` WHERE MONTH(data) = MONTH('2016-" + i + "-01') AND YEAR(data) = YEAR('"+ano+"-" + i + "-01') AND id_nivel in(" + id_nivel_array + ")";
            ps = conexao.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                if (rs.getString("total") != null) {
                    String valor = rs.getBigDecimal("total").toString();
                    re = total.add(new BigDecimal(valor));
                    if (i == 12) {
                        res += re;
                    } else {
                        res += re + ",";
                    }

                } else {
                    if (i == 12) {
                        res += "";
                    } else {
                        res += ",";
                    }
                }

            }
        }
        rs.close();

        return res;
    }

    public String Despesa_Grafico_nivel(String ano) throws SQLException, ClassNotFoundException {
        DaoDespesaNivel obj = new DaoDespesaNivel();
        List<Despesa_Niveis> lista = obj.Consultar_Nivel_Final();
        int i = 0;

        Cores c = new Cores();
        List<Color> cores = c.gerarCores(100);
        List<String> coresHexa = c.gerarCoresHexadecimal(cores);

        String dataset = "";
        for (Despesa_Niveis d : lista) {
            String corfi = "";

            i++;
            if (!Consultar_Despesa_mes_e_nivel(d.getId(),ano).equals(",,,,,,,,,,,")) {
                if (lista.size() == i) {
                    dataset += "{\n"
                            + "                        label: \"" + d.getNome() + "\",\n"
                            + "                                strokeColor: \"" + coresHexa.get(i) + "\",\n"
                            + "                                pointColor: \"" + coresHexa.get(i) + "\",\n"
                            + "                                pointStrokeColor: \"" + coresHexa.get(i) + "\",\n"
                            + "                                pointHighlightFill: \"" + coresHexa.get(i) + "\",\n"
                            + "                                pointBorderWidth: 50,\n"
                            + "                                pointHighlightStroke: \"rgba(220,220,220,1)\",\n"
                            + "                                 data :[" + Consultar_Despesa_mes_e_nivel(d.getId(),ano) + "]"
                            + "                        }";

                } else {
                    dataset += "{\n"
                            + "                        label: \"" + d.getNome() + "\",\n"
                            + "                                fillColor: \"" + coresHexa.get(i) + "\",\n"
                            + "                                strokeColor: \"" + coresHexa.get(i) + "\",\n"
                            + "                                pointColor: \"" + coresHexa.get(i) + "\",\n"
                            + "                                pointStrokeColor: \"#c1c7d1\",\n"
                            + "                                pointHighlightFill: \"#fff\",\n"
                            + "                              pointBorderWidth: 6.5,\n"
                            + "                                pointHighlightStroke: \"rgba(220,220,220,1)\",\n"
                            + "                                 data :[" + Consultar_Despesa_mes_e_nivel(d.getId(), ano) + "]"
                            + "                        },";

                }
            }
        }

        return dataset;
    }

    public String Despesa_Grafico_nivel2(String ano) throws SQLException, ClassNotFoundException {
        DaoDespesaNivel obj = new DaoDespesaNivel();
        List<Despesa_Niveis> lista = obj.Consultar_Nivel_Final();
       
        Cores c = new Cores();
        List<Color> cores = c.gerarCores(100);
        List<String> coresHexa = c.gerarCoresHexadecimal(cores);

        String dataset = "";
        int i = 0;
        String corfi = "";
        for (Despesa_Niveis dd : obj.Consultar_Nivel_2()) {
            String idarray = "";
            String data = "";
            i++;
            for (Despesa_Niveis d : lista) {
                if (d.getPai() == dd.getId()) {
                    idarray += d.getId() + ",";
                }
            }
            String arraycorrigido = "";
            if (idarray.length() > 0) {
                arraycorrigido = idarray.substring(0, idarray.length() - 1);
            } else {
                arraycorrigido = "0";
            }
            
            //Gerar estrutura para o grafico nivel 2
            
                   dataset += "{\n"
                            + "                        label: \"" + dd.getNome() + "\",\n"
                            + "                                fillColor: \"" + coresHexa.get(i) + "\",\n"
                            + "                                strokeColor: \"" + coresHexa.get(i) + "\",\n"
                            + "                                pointColor: \"" + coresHexa.get(i) + "\",\n"
                            + "                                pointStrokeColor: \"#c1c7d1\",\n"
                            + "                                pointHighlightFill: \"#fff\",\n"
                            + "                              pointBorderWidth: 6.5,\n"
                            + "                                pointHighlightStroke: \"rgba(220,220,220,1)\",\n"
                            + "                                 data :[" + Consultar_Despesa_mes_e_nivel2(arraycorrigido,ano) + "]"
                            + "                        },";

              
            

        }
        String datasetcorrigido = dataset.substring(0,dataset.length() - 1);

        return datasetcorrigido;
    }

}
