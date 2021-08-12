package com.book.service.impl;

import com.book.dao.DaoFactory;
import com.book.entity.Book;
import com.book.service.IBookService;

import java.util.List;

public class BookServiceImpl implements IBookService {

    public Book selectByISBN(String ISBN) {
        return DaoFactory.getIBookDaoInstance().selectByISBN(ISBN);
    }

    public List<Book> selectByName(String name) {
        return DaoFactory.getIBookDaoInstance().selectByName(name);
    }

    public int insert(Book book) {
        return DaoFactory.getIBookDaoInstance().insert(book);
    }

    public int update(Book book, String ISBN) {
        return DaoFactory.getIBookDaoInstance().update(book, ISBN);
    }

    public List<Book> selectList() {
        return DaoFactory.getIBookDaoInstance().selectList();
    }

    public List<Book> selectList(int page, int limit) {
        return DaoFactory.getIBookDaoInstance().selectList(page, limit);
    }

    public int deleteByISBN(String ISBN) {
        return DaoFactory.getIBookDaoInstance().deleteByISBN(ISBN);
    }

    public boolean updateBookStatus(String ISBN, String s_id, String borrow_date, String expect_return_date) {
        return DaoFactory.getIBookDaoInstance().updateBookStatus(ISBN, s_id, borrow_date, expect_return_date);
    }

    public boolean returnBookStatus(String ISBN, String return_date) {
        return DaoFactory.getIBookDaoInstance().returnBookStatus(ISBN, return_date);
    }

}
