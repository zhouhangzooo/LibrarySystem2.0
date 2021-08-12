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
    <style>
        body {
            padding: 0 20px;
        }
    </style>
</head>
<body>
<div>
    <table id="table_id" lay-filter="table"></table>
    <script type="text/html" id="toolbar">
        <div class="layui-btn-container">
            <button class="layui-btn layui-btn-sm" lay-event="add">添加</button>
            <button class="layui-btn layui-btn-sm" lay-event="del">删除</button>
        </div>
    </script>
    <div id="addPage" style="display: none; padding: 20px;">
        <div class="layui-form-item">
            <label class="layui-form-label">分类名称：</label>
            <div class="layui-input-inline">
                <input id="name" type="text" lay-verify="required" lay-reqText="请输入分类名称" class="layui-input"
                       maxlength="13">
            </div>
        </div>
        <div class="layui-form-item" style="margin-top: 80px;text-align: center;">
            <button class="layui-btn" style="width: 200px;" lay-submit lay-filter="addSort">添加</button>
        </div>
    </div>
</div>

<script type="text/javascript">

    layui.use(['table', 'jquery', 'form'], function () {
        var table = layui.table,
            $ = layui.$,
            layer = layui.layer,
            form = layui.form;
        function bookSort() {
            //执行渲染（分类表格）
            table.render({
                elem: '#table_id', //指定原始表格元素选择器（推荐id选择器）
                height: 500, //容器高度
                toolbar: "#toolbar", //头部工具栏
                defaultToolbar: ['filter', 'print', 'exports'],
                url: '/books/BookSortServlet',
                //page: true,
                cols: [[ //标题栏
                    {checkbox: true},
                    {field: 'id', title: 'ID', width: 80},
                    {field: 'sort_name', title: '分类', width: 150}
                ]]
            });
        }

        bookSort();

        //监听提交
        form.on('submit(addSort)', function () {
            var sort_name = $("#name").val();
            $.ajax({
                type: "POST",
                url: "/books/AddBookSortServlet",
                data: {
                    sort_name: sort_name,
                },
                dataType: "json",
                success: function (data) {
                    if (data.code == "000000") {
                        layer.msg("添加成功");
                        layer.closeAll('page'); //关闭所有页面层
                        bookSort();
                    } else {
                        layer.msg(data.message);
                    }
                }
            });
            return false;
        });

        //头工具栏事件
        table.on('toolbar(table)', function (obj) {
            var checkStatus = table.checkStatus(obj.config.id);
            switch (obj.event) {
                case 'add':
                    layer.open({
                        title: '添加分类',
                        type: 1,
                        skin: 'layui-layer-rim',
                        area: ['360px', '280px'],
                        content: $('#addPage')
                    });
                    break;
                case 'del':
                    var data = checkStatus.data;
                    if (data.length == 0) {
                        layer.msg("请勾选要删除的数据");
                        return;
                    }
                    $.each(data, function (i, b) {
                        //遍历删除
                        $.ajax({
                            type: "POST",
                            url: "/books/DeleteSortServlet",
                            data: {
                                id: data[i].id
                            },
                            dataType: "json",
                            success: function (data) {
                                layer.msg("删除成功");
                                bookSort();
                            },
                            error: function (xhr, errorText) {
                                layer.msg(xhr.status + "=" + errorText);
                            }
                        });
                    });
                    break;
            }
            ;
        });
    });
</script>
</body>
</html>
