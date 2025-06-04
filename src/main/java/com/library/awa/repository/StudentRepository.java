package com.library.awa.repository;

import com.library.awa.model.Student;
import com.library.awa.database.DatabaseConnection;

import java.sql.*;

public class StudentRepository {
    // 验证学生登录
    public boolean validateStudentLogin(String email, String password) {
        String sql = "SELECT * FROM Students WHERE email = ? AND password = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            stmt.setString(2, password);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next(); // 如果有结果，则登录成功
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // 检查邮箱是否已注册
    public boolean isEmailRegistered(String email) {
        String sql = "SELECT * FROM Students WHERE email = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    System.out.println("邮箱已注册：" + email); // 调试日志
                    return true;
                }
            }
        } catch (SQLException e) {
            System.err.println("SQL异常：" + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    // 注册新学生
    public boolean registerStudent(Student student) {
        if (isEmailRegistered(student.getEmail())) {
            System.out.println("邮箱已被注册！");
            return false; // 邮箱已注册，返回失败
        }

        String sql = "INSERT INTO Students (id, name, email, password) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, student.getId());
            stmt.setString(2, student.getName());
            stmt.setString(3, student.getEmail());
            stmt.setString(4, student.getPassword());
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0; // 如果插入成功，返回 true
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}