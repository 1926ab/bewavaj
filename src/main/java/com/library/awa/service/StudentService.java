package com.library.awa.service;

import com.library.awa.dao.StudentDao;
import com.library.awa.dao.impl.StudentDaoImpl;
import com.library.awa.model.Student;

import java.sql.SQLException;
import java.util.List;

public class StudentService {
    private final StudentDao studentDao = new StudentDaoImpl();

    public boolean registerStudent(Student student) {
        try {
            if (studentDao.isEmailRegistered(student.getEmail())) {
                System.out.println("邮箱已被注册！");
                return false;
            }
            return studentDao.addStudent(student) > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Student findStudentById(String id) {
        try {
            return studentDao.findStudentById(id);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    public List<Student> getAllStudents() {
        try {
            return studentDao.findAllStudents();
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
}