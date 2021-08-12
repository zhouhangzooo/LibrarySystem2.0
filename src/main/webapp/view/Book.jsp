<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2021/7/29 0024
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
<script type="text/html" id="toolbar">
    <div class="layui-btn-container">
        <button class="layui-btn layui-btn-sm" lay-event="add">添加图书</button>
        <button class="layui-btn layui-btn-sm" lay-event="del">选择删除</button>
    </div>
</script>
<script type="text/html" id="barDemo">
    <a class="layui-btn layui-btn-xs" lay-event="edit">编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
</script>
<div>
    <table id="table_id" lay-filter="table"></table>
    <div id="addPage" style="display: none; padding: 20px;">
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
                <button id="btn" class="layui-btn" style="width: 270px;" lay-submit lay-filter="addBook">添加图书</button>
            </div>
        </form>
    </div>
</div>

<script type="text/javascript">
    var isUpdate;
    var oldISBN;
    var objUpdate;
    layui.use(['table', 'jquery', 'form', 'laydate', 'layer'], function () {
        var table = layui.table,
            $ = layui.$,
            form = layui.form,
            layDate = layui.laydate,
            layer = layui.layer;

        //渲染日期选择器
        layDate.render({
            elem: '#record' //指定元素
            ,type: 'datetime'
        });

        //头工具栏事件
        table.on('toolbar(table)', function (obj) {
            var checkStatus = table.checkStatus(obj.config.id);
            switch (obj.event) {
                case 'add':
                    isUpdate = false;
                    layer.open({
                        title: '添加图书',
                        type: 1,
                        skin: 'layui-layer-rim',
                        area: ['440px', '546px'],
                        content: $('#addPage'),
                        success: function () {
                            $("#id").val("");
                            $("#name").val("");
                            $("#author").val("");
                            $("#pub").val("");
                            $("#record").val("");
                            $("#price").val("");
                            $('#btn').text("添加图书");
                        }
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
                            url: "/books/DeleteBookServlet",
                            data: {
                                ISBN: data[i].ISBN
                            },
                            dataType: "json",
                            success: function (data) {
                                layer.msg("删除成功");
                                book();
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

        //行工具条事件
        table.on('tool(table)', function (obj) { //注：tool 是工具条事件名，table 是 table 原始容器的属性 lay-filter="对应的值"
            var data = obj.data; //获得当前行数据
            var layEvent = obj.event; //获得 lay-event 对应的值（也可以是表头的 event 参数对应的值）

            if (layEvent === 'del') { //删除
                layer.confirm('您确认要删除此图书吗？', function (index) {
                    //向服务端发送删除指令
                    deleteBook(obj, data.ISBN);
                    layer.close(index);
                });
            } else if (layEvent === 'edit') { //编辑
                isUpdate = true;
                oldISBN = data.ISBN;
                objUpdate = obj;
                layer.open({
                    title: '编辑图书',
                    type: 1,
                    skin: 'layui-layer-rim',
                    area: ['440px', '546px'],
                    content: $('#addPage'),
                    success: function () {
                        $("#id").val(data.ISBN);
                        $("#name").val(data.book_name);
                        $("#author").val(data.book_author);
                        $("#pub").val(data.book_pub);
                        $("#record").val(data.book_record);
                        $("#price").val(data.book_price);
                        $('#btn').text("编辑图书");
                    }
                });
            }
        });

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
            if (isUpdate) {
                $.ajax({
                    type: "POST",
                    url: "/books/EditBookServlet",
                    data: {
                        ISBN: oldISBN,
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
                            //同步更新缓存对应的值
                            objUpdate.update({
                                book_ISBN: id,
                                book_name: name,
                                book_author: author,
                                book_pub: pub,
                                book_record: record,
                                book_price: price,
                                book_sort: sort,
                                book_borrow: borrow
                            });
                            layer.msg("编辑成功！");
                            layer.closeAll('page'); //关闭所有页面层
                            book(); //刷新
                        } else {
                            layer.msg("编辑失败！");
                        }
                    }
                });
            } else {
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
                            layer.closeAll('page'); //关闭所有页面层
                            book(); //刷新
                        } else {
                            layer.msg(data.message);
                        }
                    },
                    error: function (xhr, errorText) {
                        layer.msg(xhr.status + "=" + errorText);
                    }
                });
            }
        });

        function book() {
            //执行渲染（分类表格）
            table.render({
                elem: '#table_id', //指定原始表格元素选择器（推荐id选择器）
                height: 522.5, //容器高度
                toolbar: "#toolbar", //头部工具栏
                defaultToolbar: ['filter', 'print', 'exports'],
                url: '/books/BookServlet',
                page: true,
                cols: [[ //标题栏
                    {checkbox: true},
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
                    },
                    {fixed: 'right', title: '操作', toolbar: '#barDemo', width: 150}
                ]]
            });
        }

        //删除行
        function deleteBook(obj, ISBN) {
            $.ajax({
                type: "POST",
                url: "/books/DeleteBookServlet",
                data: {
                    ISBN: ISBN
                },
                dataType: "json",
                success: function (data) {
                    if (data.code == "000000") {
                        obj.del(); //删除对应行（tr）的DOM结构，并更新缓存
                        layer.msg("删除成功！");
                    } else {
                        layer.msg("删除失败！");
                    }
                }
            });
        }

        book();

        requestBookSort();

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
    });

</script>
</body>
</html>
