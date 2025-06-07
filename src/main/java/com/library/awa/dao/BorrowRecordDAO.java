package com.library.awa.dao;

import com.library.awa.model.BorrowRecord;

import java.sql.SQLException;
import java.util.List;

public interface BorrowRecordDAO {
    // 添加借阅记录
    int addBorrowRecord(BorrowRecord record) throws SQLException;

    // 检查学生是否有未归还的借阅记录
    boolean hasActiveBorrow(String studentId) throws SQLException;

    // 获取所有借阅记录
    List<BorrowRecord> getAllBorrowRecords() throws SQLException;
}