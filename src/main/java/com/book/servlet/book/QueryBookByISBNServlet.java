package com.book.servlet.book;

import cn.hutool.json.JSONObject;
import com.book.entity.Book;
import com.book.service.ServiceFactory;
import com.book.util.StringUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Servlet implementation class BookServlet
 */
public class QueryBookByISBNServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String book_ISBN = request.getParameter("book_ISBN");
        String list = request.getParameter("list");

        JSONObject json = new JSONObject();
        if (!StringUtils.validateEmpty(book_ISBN)) {
            json.put("code", "111111");
            json.put("message", "缺少参数！");
            response.getWriter().println(json);
            return;
        }
        if (list == null) {
            Book book = ServiceFactory.getIBookServiceInstance().selectByISBN(book_ISBN);
            json.put("data", book);
            json.put("code", "000000");
            json.put("message", "请求成功");
            response.getWriter().println(json);
            return;
        }
		Book book = ServiceFactory.getIBookServiceInstance().selectByISBN(book_ISBN);
		List<Book> books = new ArrayList<Book>();
		books.add(book);
		json.put("data", books);
		json.put("code", "000000");
		json.put("message", "请求成功");
		response.getWriter().println(json);
    }

}
