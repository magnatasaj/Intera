/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.interativaconsultoria.dao;

import com.interativaconsultoria.funcao.Cores;
import com.interativaconsultoria.objetos.Despesa;
import com.interativaconsultoria.objetos.Despesa_Niveis;
import com.interativaconsultoria.objetos.Receita;
import com.interativaconsultoria.objetos.ReceitaOrigem;
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
public class DaoReceita {

    private PreparedStatement ps = null;

    private PreparedStatement ps2 = null;
    private ResultSet rs = null;
    private ResultSet rs2 = null;

    private Jdbc con = new Jdbc();
    private Connection conexao;

    public DaoReceita() throws SQLException, ClassNotFoundException {
        this.conexao = con.criarconexcao();
    }

    public void Adicionar_Receita(Receita Re) throws SQLException {

        String sql = "INSERT INTO `receita` (`valor`, `data`, `origem`, `vendido_recebido`, `debito_credito`, `descricao`) VALUES (?, ?, ?, ?, ?, ?);";
        ps = conexao.prepareStatement(sql);
        ps.setBigDecimal(1, Re.getValor());
        ps.setDate(2, new java.sql.Date(Re.getData().getTime()));
        ps.setInt(3, Re.getReceita_origem().getId());
        ps.setInt(4, Re.getVendido_recebido());
        ps.setInt(5, Re.getDebito_credito());
        ps.setString(6, Re.getDescricao());
        ps.execute();
        ps.close();

    }

    public void Editar_Receita(Receita Re) throws SQLException {

        String sql = "UPDATE `receita` SET `valor` = ?, `data` = ?, `origem` = ?, `vendido_recebido` = ?, `debito_credito` = ?, `descricao` = ? WHERE `receita`.`id` = ?;";
        ps = conexao.prepareStatement(sql);
        ps.setBigDecimal(1, Re.getValor());
        ps.setDate(2, new java.sql.Date(Re.getData().getTime()));
        ps.setInt(3, Re.getReceita_origem().getId());
        ps.setInt(4, Re.getVendido_recebido());
        ps.setInt(5, Re.getDebito_credito());
        ps.setString(6, Re.getDescricao());
        ps.setInt(7, Re.getId());
        ps.executeUpdate();
        ps.close();

    }

    public void Excluir_Receita(Receita Re) throws SQLException {

        String sql = "DELETE FROM `receita` WHERE `receita`.`id` = ?";

        ps = conexao.prepareStatement(sql);
        ps.setInt(1, Re.getId());
        ps.execute();
        ps.close();

    }

    public String Gerar_Grafico_receita(String ano) throws SQLException {

        String dados = "";
        for (int i = 1; i <= 12; i++) {
            if (i == 12) {
                dados += Consultar_Receita_mes(i, ano);
            } else {
                dados += Consultar_Receita_mes(i, ano) + ",";
            }
        }

        ps.close();
        return dados;
    }

