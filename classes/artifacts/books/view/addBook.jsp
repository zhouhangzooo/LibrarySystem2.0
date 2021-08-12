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
            <label class="layui-form-label">ISBN：</label>
            <div class="layui-input-inline">
                <input id="id" type="text" lay-verify="required" lay-reqText="请输入ISBN" placeholder="请输入ISBN"
                       class="layui-input" maxlength="13">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">图书名称：</label>
            <div class="layui-input-inline">
                <input id="name" type="text" lay-verify="required" lay-reqText="请输入图书名称" placeholder="请输入图书名称"
                       class="layui-input" maxlength="16">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">图书作者：</label>
            <div class="layui-input-inline">
                <input id="author" type="text" lay-verify="required" lay-reqText="请输入作者"
                       placeholder="请输入作者"
                       autocomplete="off" class="layui-input" maxlength="16">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">出版社：</label>
            <div class="layui-input-inline">
                <input id="pub" type="text" class="layui-input" lay-verify="required" placeholder="请输入出版社"
                       lay-reqText="请输入出版社" maxlength="16">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">图书分类：</label>
            <div class="layui-input-block" style="width: 190px;">
                <select id="sort" lay-verify="required" lay-reqText="请添加图书分类">
                </select>
            </div>
        </div>
        <div class="layui-form-item"> <%-- layui-inline --%>
            <label class="layui-form-label">收录时间：</label>
            <div class="layui-input-inline">
                <input type="text" class="layui-input" id="record" lay-verify="required" lay-reqText="请输入收录时间"
                       placeholder="请选择时间">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">图书价格：</label>
            <div class="layui-input-inline">
                <input id="price" type="text" lay-verify="required|number" placeholder="请输入价格"
                       lay-reqText="请输入价格" class="layui-input" maxlength="11">
            </div>
        </div>
        <div class="layui-form-item" style="margin-top: 16px;margin-left: 26px">
            <button class="layui-btn" style="width: 270px;" lay-submit lay-filter="addBook">添加图书</button>
        </div>
    </form>
</div>

<script type="text/javascript">

    layui.use(['form', 'jquery', 'laydate'], function () {
        var form = layui.form,
            $ = layui.$,
            layer = layui.layer,
            layDate = layui.laydate;

        //渲染日期选择器
        layDate.render({
            elem: '#record' //指定元素
            ,type: 'datetime'
        });

        function requestBookSort() {
            $.ajax({
                type: "POST",
                url: "/books/BookSortServlet",
                dataType: "json",
                success: function (data) {
                    var datas = data.data;
                    var rows = "";
                    if (datas.length == "0" || datas.length == 0) {
                        return;
                    }
                    $.each(datas, function (i, b) {
                        rows += "<option value='" + b.id + "'>" + b.sort_name + "</option>";
                    });
                    $("#sort").html(rows);
                    form.render('select'); //刷新select选择框渲染
                }
            });
        }

        //页面加载完成后请求图书分类数据
        window.onload = requestBookSort();

        //监听提交
        form.on('submit(addBook)', function () {
            var id = $("#id").val();
            var name = $("#name").val();
            var author = $("#author").val();
            var pub = $("#pub").val();
            var record = $("#record").val();
            var price = $("#price").val();
            var borrow = 0;
            var sort = $('#sort option:selected').val();

            $.ajax({
                type: "POST",
                url: "/books/AddBookServlet",
                data: {
                    book_ISBN: id,
                    book_name: name,
                    book_author: author,
                    book_pub: pub,
                    book_record: record,
                    book_price: price,
                    book_sort: sort,
                    book_borrow: borrow
                },
                dataType: "json",
                success: function (data) {
                    if (data.code == "000000") {
                        layer.msg(data.message);
                    } else {
                        layer.msg(data.message);
                    }
                },
                error: function (xhr, errorText) {
                    layer.msg(xhr.status + "=" + errorText);
                }
            });
            return false;
        });
    });
</script>
</body>
</html>
