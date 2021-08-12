<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>图书管理系统</title>
    <%--    <link rel="stylesheet" href="../layui/css/layui.css">--%>
    <%--    <script src="../layui/layui.js"></script>--%>
    <link rel="stylesheet" href="//unpkg.com/layui@2.6.8/dist/css/layui.css">
    <script src="//unpkg.com/layui@2.6.8/dist/layui.js"></script>
</head>
<body>
<%
    if (request.getParameter("id") == null) {
        response.sendRedirect("../login.jsp");
    }
    String id = request.getParameter("id");
%>
<div class="layui-layout layui-layout-admin">

    <!-- 头部区域 -->
    <div class="layui-header">
        <div class="layui-logo layui-hide-xs layui-bg-black">图书管理系统</div>
        <ul class="layui-nav layui-layout-right">
            <li class="layui-nav-item layui-hide layui-show-md-inline-block">
                <img src="//tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg"
                     class="layui-nav-img">
                <%=id%>
            </li>
        </ul>
    </div>

    <!-- 左侧区域 -->
    <div class="layui-side layui-bg-black">
        <div class="layui-side-scroll">

            <!-- 左侧功能 -->
            <ul class="layui-nav layui-nav-tree">
                <li class="layui-nav-item layui-nav-itemed">
                    <a href="javascript:;">图书大全</a>
                    <dl class="layui-nav-child">
                        <dd><a data-id="1" data-url="Book.jsp" class="site-demo-active"
                               data-title="主页1">主页1</a></dd>
                        <%--home_manager.jsp?id=<%=id%>--%>
                        <dd><a data-id="2" data-url="" class="site-demo-active" data-title="主页2">主页2</a>
                        </dd>
                    </dl>
                </li>
                <li class="layui-nav-item layui-nav-itemed">
                    <a href="javascript:;">图书管理</a>
                    <dl class="layui-nav-child">
                        <dd><a data-id="3" data-url="addBook.jsp" class="site-demo-active"
                               data-title="添加图书">添加图书</a></dd>
                        <dd><a data-id="4" data-url="addBookClass.jsp" class="site-demo-active"
                               data-title="图书分类">图书分类</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item layui-nav-itemed">
                    <a href="javascript:;">图书查询</a>
                    <dl class="layui-nav-child">
                        <dd><a data-id="5" data-url="queryBook.jsp" class="site-demo-active" data-title="查询图书">查询图书</a>
                        </dd>
                        <dd><a data-id="6" data-url="queryBookBorrow.jsp" class="site-demo-active" data-title="查询借阅">查询借阅</a>
                        </dd>
                    </dl>
                </li>
            </ul>
        </div>
    </div>

    <!-- 内容主体区域 -->
    <div class="layui-body">
        <!--   动态选项卡 lay-allowClose表示可删除  -->
        <div class="layui-tab" lay-filter="tabDemo" lay-allowClose="true">
            <ul class="layui-tab-title">
            </ul>
            <div class="layui-tab-content">
            </div>
        </div>
    </div>

    <!-- 底部固定区域 -->
    <div class="layui-footer">
        底部固定区域
    </div>
</div>

<script>
    layui.use(['element', 'layer', 'util'], function () {
        var element = layui.element,
            layer = layui.layer,
            util = layui.util,
            $ = layui.$;

        var active = {
            //在这里给active绑定tab添加、切换和删除事件，后面可通过active调用这些事件
            tabAdd: function (url, id, name) {
                //新增一个Tab项 内容为传入的url页面 传入三个参数，分别对应其标题，tab页面的地址，还有一个规定的id，是标签中data-id的属性值
                element.tabAdd('tabDemo', {
                    title: name,
                    content: '<iframe data-frameid="' + id + '" scrolling="auto" frameborder="0" src="' + url + '" style="width:100%;height:99%;"></iframe>',
                    id: id
                })
                FrameWH(); //计算ifram层的大小
            },
            tabChange: function (id) {
                element.tabChange('tabDemo', id); //用于外部切换到指定的Tab项上，切换到 lay-id="id" 的这一项
            },
            tabDelete: function (id) {
                element.tabDelete("tabDemo", id); //删除
            }
        };

        function FrameWH() {
            var h = $(window).height();
            $("iframe").css("height", h + "px");
        }

        //点击左侧导航栏
        $('.site-demo-active').on('click', function () {
            var dataid = $(this);
            //这时会判断右侧.layui-tab-title属性下的有lay-id属性的li的数目，即已经打开的tab项数目
            if ($(".layui-tab-title li[lay-id]").length <= 0) {
                active.tabAdd(dataid.attr("data-url"), dataid.attr("data-id"), dataid.attr("data-title"));
            } else {
                if ($(".layui-tab-title li[lay-id]").length > 9){
                    layer.msg('当前打开的页面过多，请先关闭'); //最多为10个
                    return;
                }
                //判断该tab项是否以及存在
                var isData = false; //初始化一个标志，为false说明未打开该tab项 为true则说明已有
                $.each($(".layui-tab-title li[lay-id]"), function () {
                    //如果点击左侧菜单栏所传入的id 在右侧tab项中的lay-id属性可以找到，则说明该tab项已经打开
                    if ($(this).attr("lay-id") == dataid.attr("data-id")) {
                        isData = true;
                    }
                })
                if (isData == false) {
                    //标志为false 新增一个tab项
                    active.tabAdd(dataid.attr("data-url"), dataid.attr("data-id"), dataid.attr("data-title"));
                }
            }
            //最后不管是否新增tab，最后都转到要打开的选项页面上
            active.tabChange(dataid.attr("data-id"));
        });

        //头部事件
        util.event('lay-header-event', {
            //左侧菜单事件
            menuLeft: function (othis) {
                layer.msg('展开左侧菜单的操作', {icon: 0});
            }
            , menuRight: function () {
                layer.open({
                    type: 1
                    , content: '<div style="padding: 15px;">更换主题</div>'
                    , area: ['260px', '100%']
                    , offset: 'rt' //右上角
                    , anim: 5
                    , shadeClose: true
                });
            }
        });
    });
</script>
</body>
</html>