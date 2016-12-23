package com.interativaconsultoria.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Jdbc {
    private  Connection con = null;
    public  Connection criarconexcao() throws SQLException, ClassNotFoundException {
        if(con==null){
        String dbName = "sistema";
        String userName = "root";
        String password = "semanaacademica";
        //String password = "";
        String hostname = "127.0.0.1";
        String port = "3306";
        String jdbcUrl = "jdbc:mysql://" + hostname + ":"
                + port + "/" + dbName + "?user=" + userName + "&password=" + password;
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection(jdbcUrl);
        }
        return con;
        
    }
}
