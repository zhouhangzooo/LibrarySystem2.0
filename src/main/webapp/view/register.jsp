<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.5, minimum-scale=0.5">
    <title>注册页面</title>
    <link rel="stylesheet" href="//unpkg.com/layui@2.6.8/dist/css/layui.css">
    <script src="//unpkg.com/layui@2.6.8/dist/layui.js"></script>
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

        .layui-form-item {
            margin-bottom: 8px;
        }

        /*修改原layui样式，让每个tab占据一半*/
        .layui-tab-title li {
            padding: 0;
            font-size: 16px;
            font-weight: bold;
            letter-spacing: 1px;
        }

        .tab-item {
            width: 50%;
        }
    </style>
</head>
<body>
<script src="../static/js/jquery-3.2.1.js"></script>
<div id="main">
    <div class="layui-tab layui-tab-brief">
        <ul class="layui-tab-title">
            <li class="tab-item layui-this">学生注册</li>
            <li class="tab-item">管理员注册</li>
        </ul>
        <div class="layui-tab-content">
            <div class="layui-tab-item layui-show">
                <form class="layui-form">
                    <div class="layui-form-item">
                        <label class="layui-form-label">学号：</label>
                        <div class="layui-input-inline">
                            <input id="id" type="text" lay-verify="required" lay-reqText="请输入学号" placeholder="请输入学号"
                                   class="layui-input" maxlength="11">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">姓名：</label>
                        <div class="layui-input-inline">
                            <input id="name" type="text" lay-verify="required" lay-reqText="请输入姓名" placeholder="请输入姓名"
                                   class="layui-input" maxlength="11">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">密码：</label>
                        <div class="layui-input-inline">
                            <input id="password" type="password" lay-verify="required" lay-reqText="请输入密码"
                                   placeholder="请输入密码"
                                   autocomplete="off" class="layui-input" maxlength="10">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">性別：</label>
                        <div class="layui-input-block">
                            <input type="radio" name="sex" value="0" title="男" checked="">
                            <input type="radio" name="sex" value="1" title="女">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">年龄：</label>
                        <div class="layui-input-inline">
                            <input id="age" type="text" class="layui-input" maxlength="3">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">专业：</label>
                        <div class="layui-input-inline">
                            <input id="profession" type="text" class="layui-input" maxlength="11">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">年级：</label>
                        <div class="layui-input-inline">
                            <input id="grade" type="text" class="layui-input" maxlength="11">
                        </div>
                    </div>
                    <div class="layui-form-item" style="text-align: center; margin-top: 14px">
                        <button class="layui-btn" style="width: 270px;" lay-submit lay-filter="register">注册</button>
                    </div>
                </form>
            </div>
            <div class="layui-tab-item">
                <form class="layui-form">
                    <div class="layui-form-item">
                        <label class="layui-form-label">工作号：</label>
                        <div class="layui-input-inline">
                            <input id="m-id" type="text" lay-verify="required" lay-reqText="请输入工作号" placeholder="请输入工作号"
                                   class="layui-input" maxlength="11">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">姓名：</label>
                        <div class="layui-input-inline">
                            <input id="m-name" type="text" lay-verify="required" lay-reqText="请输入姓名" placeholder="请输入姓名"
                                   class="layui-input" maxlength="11">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">密码：</label>
                        <div class="layui-input-inline">
                            <input id="m-password" type="password" lay-verify="required" lay-reqText="请输入密码"
                                   placeholder="请输入密码"
                                   autocomplete="off" class="layui-input" maxlength="10">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">电话：</label>
                        <div class="layui-input-inline">
                            <input id="m-phone" type="tel" lay-verify="required|number" class="layui-input"
                                   lay-reqText="请输入电话" placeholder="请输入电话" maxlength="11">
                        </div>
                    </div>
                    <div class="layui-form-item">
                        <label class="layui-form-label">年龄：</label>
                        <div class="layui-input-inline">
                            <input id="m-age" type="text" class="layui-input" maxlength="3">
                        </div>
                    </div>
                    <div class="layui-form-item" style="text-align: center; margin-top: 14px">
                        <button class="layui-btn" style="width: 270px;" lay-submit lay-filter="m-register">注册</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    layui.use(['form', 'jquery'], function () {
        var form = layui.form,
            $ = layui.$,
            layer = layui.layer;

        //监听提交
        form.on('submit(register)', function () {
            var id = $("#id").val();
            var password = $("#password").val();
            var name = $("#name").val();
            var age = $("#age").val();
            if (age !== '' && isNaN(age)) {
                layer.msg("提示:年龄只能填数字");
                return false;
            }
            var sex = $('input[name="sex"]:checked').val();
            if (sex == 0) {
                sex = "男";
            } else {
                sex = "女";
            }
            var grade = $("#grade").val();
            var profession = $("#profession").val();

            $.ajax({
                type: "POST",
                url: "/books/StudentRegisterServlet",
                data: {
                    id: id,
                    password: password,
                    name: name,
                    age: age,
                    sex: sex,
                    grade: grade,
                    profession: profession
                },
                dataType: "json",
                success: function (data) {
                    if (data.code == "000000") {
                        layer.msg("提示:注册成功");
                        setTimeout(function () {
                            window.location.href = "../login.jsp"
                        }, 800);
                    } else {
                        layer.msg(data.message);
                    }
                },
                error: function (xhr, errorText, errorType) {
                    layer.msg("" + xhr.status + "=" + errorText + "=" + errorType);
                }
            });
            return false;
        });

        //监听提交
        form.on('submit(m-register)', function () {
            var id = $("#m-id").val();
            var password = $("#m-password").val();
            var name = $("#m-name").val();
            var age = $("#m-age").val();
            if (age !== '' && isNaN(age)) {
                layer.msg("提示:年龄只能填数字");
                return false;
            }
            var phone = $("#m-phone").val();

            $.ajax({
                type: "POST",
                url: "/books/ManagerRegisterServlet",
                data: {
                    id: id,
                    password: password,
                    name: name,
                    age: age,
                    phone: phone
                },
                dataType: "json",
                success: function (data) {
                    if (data.code == "000000") {
                        layer.msg("提示:注册成功");
                        setTimeout(function () {
                            window.location.href = "../login.jsp"
                        }, 800);
                    } else {
                        layer.msg(data.message);
                    }
                },
                error: function (xhr, errorText, errorType) {
                    layer.msg("" + xhr.status + "=" + errorText + "=" + errorType);
                }
            });
            return false;
        });
    });
</script>

</body>
</html>