<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.5, minimum-scale=0.5">
    <link rel="stylesheet" href="//unpkg.com/layui@2.6.8/dist/css/layui.css">
    <script src="//unpkg.com/layui@2.6.8/dist/layui.js"></script>
    <title>图书管理系统</title>
    <style>
        html, body {
            width: 100%;
            height: 100%;
            overflow: hidden;
            background: #393D49;
        }

        #main {
            background: #ffffff;
            position: absolute;
            width: 340px;
            height: 450px;
            margin: auto;
            border: 4px solid #dddddd;
            top: 0;
            left: 0;
            bottom: 0;
            right: 0;
        }
    </style>
</head>
<body>
<div id="main">
    <div style="background: transparent">
        <img style="object-fit: cover;" src="image/logo_2.png" width="340" height="180" />
    </div>
    <form class="layui-form" style="margin-top: 10px">
        <div class="layui-form-item">
            <label class="layui-form-label" id="title_id">学号：</label>
            <div class="layui-input-inline"> <%--layui-input-block--%>
                <input id="id" type="text" lay-verify="required" lay-reqText="请输入学号" placeholder="请输入学号"
                       class="layui-input" maxlength="11">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">密码：</label>
            <div class="layui-input-inline">
                <input id="password" type="password" lay-verify="required" lay-reqText="请输入密码" placeholder="请输入密码"
                       autocomplete="off" class="layui-input" maxlength="10">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">登录角色</label>
            <div class="layui-input-block">
                <input type="radio" name="role" value="学生" title="学生" checked="">
                <input type="radio" name="role" value="管理员" title="管理员">
            </div>
        </div>
        <div class="layui-form-item" style="text-align: center;">
            <button class="layui-btn" style="width: 270px;" lay-submit lay-filter="login">登录</button>
        </div>
    </form>
        <form class="layui-form" action="view/register.jsp">
            <div class="layui-form-item" style="text-align: center;">
                <button class="layui-btn" style="width: 270px;" lay-submit>注册</button>
            </div>
        </form>
</div>

<script>
    layui.use(['form', 'jquery'], function () {
        var form = layui.form,
            $ = layui.$,
            layer = layui.layer;

        //监听登录角色
        form.on('radio', function (data) {
            if (data.value == "管理员") {
                $('#title_id').text("工作号");
                $('#id').attr('lay-reqText', '请输入工作号');
                $('#id').attr('placeholder', '请输入工作号');
            } else {
                $('#title_id').text("学号：");
                $('#id').attr('lay-reqText', '请输入学号');
                $('#id').attr('placeholder', '请输入学号');
            }
        });

        //监听提交
        form.on('submit(login)', function () {
            var isManager;
            var id = $("#id").val();
            var password = $("#password").val();
            var url;
            if ($('input[name="role"]:checked').val() == "管理员") {
                isManager = 1;
                url = "/books/ManagerLoginServlet";
            } else {
                isManager = 0;
                url = "/books/StudentLoginServlet";
            }
            $.ajax({
                type: "POST",
                url: url,
                data: {
                    id: id,
                    password: password
                },
                dataType: "json",
                success: function (data) {
                    if (data.code == "000000") {
                        if (isManager) {
                            window.location.href = "view/home.jsp?id=" + data.data.id;
                        } else {
                            window.location.href = "view/home_student.jsp?id=" + data.data.id;
                        }
                    } else {
                        layer.msg(data.message);
                    }
                },
                error: function (xhr, errorText) {
                    layer.msg("" + xhr.status + "=" + errorText);
                }
            });
            return false;
        });
    });
</script>
</body>
</html>