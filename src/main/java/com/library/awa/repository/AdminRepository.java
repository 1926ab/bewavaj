package com.library.awa.repository;

import com.library.awa.model.Admin;
import com.library.awa.dao.DAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AdminRepository {

    // 验证admin登录
    public boolean validateAdminLogin(String username, String password) {
        String sql = "SELECT 1 FROM Admins WHERE username = ? AND password = ?";
        try (Connection conn = DAO.getConnection();
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

    // 检查用户是否已注册
    public boolean isEmailRegistered(String username) {
        String sql = "SELECT 1 FROM Admins WHERE username = ?";
        try (Connection conn = DAO.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next(); // 如果有结果，则邮箱已注册
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // 获取所有管理员信息
    public List<Admin> getAllAdmin() {
        List<Admin> admins = new ArrayList<>();
        String sql = "SELECT id, username, password FROM Admins";
        try (Connection conn = DAO.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                admins.add(new Admin(rs.getString("id"), rs.getString("username"), rs.getString("password")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return admins;
    }
}