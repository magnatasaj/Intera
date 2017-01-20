package com.interativaconsultoria.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Jdbc1 {
    private static Connection con;
    public static Connection criarconexcao() throws SQLException, ClassNotFoundException {
        
        
        if(con == null){
        String dbName = Propriedade.getDb();
            System.out.println("nome:"+dbName);
        String userName = Propriedade.getUser();
        String password = Propriedade.getSenha();
        String hostname = Propriedade.getHost();
        String port = Propriedade.getPorta();
        String jdbcUrl = "jdbc:mysql://" + hostname + ":"
                + port + "/" + dbName + "?user=" + userName + "&password=" + password+"&autoReconnect=true";
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection(jdbcUrl);
        }else{
          if(con.isClosed()){
              String dbName = Propriedade.getDb();
            System.out.println("nome:"+dbName);
        String userName = Propriedade.getUser();
        String password = Propriedade.getSenha();
        String hostname = Propriedade.getHost();
        String port = Propriedade.getPorta();
        String jdbcUrl = "jdbc:mysql://" + hostname + ":"
                + port + "/" + dbName + "?user=" + userName + "&password=" + password+"&autoReconnect=true";
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection(jdbcUrl);
          }  
        }
        return con;
        
        
    }
    
    
    
    public void fechar() throws SQLException{
        //con.close();
    }
}
