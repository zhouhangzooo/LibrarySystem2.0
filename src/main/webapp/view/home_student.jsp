<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>图书管理系统</title>
    <link rel="stylesheet" href="//unpkg.com/layui@2.6.8/dist/css/layui.css">
    <style>
        .a {
            display: inline-block;
            width: 100px;
            height: 64px;
            font-size: 16px;
            margin-top: 7px;
        }

        tr {
            height: 30px;
            font-size: 15px;
        }

        a:link {
            color: #009688
        }

        a:hover {
            border-color: #d2d2d2;
            color: #009688;
        }
    </style>
    <script src="//unpkg.com/layui@2.6.8/dist/layui.js"></script>
</head>
<body>
<%
    if (request.getParameter("id") == null) {
        response.sendRedirect("../login.jsp");
    }
    String id = request.getParameter("id");
%>
<div class="layui-header" style="height: 90px; background-color: #23262E;">
    <div class="layui-bg-black"
         style="float:left;width:200px;height: 90px; background-color: #393D49; font-size: 17px; line-height: 90px;text-align: center">
        图书管理 学生端
    </div>
    <div style="float:left; display: block; white-space: nowrap; width:1030px;height: 90px">
        <button class="layui-btn a" id="borrowBtn" onclick="queryBorrow()" type="submit"
                style="margin-left: 40px;">我的借阅
        </button>
        <button class="layui-btn a" onclick="displayAllBook()" type="submit"
                style="margin-left: 30px;">查询图书
        </button>
        <form class="a" style="margin-left: 30px" action="exitLogin.jsp" method="post">
            <button class="layui-btn a" type="submit">退出</button>
        </form>
    </div>
    <ul class="layui-nav layui-layout-right" style="background-color: #23262E;">
        <li class="layui-nav-item layui-hide layui-show-md-inline-block">
            <img src="//tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg"
                 class="layui-nav-img">
            <%=id%>
        </li>
    </ul>
</div>

<!-- 我的借阅界面 -->
<div id="queryBorrowDiv" style="display: none; margin: 20px;">

    <table id="tableQueryBorrowDiv" frame=hsides width="1000" border
           rules=none cellspacing=0 cellpadding="5"
           style="display: none; text-align: center; margin-top: 10px">
        <thead>
        <tr>
            <th>ISBN</th>
            <th>学号</th>
            <th>书名</th>
            <th>价格</th>
            <th>借阅时间</th>
            <th>预计归还时间</th>
            <th>归还时间</th>
            <th>借阅状态</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody id="queryBorrow_list">
        </tbody>
    </table>

</div>

<!-- 图书查询界面 -->
<div id="queryBookDiv" style="display: none; margin: 20px;">
    <form>
        <div style="display: flex; margin-top: 20px; line-height: 38px; align-content: center">
            按ISBN查询： <input id="query_book_ISBN_input" maxlength="18"><br>
            <button class="layui-btn" type="button" style="margin-left: 10px"
                    onclick="queryByISBN()">提交
            </button>
        </div>

        <div style="display: flex; margin-top: 20px; line-height: 38px; align-content: center">
            按书名查询：&#8197; <input id="query_book_name_input" maxlength="18"><br>
            <button class="layui-btn" type="button" style="margin-left: 10px"
                    onclick="queryByName()">提交
            </button>
        </div>

        <table id="tableQueryBookDiv" frame=hsides width="1000" border
               rules=none cellspacing=0 cellpadding="5"
               style="text-align: center; margin-top: 10px">
            <thead>
            <tr>
                <th>ISBN</th>
                <th>书名</th>
                <th>作者</th>
                <th>分类</th>
                <th>出版社</th>
                <th>价格</th>
                <th>收录时间</th>
                <th>借阅状态</th>
                <th>预计归还日期</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody id="appAccount_list">
            </tbody>
        </table>

    </form>
</div>

