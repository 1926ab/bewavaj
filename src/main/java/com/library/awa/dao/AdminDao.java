package com.library.awa.dao;

import com.library.awa.model.Admin;

import java.sql.SQLException;
import java.util.List;

public interface AdminDao {
    // 添加管理员
    int addAdmin(Admin admin) throws SQLException;

    // 根据邮箱查询学生
    boolean isIdRegistered(String id) throws SQLException;

//    // 查询所有管理员
//    List<Admin> findAllAdmin() throws SQLException;

    // 检查用户名是否已存在
    boolean isUsernameTaken(String username) throws SQLException;

    // 验证管理员登录
    boolean validateAdminLogin(String username, String password);

    // 获取所有管理员
    List<Admin> findAllAdmins();

    // 根据ID查找管理员
    Admin findAdminById(int id);

    // 更新管理员信息
    int updateAdmin(Admin admin) throws SQLException;

    // 删除管理员
    int deleteAdmin(int id) throws SQLException;

    // 更新密码
    int updatePassword(int adminId, String newPassword) throws SQLException;
}