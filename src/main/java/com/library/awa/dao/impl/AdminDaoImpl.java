package com.library.awa.dao.impl;

import com.library.awa.dao.AdminDao;
import com.library.awa.model.Admin;
import com.library.awa.dao.DAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AdminDaoImpl implements AdminDao {

    // 添加管理员
    @Override
    public int addAdmin(Admin admin) throws SQLException {
        String sql = "INSERT INTO Admins (id,username,password) VALUES (?, ?, ?,)";
        try (Connection conn = DAO.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, admin.getId());
            stmt.setString(2, admin.getUsername());
            stmt.setString(3, admin.getPassword());
            return stmt.executeUpdate();
        }
    }

    // 检查邮箱是否已注册
    @Override
    public boolean isIdRegistered(String id) throws SQLException {
        String sql = "SELECT 1 FROM Admins WHERE id = ?";
        try (Connection conn = DAO.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        }
    }

    // 检查用户名是否已存在
    @Override
    public boolean isUsernameTaken(String username) throws SQLException {
        String sql = "SELECT 1 FROM Admins WHERE username = ?";
        try (Connection conn = DAO.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        }
    }

    // 验证管理员登录
    @Override
    public boolean validateAdminLogin(String username, String password) {
        String sql = "SELECT 1 FROM Admins WHERE username = ? AND password = ?";
        try (Connection conn = DAO.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            stmt.setString(2, password);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // 获取所有管理员
    @Override
    public List<Admin> findAllAdmins() {
        List<Admin> admins = new ArrayList<>();
        String sql = "SELECT id, username, password FROM Admins";
        try (Connection conn = DAO.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                admins.add(new Admin(
                        rs.getString("id"),
                        rs.getString("username"),
                        rs.getString("password")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return admins;
    }

    // 根据ID查找管理员
    @Override
    public Admin findAdminById(int id) {
        String sql = "SELECT id,username,password FROM Admins WHERE id = ?";
        try (Connection conn = DAO.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Admin(
                            rs.getString("id"),
                            rs.getString("username"),
                            rs.getString("email")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // 更新管理员信息
    @Override
    public int updateAdmin(Admin admin) throws SQLException {
        String sql = "UPDATE Admins SET id = ?, username = ?, password = ?";
        try (Connection conn = DAO.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, admin.getId());
            stmt.setString(2, admin.getUsername());
            stmt.setString(3, admin.getPassword());
            return stmt.executeUpdate();
        }
    }

    // 删除管理员
    @Override
    public int deleteAdmin(int id) throws SQLException {
        String sql = "DELETE FROM Admins WHERE id = ?";
        try (Connection conn = DAO.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate();
        }
    }

    // 更新密码
    @Override
    public int updatePassword(int adminId, String newPassword) throws SQLException {
        String sql = "UPDATE Admins SET password = ? WHERE id = ?";
        try (Connection conn = DAO.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, newPassword);
            stmt.setInt(2, adminId);
            return stmt.executeUpdate();
        }
    }
}