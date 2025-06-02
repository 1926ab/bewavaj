package com.library.awa.model;

public class Book {
    private String id;       // 书籍编号
    private String title;    // 书名
    private String author;   // 作者
    private boolean available; // 是否可借阅
    private int stock;       // 剩余库存数量

    // 构造方法
    public Book(String id, String title, String author, boolean available, int stock) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.available = available;
        this.stock = stock;
    }

    // Getter 和 Setter 方法
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public boolean isAvailable() {
        return available;
    }

    public void setAvailable(boolean available) {
        this.available = available;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    // 重写 toString 方法
    @Override
    public String toString() {
        return "Book{" +
                "id='" + id + '\'' +
                ", title='" + title + '\'' +
                ", author='" + author + '\'' +
                ", available=" + available +
                ", stock=" + stock +
                '}';
    }
}