    public List<Receita> Consultar_Receita_all(String valor, int op) throws SQLException, ParseException {

        if (op == 1) {
            valor = valor.replace(".", "");
            valor = valor.replace(",", ".");
            valor = valor.replace(".00", "");
            System.out.println("valor:" + valor);
            String sql = "SELECT data,nome_origem,receita.id,vendido_recebido,debito_credito,valor, descricao,receita_origem.id as id_tb_origem FROM `receita`,`receita_origem` WHERE `valor` LIKE '%" + valor + "%' and origem = receita_origem.id";
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

            String sql = "SELECT data,nome_origem,receita.id,vendido_recebido,debito_credito,valor, descricao, receita_origem.id as id_tb_origem  FROM `receita`,`receita_origem`  WHERE `data` BETWEEN ? AND ? and origem = receita_origem.id";
            ps = conexao.prepareStatement(sql);
            ps.setDate(1, new java.sql.Date(date1.getTime()));
            ps.setDate(2, new java.sql.Date(date2.getTime()));
            rs = ps.executeQuery();
        }
        if (op == 3) {
            String sql = "SELECT data,nome_origem,receita.id,vendido_recebido,debito_credito,valor, descricao,receita_origem.id as id_tb_origem FROM `receita`,`receita_origem` WHERE `descricao` LIKE ? and origem = receita_origem.id";
            ps = conexao.prepareStatement(sql);
            ps.setString(1, "%" + valor + "%");
            rs = ps.executeQuery();
        }
        List<Receita> ls = new ArrayList();
        while (rs.next()) {
            ReceitaOrigem or = new ReceitaOrigem();
            or.setId(rs.getInt("id_tb_origem"));
            or.setNome(rs.getString("nome_origem"));

            Receita Obr = new Receita();
            Obr.setId(rs.getInt("id"));
            Obr.setReceita_origem(or);
            Obr.setDebito_credito(rs.getInt("debito_credito"));
            Obr.setVendido_recebido(rs.getInt("vendido_recebido"));
            Obr.setData(rs.getDate("data"));
            Obr.setValor(rs.getBigDecimal("valor"));
            Obr.setDescricao(rs.getString("descricao"));
            ls.add(Obr);
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

    public List Consultar_Receita_mes_atual() throws SQLException {
        String sql = "SELECT receita.*, receita_origem.id as id_tb_origem, receita_origem.nome_origem FROM `receita`, receita_origem WHERE MONTH(data) = MONTH(now()) and origem = receita_origem.id ORDER BY `receita`.`data` DESC";
        ps = conexao.prepareStatement(sql);
        rs = ps.executeQuery();
        BigDecimal total = new BigDecimal("0");
        BigDecimal re = new BigDecimal("0");
        List<Receita> de = new ArrayList();
        while (rs.next()) {
            ReceitaOrigem or = new ReceitaOrigem();
            or.setId(rs.getInt("id_tb_origem"));
            or.setNome(rs.getString("nome_origem"));

            Receita Obr = new Receita();
            Obr.setId(rs.getInt("id"));
            Obr.setReceita_origem(or);
            Obr.setDebito_credito(rs.getInt("debito_credito"));
            Obr.setVendido_recebido(rs.getInt("vendido_recebido"));
            Obr.setData(rs.getDate("data"));
            Obr.setValor(rs.getBigDecimal("valor"));
            Obr.setDescricao(rs.getString("descricao"));
            de.add(Obr);

        }

        rs.close();

        return de;
    }

    public BigDecimal Consultar_Receita_mes(int mes, String ano) throws SQLException {
        String sql = "SELECT SUM(valor) as total FROM `receita` WHERE MONTH(data) = MONTH('" + ano + "-" + mes + "-30') and YEAR(data) = YEAR('" + ano + "-" + mes + "-30')";
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

    public String Consultar_Despesa_mes_e_vendido(int vendido, String ano) throws SQLException {
        BigDecimal total = new BigDecimal("0");
        BigDecimal re = new BigDecimal("0");
        String res = "";
        for (int i = 1; i <= 12; i++) {
            String sql = "SELECT SUM(valor) as total FROM `receita` WHERE MONTH(data) = MONTH('" + ano + "-" + i + "-31') AND YEAR(data) = YEAR('" + ano + "-" + i + "-31') AND (vendido_recebido = " + vendido + " or debito_credito = 1)";
            ps = conexao.prepareStatement(sql);
            rs = ps.executeQuery();
            String sql2 = "SELECT SUM(valor) as total FROM `receita` WHERE MONTH(data) = MONTH('" + ano + "-" + i + "-31') AND YEAR(data) = YEAR('" + ano + "-" + i + "-31') AND (vendido_recebido = 2 or debito_credito = 1)";
            ps2 = conexao.prepareStatement(sql2);
            rs2 = ps2.executeQuery();

            while (rs.next()) {
                if (rs.getString("total") != null) {
                    String valor = rs.getBigDecimal("total").toString();
                    re = total.add(new BigDecimal(valor));
                    if (i == 12) {
                        res += re;
                    } else {
                        res += re + ",";
                    }

                } else if (rs2.next()) {
                    if (rs2.getString("total") != null) {
                        String valor = rs2.getBigDecimal("total").toString();
                        re = total.add(new BigDecimal(valor));
                        if (i == 12) {
                            res += re;
                        } else {
                            res += re + ",";
                        }
                    } else {
                        if (i == 12) {
                            res += "null";
                        } else {
                            res += "null,";
                        }
                    }
                }

            }
        }
        rs.close();

        return res;
    }

    public String Consultar_Despesa_mes_e_vendido_normal(int vendido,String ano) throws SQLException {
        BigDecimal total = new BigDecimal("0");
        BigDecimal re = new BigDecimal("0");
        String res = "";
        for (int i = 1; i <= 12; i++) {
            String sql = "SELECT SUM(valor) as total FROM `receita` WHERE MONTH(data) = MONTH('"+ano+"-" + i + "-01') AND YEAR(data) = YEAR('"+ano+"-" + i + "-01') AND (vendido_recebido = " + vendido + " or debito_credito = 1)";
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
                        res += "null";
                    } else {
                        res += "null,";
                    }
                }

            }
        }
        rs.close();

        return res;
    }
    
