package com.library.awa.dao.impl;

import com.library.awa.dao.StudentDao;
import com.library.awa.model.Student;
import com.library.awa.dao.DAO;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentDaoImpl implements StudentDao {

    // 添加学生 (注册)
    @Override
    public int addStudent(Student student) throws SQLException {
        String sql = "INSERT INTO Students (name, email, password) VALUES (?, ?, ?)";
        try (Connection conn = DAO.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, student.getName());
            stmt.setString(2, student.getEmail());
            stmt.setString(3, student.getPassword());
            return stmt.executeUpdate();
        }
    }

    // 检查邮箱是否已注册
    @Override
    public boolean isEmailRegistered(String email) throws SQLException {
        String sql = "SELECT 1 FROM Students WHERE email = ?";
        try (Connection conn = DAO.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next(); // 如果有结果，则邮箱已注册
            }
        }
    }

    // 验证学生登录
    public boolean validateStudentLogin(String email, String password) {
        String sql = "SELECT 1 FROM Students WHERE email = ? AND password = ?";
        try (Connection conn = DAO.getConnection();
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

    // 查找所有学生信息
    public List<Student> findAllStudents() {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT name, email, password FROM Students";
        try (Connection conn = DAO.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                students.add(new Student(
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("password")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return students;
    }
}