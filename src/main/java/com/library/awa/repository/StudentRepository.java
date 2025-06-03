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
}