    public String Consultar_receita_mes_menos_despesa(int vendido, String ano) throws SQLException, ClassNotFoundException {
        DaoDespesa ddesDaoDespesa = new DaoDespesa();
        BigDecimal total = new BigDecimal("0");
        BigDecimal re = new BigDecimal("0");
        BigDecimal re2 = new BigDecimal("0");

        String res = "";

        //laço para percorrer os 12 meses
        for (int i = 1; i <= 12; i++) {

            //consulta para recebido
            String sql = "SELECT SUM(valor) as total FROM `receita` WHERE MONTH(data) = MONTH('" + ano + "-" + i + "-31') AND YEAR(data) = YEAR('" + ano + "-" + i + "-31') AND (vendido_recebido = " + vendido + " or debito_credito = 1)";
            ps = conexao.prepareStatement(sql);
            rs = ps.executeQuery();
            //consulta para vendido
            String sql2 = "SELECT SUM(valor) as total FROM `receita` WHERE MONTH(data) = MONTH('" + ano + "-" + i + "-31') AND YEAR(data) = YEAR('" + ano + "-" + i + "-31') AND (vendido_recebido = 2 or debito_credito = 1)";
            ps2 = conexao.prepareStatement(sql2);
            rs2 = ps2.executeQuery();
            ResultSet rr = rs;

            //percorer recebido 
            while (rr.next()) {
                //se total foi diferente de null
                if (rr.getString("total") != null) {
                    String valor = rr.getBigDecimal("total").toString();
                    re = total.add(new BigDecimal(valor));

                    re2 = re.subtract(ddesDaoDespesa.Consultar_Despesa_mes(i, ano));
                    //concaterna resultados para o data do gráfico
                    if (i == 12) {
                        res += re2;
                    } else {
                        res += re2 + ",";
                    }
                    //caso rs total seja null, ele verifica se vendido não é null  
                } else if (rs2.next()) {
                    //verificando se vendido  é diferente de null
                    if (rs2.getString("total") != null) {
                        String valor = rs2.getBigDecimal("total").toString();
                        re = total.add(new BigDecimal(valor));

                        re2 = re.subtract(ddesDaoDespesa.Consultar_Despesa_mes(i, ano));
                        if (i == 12) {
                            res += re2;
                        } else {
                            res += re2 + ",";
                        }
                        //caso rs2 tmabém sejá null ele seta null nos valores do gráfico
                    } else {
                        if (i == 12) {
                            res += "null";
                        } else {
                            res += "null,";
                        }
                    }
                }

            }
        }
        rs.close();
        rs2.close();

        return res;
    }

