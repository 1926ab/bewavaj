package com.library.awa.model;

import java.sql.Timestamp;

public class BorrowRecord {
    private String studentId;
    private String studentName;
    private String bookId;
    private String bookTitle;
    private Timestamp borrowDate;

    // Constructor for displaying records
    public BorrowRecord(String studentId, String studentName, String bookId, String bookTitle) {
        this.studentId = studentId;
        this.studentName = studentName;
        this.bookId = bookId;
        this.bookTitle = bookTitle;
    }

    // Constructor for inserting records
    public BorrowRecord(String studentId, String bookId) {
        this.studentId = studentId;
        this.bookId = bookId;
    }

    public String getStudentId() {
        return studentId;
    }

    public void setStudentId(String studentId) {
        this.studentId = studentId;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }

    public String getBookId() {
        return bookId;
    }

    public void setBookId(String bookId) {
        this.bookId = bookId;
    }

    public String getBookTitle() {
        return bookTitle;
    }

    public void setBookTitle(String bookTitle) {
        this.bookTitle = bookTitle;
    }

    public Timestamp getBorrowDate() {
        return borrowDate;
    }

    public void setBorrowDate(Timestamp borrowDate) {
        this.borrowDate = borrowDate;
    }
}