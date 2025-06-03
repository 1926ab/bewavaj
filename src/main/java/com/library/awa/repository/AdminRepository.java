package com.library.awa.repository;

import com.library.awa.database.DatabaseConnection;

import java.sql.*;

public class AdminRepository {
    // 验证管理员登录
    public boolean validateAdminLogin(String username, String password) {
        String sql = "SELECT * FROM Admins WHERE username = ? AND password = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            stmt.setString(2, password);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next(); // 如果有结果，则登录成功
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}