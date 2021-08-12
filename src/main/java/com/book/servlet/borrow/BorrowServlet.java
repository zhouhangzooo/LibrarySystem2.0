package com.book.servlet.borrow;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.book.entity.Borrow;
import com.book.service.ServiceFactory;

import cn.hutool.json.JSONObject;

/**
 * Servlet implementation class BorrowServlet
 */
public class BorrowServlet extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<Borrow> borrows = ServiceFactory.getIBorrowServiceInstance().selectList();
		JSONObject json = new JSONObject();
		json.put("data", borrows);
		json.put("code", "000000");
		json.put("message", "请求成功");
		response.getWriter().println(json);
	}

}
