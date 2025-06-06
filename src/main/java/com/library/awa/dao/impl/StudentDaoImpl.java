package com.library.awa.dao.impl;

import com.library.awa.dao.DAO;
import com.library.awa.dao.StudentDao;
import com.library.awa.model.Student;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentDaoImpl implements StudentDao {

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

    @Override
    public boolean isEmailRegistered(String email) throws SQLException {
        String sql = "SELECT 1 FROM Students WHERE email = ?";
        try (Connection conn = DAO.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        }
    }

    @Override
    public List<Student> findAllStudents() throws SQLException {
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
        }
        return students;
    }
}