<script src="../static/js/jquery-3.2.1.js"></script>
<script type="text/javascript">

    layui.use(['layer'], function () {
        layer = layui.layer
    });

    function queryBorrow() {

        $("#queryBorrowDiv").show();
        $("#queryBookDiv").hide();

        $.ajax({
            type: "POST",
            url: "/books/QueryBorrowByIdServlet",
            data: {
                id:
                <%=id%>
            },
            dataType: "json",
            success: function (data) {
                if (data.code == "000000") {
                    var datas = data.data;
                    if (datas.length == "0" || datas.length == 0) {
                        alert("暂无数据");
                        return;
                    }
                    var rows = "";
                    $.each(datas, function (i, b) {
                        var borrow = b.book_borrow;
                        if (borrow == 0) {
                            borrow = "可借阅";
                        } else if (borrow == 1) {
                            borrow = "已借阅";
                        } else if (borrow == 2) {
                            borrow = "已归还";
                        } else {
                            borrow = "未知状态";
                        }

                        rows += '<tr>';
                        rows += "<td>" + b.ISBN;
                        rows += "<td>" + b.s_id;
                        rows += "<td>" + b.book_name;
                        rows += "<td>" + b.price;
                        rows += "<td>" + b.borrow_date;
                        rows += "<td>" + b.expect_return_date;
                        if (1 == b.book_borrow) {
                            var return_date = "未归还";
                            rows += "<td>" + return_date;
                        } else {
                            rows += "<td>" + b.return_date;
                        }
                        rows += "<td>" + borrow;
                        rows += "<td>" + "<a href="
                            + 'javascript:returnBook(\'' + b.ISBN
                            + '\',' + b.book_borrow + ')' + ">归还</a>";
                        rows += '</tr>';
                    });
                    $("#queryBorrow_list").html(rows);
                    $("#tableQueryBorrowDiv").show();
                } else {
                    layer.msg(data.message);
                }
            }
        });
    }

    //首次启动或页面刷新都会执行，显示学生借阅情况
    $("#borrowBtn").click(queryBorrow());

    function displayAllBook() {
        $("#query_book_ISBN_input").val("");
        $("#query_book_name_input").val("");

        $("#queryBorrowDiv").hide();
        $("#queryBookDiv").show();
        $
            .ajax({
                type: "POST",
                url: "/books/BookServlet",
                dataType: "json",
                success: function (data) {
                    if (data.code == "000000") {
                        var b = data.data;
                        if (b.length == "0" || b.length == 0) {
                            alert("暂时没有查询到该图书");
                            return;
                        }
                        var datas = data.data;
                        var rows = "";
                        $
                            .each(
                                datas,
                                function (i, b) {
                                    var borrow = b.book_borrow;
                                    if (borrow == 0) {
                                        borrow = "可借阅";
                                    } else if (borrow == 1) {
                                        borrow = "已借阅";
                                    } else {
                                        borrow = "未知状态";
                                    }
                                    rows += '<tr>';
                                    rows += "<td>" + b.ISBN;
                                    rows += "<td>"
                                        + b.book_name;
                                    rows += "<td>"
                                        + b.book_author;
                                    rows += "<td>"
                                        + b.sort_name;
                                    rows += "<td>" + b.book_pub;
                                    rows += "<td>"
                                        + b.book_price;
                                    rows += "<td>"
                                        + b.book_record;
                                    rows += "<td>" + borrow;
                                    rows += "<td>"
                                        + "<input type ='date' id='myDate" + i + "'" + " style='text-align:center;'>";
                                    rows += "<td>"
                                        + "<a href="
                                        + 'javascript:borrow(\''
                                        + b.ISBN + '\','
                                        + i + ','
                                        + b.book_borrow
                                        + ')' + ">借阅</a>";
                                    rows += '</tr>';
                                });
                        $("#appAccount_list").html(rows);
                        $("tableQueryBorrowDiv").show();
                    } else {
                        $("#info_query").text(data.message);
                    }

                }
            });
    };

    //借阅操作
    function borrow(ISBN, i, borrow) {
        if (borrow != 0) {
            return alert("该图书已经被借阅啦！");
        }
        var valueDate = $("#myDate" + i).val();
        if (valueDate === "") {
            return alert("请输入归还日期");
        }
        // 比较日期
        //var mDate = new Date(valueDate);
        //console.log(mDate.getFullYear() + "===" + mDate.getMonth() + 1 + '---' + mDate.getDate());
        var curDate = new Date();
        var borrow_date = curDate.getFullYear() + '-'
            + (curDate.getMonth() + 1) + '-' + curDate.getDate();
        $.ajax({
            type: "POST",
            url: "/books/BorrowBookServlet",
            data: {
                ISBN: ISBN,
                id:
                <%=id%>
                ,
                borrow_date: borrow_date,
                expect_return_date: valueDate
            },
            dataType: "json",
            success: function (data) {
                if (data.code == "000000") {
                    alert("借阅成功！");
                    location.reload();
                } else {
                    alert("借阅失败！");
                }
            }
        });
    }

    //归还操作
    function returnBook(ISBN, borrow) {
        if (borrow != 1) {
            return alert("当前图书已归还！");
        }
        // 比较日期
        //var mDate = new Date(valueDate);
        //console.log(mDate.getFullYear() + "===" + mDate.getMonth() + 1 + '---' + mDate.getDate());
        var curDate = new Date();
        var return_date = curDate.getFullYear() + '-'
            + (curDate.getMonth() + 1) + '-' + curDate.getDate();
        $.ajax({
            type: "POST",
            url: "/books/ReturnBookServlet",
            data: {
                ISBN: ISBN,
                return_date: return_date
            },
            dataType: "json",
            success: function (data) {
                if (data.code == "000000") {
                    alert("归还成功！");
                    location.reload();
                } else {
                    alert("归还失败！");
                }
            }
        });
    }

    //查询图书div--通过搜索图书ISBN查询
    function queryByISBN() {
        var book_ISBN = $("#query_book_ISBN_input").val();
        if (book_ISBN == '') {
            layer.msg("提示:ISBN唯一编号不能为空");
            return;
        }
        $
            .ajax({
                type: "POST",
                url: "/books/QueryBookByISBNServlet",
                dataType: "json",
                data: {
                    book_ISBN: book_ISBN
                },
                success: function (data) {
                    if (data.code == "000000") {
                        var b = data.data;
                        if (b.ISBN == undefined || b.ISBN == "") {
                            alert("暂时没有查询到该图书");
                            return;
                        }
                        var rows = "";
                        var borrow = b.book_borrow;
                        if (borrow == 0) {
                            borrow = "可借阅";
                        } else if (borrow == 1) {
                            borrow = "已借阅";
                        } else {
                            borrow = "未知状态";
                        }
                        rows += '<tr>';
                        rows += "<td>" + b.ISBN;
                        rows += "<td>" + b.book_name;
                        rows += "<td>" + b.book_author;
                        rows += "<td>" + b.sort_name;
                        rows += "<td>" + b.book_pub;
                        rows += "<td>" + b.book_price;
                        rows += "<td>" + b.book_record;
                        rows += "<td>" + borrow;
                        rows += "<td>"
                            + "<input type ='date' id='myDate0' style='text-align:center;'>";
                        rows += "<td>" + "<a href="
                            + 'javascript:borrow(\'' + b.ISBN
                            + '\',' + 0 + ',' + b.book_borrow + ')'
                            + ">借阅</a>";
                        rows += '</tr>';

                        $("#appAccount_list").html(rows);
                    } else {
                        layer.msg(data.message);
                    }
                }
            });
    }

    //查询图书div--通过搜索图书名查询
    function queryByName() {
        var book_name = $("#query_book_name_input").val();
        if (book_name == '') {
            layer.msg("提示:图书名不能为空");
            return;
        }
        $
            .ajax({
                type: "POST",
                url: "/books/QueryBookByNameServlet",
                data: {
                    book_name: book_name
                },
                dataType: "json",
                success: function (data) {
                    if (data.code == "000000") {
                        var datas = data.data;
                        console.log(datas);
                        if (datas.length == "0" || datas.length == 0) {
                            alert("暂时没有查询到该图书");
                            return;
                        }
                        var datas = data.data;
                        var rows = "";
                        $
                            .each(
                                datas,
                                function (i, b) {
                                    var borrow = b.book_borrow;
                                    if (borrow == 0) {
                                        borrow = "可借阅";
                                    } else if (borrow == 1) {
                                        borrow = "已借阅";
                                    } else {
                                        borrow = "未知状态";
                                    }
                                    rows += '<tr>';
                                    rows += "<td>" + b.ISBN;
                                    rows += "<td>"
                                        + b.book_name;
                                    rows += "<td>"
                                        + b.book_author;
                                    rows += "<td>"
                                        + b.sort_name;
                                    rows += "<td>" + b.book_pub;
                                    rows += "<td>"
                                        + b.book_price;
                                    rows += "<td>"
                                        + b.book_record;
                                    rows += "<td>" + borrow;
                                    rows += "<td>"
                                        + "<input type ='date' id='myDate" + i + "'" + " style='text-align:center;'>";
                                    rows += "<td>"
                                        + "<a href="
                                        + 'javascript:borrow(\''
                                        + b.ISBN + '\','
                                        + i + ','
                                        + b.book_borrow
                                        + ')' + ">借阅</a>";
                                    rows += '</tr>';
                                });
                        $("#appAccount_list").html(rows);
                    } else {
                        layer.msg(data.message);
                    }
                }
            });
    }
</script>
</body>
</html>