<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2021/6/24 0024
  Time: 10:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="//unpkg.com/layui@2.6.8/dist/css/layui.css">
    <script src="//unpkg.com/layui@2.6.8/dist/layui.js"></script>
</head>
<body>
<div>
    <form class="layui-form" style="margin: 20px;">
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 90px">按ISBN查询：</label>
            <div class="layui-input-inline">
                <input id="id" type="text" lay-verify="required" lay-reqText="请输入ISBN" placeholder="请输入ISBN"
                       class="layui-input" maxlength="13">
            </div>
            <button class="layui-btn" style="width: 70px;margin-left: 4px" lay-submit lay-filter="queryISBN">提交</button>
        </div>
    </form>
    <form class="layui-form" style="margin: 20px;">
        <div class="layui-form-item">
            <label class="layui-form-label" style="width: 90px">按书名查询：</label>
            <div class="layui-input-inline">
                <input id="name" type="text" lay-verify="required" lay-reqText="请输入图书名称" placeholder="请输入图书名称"
                       class="layui-input" maxlength="16">
            </div>
            <button class="layui-btn" style="width: 70px;margin-left: 4px" lay-submit lay-filter="queryName">提交</button>
        </div>
    </form>
    <table id="table_id" lay-filter="table"></table>
</div>
<script type="text/javascript">

    layui.use(['table', 'jquery', 'form', 'layer'], function () {
        var table = layui.table,
            $ = layui.$,
            form = layui.form,
            layer = layui.layer;

        //执行渲染（分类表格）
        table.render({
            elem: '#table_id', //指定原始表格元素选择器（推荐id选择器）
            height: 430, //容器高度
            url: '/books/BookServlet',
            request: {
                pageName: 'curr' //页码的参数名称，默认：page
                , limitName: 'nums' //每页数据量的参数名，默认：limit
            },
            cols: [[ //标题栏
                {field: 'ISBN', title: 'ISBN', width: 80},
                {field: 'book_name', title: '书名', width: 150},
                {field: 'book_author', title: '作者', width: 150},
                {field: 'sort_name', title: '分类', width: 150},
                {field: 'book_pub', title: '出版社', width: 150},
                {field: 'book_price', title: '价格', width: 150},
                {field: 'book_record', title: '收录时间', width: 200},
                {
                    field: 'book_borrow', title: '借阅状态', width: 150,
                    templet: function (data) {
                        if (data.book_borrow == 0) {
                            return "可借阅";
                        } else if (data.book_borrow == 1) {
                            return "已借阅";
                        } else {
                            return "未知状态";
                        }
                    }
                }
            ]]
        });


        //监听提交
        form.on('submit(queryISBN)', function () {

            table.render({
                elem: '#table_id', //指定原始表格元素选择器（推荐id选择器）
                height: 430, //容器高度
                //url: '/books/QueryBookByISBNServlet',
                url: '/books/QueryBookByISBNServlet?book_ISBN=' + $("#id").val() + "&list=0",
                cols: [[ //标题栏
                    {field: 'ISBN', title: 'ISBN', width: 80},
                    {field: 'book_name', title: '书名', width: 150},
                    {field: 'book_author', title: '作者', width: 150},
                    {field: 'sort_name', title: '分类', width: 150},
                    {field: 'book_pub', title: '出版社', width: 150},
                    {field: 'book_price', title: '价格', width: 150},
                    {field: 'book_record', title: '收录时间', width: 200},
                    {
                        field: 'book_borrow', title: '借阅状态', width: 150,
                        templet: function (data) {
                            if (data.book_borrow == 0) {
                                return "可借阅";
                            } else if (data.book_borrow == 1) {
                                return "已借阅";
                            } else {
                                return "未知状态";
                            }
                        }
                    }
                ]]
            })
            ;
            return false;
        });

        form.on('submit(queryName)', function () {

            table.render({
                elem: '#table_id', //指定原始表格元素选择器（推荐id选择器）
                height: 430, //容器高度
                url: '/books/QueryBookByNameServlet?book_name=' + $("#name").val(),
                //url: '/books/QueryBookByNameServlet',
                cols: [[ //标题栏
                    {field: 'ISBN', title: 'ISBN', width: 80},
                    {field: 'book_name', title: '书名', width: 150},
                    {field: 'book_author', title: '作者', width: 150},
                    {field: 'sort_name', title: '分类', width: 150},
                    {field: 'book_pub', title: '出版社', width: 150},
                    {field: 'book_price', title: '价格', width: 150},
                    {field: 'book_record', title: '收录时间', width: 200},
                    {
                        field: 'book_borrow', title: '借阅状态', width: 150,
                        templet: function (data) {
                            if (data.book_borrow == 0) {
                                return "可借阅";
                            } else if (data.book_borrow == 1) {
                                return "已借阅";
                            } else {
                                return "未知状态";
                            }
                        }
                    }
                ]]
            });
            return false;
        });
    });
</script>
</body>
</html>
