package com.library.awa;

import com.library.awa.database.DatabaseConnection;

import java.sql.Connection;
import java.sql.SQLException;

public class TestDatabaseConnection {
    public static void main(String[] args) {
        try (Connection conn = DatabaseConnection.getConnection()) {
            System.out.println("数据库连接成功！");
        } catch (SQLException e) {
            System.err.println("数据库连接失败：" + e.getMessage());
        }
    }
}