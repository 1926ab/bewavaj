package com.library.awa.dao;

import com.library.awa.model.Student;

import java.sql.SQLException;
import java.util.List;

public interface StudentDao {
    // 添加学生
    int addStudent(Student student) throws SQLException;

    // 根据 ID 查询学生
    Student findStudentById(String id) throws SQLException;

    // 查询所有学生
    List<Student> findAllStudents() throws SQLException;

    // 根据邮箱查询学生
    boolean isEmailRegistered(String email) throws SQLException;
}