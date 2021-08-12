package com.book.servlet.book;

import cn.hutool.json.JSONObject;
import com.book.entity.Book;
import com.book.service.ServiceFactory;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Servlet implementation class BookServlet
 */
public class BookServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String _page = request.getParameter("page");
        String _limit = request.getParameter("limit");
        List<Book> books;
		JSONObject json = new JSONObject();
        if (_page == null || _limit == null) {
            books = ServiceFactory.getIBookServiceInstance().selectList();
			if (books != null) {
				json.put("count", books.size());
			}
			json.put("data", books);
			json.put("code", "000000");
			json.put("message", "请求成功");
			response.getWriter().println(json);
        } else {
            try {
                int page = Integer.parseInt(_page);
                int limit = Integer.parseInt(_limit);
                int p = ((page - 1) * limit);
                books = ServiceFactory.getIBookServiceInstance().selectList(p, limit);

                int size = 0;
                if (books != null) {
                    size = books.size();
                    json.put("count", books.size());
                }

                // 总页数
                final int sumPage = size % limit == 0 ? size / limit : size / limit + 1;
                // 当前查询为第一页
                if (page == 1) {

                    // 第一页已经查尽数据
                    if (size < limit) {
                        json.put("data", books.subList(0, size));
                    }

                    // 第一页未查尽数据
                    if (size > limit) {
                        json.put("data", books.subList(p, limit));
                    }
                }

                // 当前页数在第一页和最后一页之间
                if (1 < page && page < sumPage) {
                    json.put("data", books.subList(p, page * limit));
                }

                // 当前页数是最后一页
                if ( page == sumPage) {
                    json.put("data", books.subList(p, size));
                }

				//json.put("data", books);
				json.put("code", "000000");
				json.put("message", "请求成功");
				response.getWriter().println(json);
            } catch (Exception e) {
                e.printStackTrace();
				json.put("code", "111111");
				json.put("message", "请求失败");
				response.getWriter().println(json);
            }
        }
    }

}
