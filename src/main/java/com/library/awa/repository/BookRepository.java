package com.library.awa.repository;

import com.library.awa.model.Book;
import com.library.awa.database.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookRepository {
    // 添加图书
    public void addBook(Book book) throws SQLException {
        String sql = "INSERT INTO Books (id, title, author, available, stock) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, book.getId());
            stmt.setString(2, book.getTitle());
            stmt.setString(3, book.getAuthor());
            stmt.setBoolean(4, book.isAvailable());
            stmt.setInt(5, book.getStock());
            stmt.executeUpdate();
        }
    }

    // 查询所有图书
    public List<Book> getAllBooks() throws SQLException {
        String sql = "SELECT * FROM Books";
        List<Book> books = new ArrayList<>();
        try (Connection conn = DatabaseConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                Book book = new Book(
                        rs.getString("id"),
                        rs.getString("title"),
                        rs.getString("author"),
                        rs.getBoolean("available"),
                        rs.getInt("stock")
                );
                books.add(book);
            }
        }
        return books;
    }

    // 更新图书库存
    public void updateBookStock(String bookId, int newStock) throws SQLException {
        String sql = "UPDATE Books SET stock = ? WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, newStock);
            stmt.setString(2, bookId);
            stmt.executeUpdate();
        }
    }

    // 删除图书
    public void deleteBook(String bookId) throws SQLException {
        String sql = "DELETE FROM Books WHERE id = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, bookId);
            stmt.executeUpdate();
        }
    }
}