package com.library.awa.dao;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

public interface DAO {
    // 获取数据源
    private static DataSource getDataSource() {
        DataSource dataSource = null;
        try {
            Context context = new InitialContext();
            dataSource = (DataSource) context.lookup("java:comp/env/jdbc/elearningDS");
        } catch (NamingException ne) {
            System.out.println("异常: " + ne);
        }
        return dataSource;
    }

    // 获取数据库连接
    static Connection getConnection() throws SQLException {
        DataSource dataSource = getDataSource();
        Connection conn = null;
        try {
            conn = dataSource.getConnection();
        } catch (SQLException sqle) {
            System.out.println("异常: " + sqle);
        }
        return conn;
    }
}