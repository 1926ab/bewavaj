package com.library.awa.repository;

import com.library.awa.model.Book;
import com.library.awa.database.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookRepository {
    // 获取所有图书
    public List<Book> getAllBooks() {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT * FROM Books";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                books.add(parseBook(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }

    // 添加图书
    public void addBook(Book book) throws SQLException {
        String sql = "INSERT INTO Books (id, title, author, price, quantity, category) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, book.getId());
            stmt.setString(2, book.getTitle());
            stmt.setString(3, book.getAuthor());
            stmt.setDouble(4, book.getPrice());
            stmt.setInt(5, book.getQuantity());
            stmt.setString(6, book.getCategory());
            stmt.executeUpdate();
        }
    }

    // 更新图书
    public void updateBook(Book book) throws SQLException {
        String sql = "UPDATE Books SET title=?, author=?, price=?, quantity=?, category=? WHERE id=?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, book.getTitle());
            stmt.setString(2, book.getAuthor());
            stmt.setDouble(3, book.getPrice());
            stmt.setInt(4, book.getQuantity());
            stmt.setString(5, book.getCategory());
            stmt.setString(6, book.getId());
            stmt.executeUpdate();
        }
    }

    // 删除图书
    public void deleteBook(String bookId) throws SQLException {
        String sql = "DELETE FROM Books WHERE id=?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, bookId);
            stmt.executeUpdate();
        }
    }

    // 工具方法：从 ResultSet 解析 Book 对象
    private Book parseBook(ResultSet rs) throws SQLException {
        return new Book(
                rs.getString("id"),
                rs.getString("title"),
                rs.getString("author"),
                rs.getDouble("price"),
                rs.getInt("quantity"),
                rs.getString("category")
        );
    }
}