    public String Consultar_Despesa_mes_e_f(int vendido, String ano) throws SQLException {
        BigDecimal total = new BigDecimal("0");
        BigDecimal re = new BigDecimal("0");
        String res = "";
        for (int i = 1; i <= 12; i++) {
            String sql = "SELECT SUM(valor)  as total FROM `receita` WHERE MONTH(data) = MONTH('" + ano + "-" + i + "-01') AND YEAR(data) = YEAR('" + ano + "-" + i + "-01') AND vendido_recebido =" + vendido + "";
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
                        res += "null";
                    } else {
                        res += "null,";
                    }
                }

            }
        }
        rs.close();

        return res;
    }

    public String Consultar_Despesa_mes_e_origem(int id, String ano) throws SQLException {
        BigDecimal total = new BigDecimal("0");
        BigDecimal re = new BigDecimal("0");
        String res = "";
        for (int i = 1; i <= 12; i++) {
            String sql = "SELECT SUM(valor) as total FROM `receita` WHERE MONTH(data) = MONTH('2016-" + i + "-01') AND YEAR(data) = YEAR('" + ano + "-" + i + "-01') AND origem = " + id + "";
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
                        res += "null";
                    } else {
                        res += "null,";
                    }
                }

            }
        }
        rs.close();

        return res;
    }

    public String Receita_Grafico_vendido(int rv, String ano) throws SQLException, ClassNotFoundException {
        DaoReceitaOrigem obj = new DaoReceitaOrigem();

        Cores c = new Cores();
        List<Color> cores = c.gerarCores(100);
        List<String> coresHexa = c.gerarCoresHexadecimal(cores);

        String dataset = "";

        String resultado = "";
        switch (rv) {
            case 1:
                resultado = "Recebido";
                break;
            case 2:
                resultado = "Vendido";
                break;

        }

        if (!Consultar_Despesa_mes_e_vendido(rv, ano).equals(",,,,,,,,,,")) {

            dataset += "{\n"
                    + "                        name: \"" + resultado + "\",\n"
                    + "                                 data :[" + Consultar_Despesa_mes_e_vendido_normal(rv, ano) + "]"
                    + "                        }";

        }

        return dataset;
    }

    public String Receita_Grafico_vendido_menos_despesas(int rv, String ano) throws SQLException, ClassNotFoundException {
        DaoReceitaOrigem obj = new DaoReceitaOrigem();

        Cores c = new Cores();
        List<Color> cores = c.gerarCores(100);
        List<String> coresHexa = c.gerarCoresHexadecimal(cores);

        String dataset = "";

        String resultado = "";
        switch (rv) {
            case 1:
                resultado = "Recebido";
                break;
            case 2:
                resultado = "Vendido";
                break;

        }

        if (!Consultar_Despesa_mes_e_vendido(rv, ano).equals(",,,,,,,,,,,")) {

            dataset += "{\n"
                    + "                        name: 'Receita - Despesa',\n"
                    + "                                 data :[" + Consultar_receita_mes_menos_despesa(rv, ano) + "]"
                    + "                        }";

        }

        return dataset;
    }

    public String Receita_Grafico_Credito_futuro(int rv, String ano) throws SQLException, ClassNotFoundException {
        DaoReceitaOrigem obj = new DaoReceitaOrigem();

        Cores c = new Cores();
        List<Color> cores = c.gerarCores(100);
        List<String> coresHexa = c.gerarCoresHexadecimal(cores);

        String dataset = "";

        String resultado = "";
        switch (rv) {
            case 1:
                resultado = "Á vista";
                break;
            case 2:
                resultado = "Futuro";
                break;

        }

        if (!Consultar_Despesa_mes_e_vendido(rv, ano).equals("null,null,null,null,null,null,null,null,null,null,null,null")) {

            dataset += "{\n"
                    + "                        name: \"" + resultado + "\",\n"
                    + "                                 data :[" + Consultar_Despesa_mes_e_f(rv, ano) + "]"
                    + "                        }";

        }

        return dataset;
    }

    public String Receita_Grafico_Origens(String ano) throws SQLException, ClassNotFoundException {
        DaoReceitaOrigem obj = new DaoReceitaOrigem();
        List<ReceitaOrigem> lista = obj.Consultar_Todas_Origens();

        Cores c = new Cores();
        List<Color> cores = c.gerarCores(100);
        List<String> coresHexa = c.gerarCoresHexadecimal(cores);

        String dataset = "";
        int i = 0;
        String corfi = "";
        for (ReceitaOrigem dd : lista) {
            String idarray = "";
            String data = "";
            i++;
            //Gerar estrutura para o grafico nivel 2

            dataset += "{\n"
                    + "                        name: '" + dd.getNome() + "',\n"
                    + "                                 data :[" + Consultar_Despesa_mes_e_origem(dd.getId(), ano) + "]"
                    + "                        },";

        }
        String datasetcorrigido = dataset.substring(0, dataset.length() - 1);

        return datasetcorrigido;
    }

}
