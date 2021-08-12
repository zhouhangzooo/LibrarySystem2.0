package com.book.servlet.booksort;

import cn.hutool.json.JSONObject;
import com.book.service.ServiceFactory;
import com.book.util.StringUtils;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet implementation class BookServlet
 */
public class DeleteSortServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String ids = request.getParameter("id");
        int id = 0;
        if (StringUtils.validateEmpty(ids)) {
            id = Integer.parseInt(ids);
        }
        int result = ServiceFactory.getIBookSortServiceInstance().deleteById(id);
        JSONObject json = new JSONObject();
        if (result == 1) {
            json.put("code", "000000");
            json.put("message", "删除成功");
            response.getWriter().println(json);
        } else {
            json.put("code", "111111");
            json.put("message", "删除失败");
            response.getWriter().println(json);
        }
    }

}
