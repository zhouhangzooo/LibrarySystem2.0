package com.book.dao.impl;

import com.book.dao.BaseDao;
import com.book.dao.DaoFactory;
import com.book.dao.IBookDao;
import com.book.entity.Book;
import com.book.entity.Borrow;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BookDaoImpl extends BaseDao implements IBookDao {

    public Book selectByISBN(String ISBN) {
        Book m = new Book();
        String sql = "select * from book a LEFT OUTER JOIN book_sort b ON a.`sort_id` = b.`sort_id` where ISBN = ?";
        Object[] obj = {ISBN};
        ResultSet rs = selectJDBC(sql, obj);
        try {
            while (rs.next()) {
                m.setISBN(rs.getString("iSBN"));
                m.setBook_author(rs.getString("book_author"));
                m.setBook_name(rs.getString("book_name"));
                m.setBook_borrow(rs.getInt("book_borrow"));
                m.setBook_price(rs.getBigDecimal("book_price"));
                m.setBook_pub(rs.getString("book_pub"));
                m.setBook_record(rs.getString("book_record"));
                m.setSort_id(rs.getInt("sort_id"));
                m.setSort_name(rs.getString("sort_name"));
            }
            return m;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            closeJDBC();
        }
    }

    public List<Book> selectByName(String name) {
        List<Book> lists = new ArrayList<Book>();
        String sql = "select * from book a LEFT OUTER JOIN book_sort b ON a.`sort_id` = b.`sort_id` where book_name like \"%\"?\"%\"";
        Object[] obj = {name};
        ResultSet rs = selectJDBC(sql, obj);
        try {
            while (rs.next()) {
                Book m = new Book();
                m.setISBN(rs.getString("iSBN"));
                m.setBook_author(rs.getString("book_author"));
                m.setBook_name(rs.getString("book_name"));
                m.setBook_borrow(rs.getInt("book_borrow"));
                m.setBook_price(rs.getBigDecimal("book_price"));
                m.setBook_pub(rs.getString("book_pub"));
                m.setBook_record(rs.getString("book_record"));
                m.setSort_id(rs.getInt("sort_id"));
                m.setSort_name(rs.getString("sort_name"));

                lists.add(m);
            }
            return lists;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        } finally {
            closeJDBC();
        }
    }

    public boolean checkIsExist(String id) {
        String sql = "select ISBN from book where ISBN = ?";
        Object[] obj = {id};
        ResultSet rs = selectJDBC(sql, obj);
        try {
            if (rs.next()) {
                return true;
            } else {
                return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            closeJDBC();
        }
    }

    public int insert(Book m) {
        boolean result = checkIsExist(m.getISBN());
        if (result) {
            return -1;
        }
        String sql = "insert into book (ISBN, book_name, book_author, book_pub, book_borrow, sort_id, book_record, book_price) values (?,?,?,?,?,?,?,?)";
        Object[] obj = {m.getISBN(), m.getBook_name(), m.getBook_author(), m.getBook_pub(), m.getBook_borrow(),
                m.getSort_id(), m.getBook_record(), m.getBook_price()};
        int lines = updateJDBC(sql, obj);
        if (lines > 0) {
            closeJDBC();
            return 1;
        }
        closeJDBC();
        return 0;
    }

    public int update(Book m, String ISBN) {
        String sql = "update book set ISBN = ?, book_name = ?, book_author = ?, book_pub = ?, book_borrow = ?, sort_id = ?, book_record = ?, book_price = ? where ISBN = ?";
        Object[] obj = {m.getISBN(), m.getBook_name(), m.getBook_author(), m.getBook_pub(), m.getBook_borrow(),
                m.getSort_id(), m.getBook_record(), m.getBook_price(), ISBN};
        int lines = updateJDBC(sql, obj);
        if (lines > 0) {
            return 1;
        }
        return 0;
    }

    public List<Book> selectList() {
        List<Book> lists = new ArrayList<Book>();
        // String sql = "select * from book";
        // ????????????????????????????????????????????????????????????????????????????????????????????????????????????null????????????
        String sql = "SELECT * FROM book a LEFT OUTER JOIN book_sort b ON a.`sort_id` = b.`sort_id`";
        Object[] obj = {};
        ResultSet rs = selectJDBC(sql, obj);
        try {
            while (rs.next()) {

                Book m = new Book();
                m.setISBN(rs.getString("ISBN"));
                m.setBook_author(rs.getString("book_author"));
                m.setBook_name(rs.getString("book_name"));
                m.setBook_borrow(rs.getInt("book_borrow"));
                m.setBook_price(rs.getBigDecimal("book_price"));
                m.setBook_pub(rs.getString("book_pub"));
                m.setBook_record(rs.getString("book_record"));
                m.setSort_id(rs.getInt("sort_id"));
                m.setSort_name(rs.getString("sort_name"));

                lists.add(m);
            }
            return lists;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {
            closeJDBC();
        }
    }

    public List<Book> selectList(int page, int limit) {
        List<Book> lists = new ArrayList<Book>();
        // String sql = "select * from book";
        // ????????????????????????????????????????????????????????????????????????????????????????????????????????????null????????????

        String sql = "SELECT * FROM book a LEFT OUTER JOIN book_sort b ON a.`sort_id` = b.`sort_id`";
        //String sql = "SELECT * FROM book a LEFT OUTER JOIN book_sort b ON a.`sort_id` = b.`sort_id` limit = ? offset = ?";
        Object[] obj = {};
        ResultSet rs = selectJDBC(sql, obj);
        try {
            while (rs.next()) {

                Book m = new Book();
                m.setISBN(rs.getString("ISBN"));
                m.setBook_author(rs.getString("book_author"));
                m.setBook_name(rs.getString("book_name"));
                m.setBook_borrow(rs.getInt("book_borrow"));
                m.setBook_price(rs.getBigDecimal("book_price"));
                m.setBook_pub(rs.getString("book_pub"));
                m.setBook_record(rs.getString("book_record"));
                m.setSort_id(rs.getInt("sort_id"));
                m.setSort_name(rs.getString("sort_name"));

                lists.add(m);
            }
            return lists;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        } finally {
            closeJDBC();
        }
    }

    public int deleteByISBN(String ISBN) {
        String sql = "delete from book where ISBN = ?";
        Object[] obj = {ISBN};
        int lines = updateJDBC(sql, obj);
        if (lines > 0) {
            closeJDBC();
            return 1;
        }
        closeJDBC();
        return 0;
    }

    /**
     * ?????????????????????book???book_borrow?????????0???????????????1????????????????????????????????????????????????????????????
     *
     * @param ISBN               ???????????????
     * @param s_id               ???????????????
     * @param borrow_date        ?????????????????????????????????
     * @param expect_return_date ????????????
     * @return
     */
    public boolean updateBookStatus(String ISBN, String s_id, String borrow_date, String expect_return_date) {
        Book m = new Book();
        String sql = "select * from book where ISBN = ?";
        Object[] obj = {ISBN};
        ResultSet rs = selectJDBC(sql, obj);
        try {
            while (rs.next()) {
                m.setISBN(rs.getString("iSBN"));
                m.setBook_author(rs.getString("book_author"));
                m.setBook_name(rs.getString("book_name"));
                if (rs.getInt("book_borrow") != 0) {
                    return false;
                }
                m.setBook_borrow(1);
                m.setBook_price(rs.getBigDecimal("book_price"));
                m.setBook_pub(rs.getString("book_pub"));
                m.setBook_record(rs.getString("book_record"));
                m.setSort_id(rs.getInt("sort_id"));
            }
            int result = update(m, ISBN);
            if (result == 0) {
                System.out.println("==????????????????????????");
                return false;
            }

            // ???????????????????????????
            Borrow borrow = new Borrow();
            borrow.setBook_borrow(m.getBook_borrow());
            borrow.setBook_name(m.getBook_name());
            borrow.setBorrow_date(borrow_date);
            borrow.setExpect_return_date(expect_return_date); // ?????????????????????????????????
            borrow.setISBN(m.getISBN());
            borrow.setPrice(m.getBook_price());
            borrow.setReturn_date(expect_return_date); // ???null ???????????????????????????
            borrow.setS_id(s_id);

            result = DaoFactory.getIBorrowDaoInstance().insert(borrow);
            if (result == 0) {
                System.out.println("==????????????????????????");
                return false;
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            closeJDBC();
        }
    }

    /**
     * ????????????
     */
    public boolean returnBookStatus(String ISBN, String return_date) {
        Book m = new Book();
        String sql = "select * from book where ISBN = ?";
        Object[] obj = {ISBN};
        ResultSet rs = selectJDBC(sql, obj);
        try {
            while (rs.next()) {
                m.setISBN(rs.getString("iSBN"));
                m.setBook_author(rs.getString("book_author"));
                m.setBook_name(rs.getString("book_name"));
                if (rs.getInt("book_borrow") != 1) {
                    return false;
                }
                m.setBook_borrow(0);
                m.setBook_price(rs.getBigDecimal("book_price"));
                m.setBook_pub(rs.getString("book_pub"));
                m.setBook_record(rs.getString("book_record"));
                m.setSort_id(rs.getInt("sort_id"));
            }
            int result = update(m, ISBN);
            if (result == 0) {
                System.out.println("==????????????????????????");
                return false;
            }

            // ???????????????????????????
            Borrow borrow = new Borrow();
            borrow.setISBN(m.getISBN());
            borrow.setBook_borrow(2); //????????????2????????????
            borrow.setReturn_date(return_date); // ???????????????????????????

            result = DaoFactory.getIBorrowDaoInstance().update_returnbook(borrow);
            if (result == 0) {
                System.out.println("==????????????????????????");
                return false;
            }
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        } finally {
            closeJDBC();
        }
    }

}
