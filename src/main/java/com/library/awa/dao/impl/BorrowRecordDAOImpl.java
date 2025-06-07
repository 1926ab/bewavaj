package com.library.awa.dao.impl;

import com.library.awa.dao.DAO;
import com.library.awa.dao.BorrowRecordDAO;
import com.library.awa.model.BorrowRecord;
import com.library.awa.model.Book;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BorrowRecordDAOImpl implements BorrowRecordDAO {

    /**
     * 添加借阅记录
     *
     * @param record 借阅记录对象
     * @return 更新的行数
     * @throws SQLException 数据库操作异常
     */
    @Override
    public int addBorrowRecord(BorrowRecord record) throws SQLException {
        String sql = "INSERT INTO borrowrecords (student_id, book_id, borrow_date) VALUES (?, ?, ?)";
        try (Connection conn = DAO.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, record.getStudentId());
            stmt.setString(2, record.getBookId());
            stmt.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
            return stmt.executeUpdate();
        }
    }

    /**
     * 检查学生是否有未归还的借阅记录
     *
     * @param studentId 学生ID
     * @return 如果有未归还记录则返回 true，否则返回 false
     * @throws SQLException 数据库操作异常
     */
    @Override
    public boolean hasActiveBorrow(String studentId) throws SQLException {
        String sql = "SELECT 1 FROM borrowrecords WHERE student_id = ? AND return_date IS NULL";
        try (Connection conn = DAO.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, studentId);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        }
    }

    /**
     * 获取所有借阅记录
     *
     * @return 借阅记录列表
     * @throws SQLException 数据库操作异常
     */
    @Override
    public List<BorrowRecord> getAllBorrowRecords() throws SQLException {
        List<BorrowRecord> records = new ArrayList<>();
        String sql = "SELECT br.student_id, s.name AS student_name, br.book_id, b.title AS book_title " +
                "FROM borrowrecords br " +
                "JOIN students s ON br.student_id = s.email " +
                "JOIN books b ON br.book_id = b.id";
        try (Connection conn = DAO.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                BorrowRecord record = new BorrowRecord(
                        rs.getString("student_id"),
                        rs.getString("student_name"),
                        rs.getString("book_id"),
                        rs.getString("book_title")
                );
                records.add(record);
            }
        }
        return records;
    }

    /**
     * 获取所有库存量大于 0 的书籍
     *
     * @return 可借书籍列表
     * @throws SQLException 数据库操作异常
     */
    public List<Book> getAvailableBooks() throws SQLException {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT id, title, author, quantity FROM books WHERE quantity > 0";

        try (Connection conn = DAO.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Book book = new Book();
                book.setId(rs.getString("id"));
                book.setTitle(rs.getString("title"));
                book.setAuthor(rs.getString("author"));
                book.setQuantity(rs.getInt("quantity"));
                books.add(book);
            }
        }

        return books;
    }
}