<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>配置中心</title>
    <meta charset="utf-8">
    <link rel="stylesheet" href="<c:url value='/static/css/bootstrap.min.css' />">
    <link rel="stylesheet" href="<c:url value='/static/css/ylb.css' />">
    <link rel="shortcut icon" href="<c:url value='/static/img/logo.png' />">
    <script type="text/javascript" src="<c:url value='/static/js/jquery.min.js' />"></script>
    <script type="text/javascript" src="<c:url value='/static/js/popper.min.js' />"></script>
    <script type="text/javascript" src="<c:url value='/static/js/bootstrap.min.js' />"></script>
    <script type="text/javascript" src="<c:url value='/static/js/qrcode.min.js' />"></script>
    <script type="text/javascript">
        var timestamp = new Date().getTime();
        var script = document.createElement('script');
        script.type = 'text/javascript';
        script.src = '/static/js/config.js?v=' + timestamp;
        document.head.appendChild(script);
    </script>
    <style>

        /* 选中样式 */
        .usergroup_selected {
            color: rgb(59,94,225);
            background: rgba(59,94,225,0.1);
            cursor: pointer;
            padding: 5px 12px;
            border-radius: 100px;
            font-size: 14px;
            margin-right: 6px;
            margin-bottom: 10px;
            float: left;
        }

        /* 未选中样式 */
        .unselected {
            background-color: #eee;
            color: #666;
            cursor: pointer;
            padding: 5px 12px;
            border-radius: 100px;
            font-size: 14px;
            margin-right: 6px;
            margin-bottom: 10px;
            float: left;
        }
    </style>
</head>
<body>

<div id="app">

    <!-- 左侧 -->
    <jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/left.jsp" />

    <!-- 右侧 -->
    <div id="right">

        <h3>配置中心</h3>
        <div class="data-card">

            <!-- 按钮区域 -->
            <div class="button-view" id="button-view" style="display:none;">

                <!--flex布局按钮容器-->
                <div class="flex-button-view">

                    <!--导航-->
                    <div class="button-daohang">
                        <button class="default-btn">域名/落地页</button>
                    </div>

                    <!--功能-->
                    <div class="button-gongneng">
                        <button class="tint-btn"
                                data-toggle="modal"
                                data-target="#addDomainNameModal"
                                style="margin-left: 5px;"
                                onclick="initialize_addDomainName();">添加域名/落地页
                        </button>
                    </div>
                </div>

            </div>

            <!-- 列表区域 -->
            <div class="data-list">

                <table class="table">
                    <thead></thead>
                    <tbody></tbody>
                </table>
            </div><!-- data-list -->

            <p class="loading" style="display: none;"></p>

            <!-- 分页 -->
            <div class="fenye"></div>

        </div><!-- data-card -->
    </div><!-- right -->

    <!-- 添加域名/落地页 -->
    <div class="modal fade" id="addDomainNameModal">
        <div class="modal-dialog" style="max-width:650px;">
            <div class="modal-content">

                <!-- 头部 -->
                <div class="modal-header">
                    <h4 class="modal-title">添加域名/落地页</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <!-- 表单 -->
                <div class="modal-body">
                    <form id="addDomainName">
                        <span class="text">域名/落地页</span>
                        <input type="text" name="domain" class="form-control" id="domain" autocomplete="off" placeholder="http:// 或 https:// 开头">

                        <span class="text">备注</span>
                        <input type="text" name="domain_beizhu" class="form-control" id="domain_beizhu" autocomplete="off" placeholder="备注信息，可留空">

                        <span class="text">[域名/落地页]类型</span>
                        <select name="domain_type" class="form-control" id="domain_type">
                            <option value="">选择类型</option>
                            <option value="1">入口域名</option>
                            <option value="2">落地域名</option>
                            <option value="3">短链域名</option>
                            <option value="5" title="例如阿里云OSS，腾讯云COS">对象存储域名</option>
                            <option value="6">轮询域名</option>
                        </select>
                    </form>
                </div>

                <!-- 底部操作 -->
                <div class="modal-footer">
                    <div class="footer-btn">
                        <div class="faqnav" title="阅读使用文档">
                            <span class="faq"><a href="<c:url value='/faq?faq=config' />" target="_blank">?</a></span>  <!-- 修正链接路径 -->
                        </div>
                        <div class="btnnav">
                            <button type="button" class="default-btn" onclick="addDomainName();">立即添加</button>
                        </div>
                    </div>

                </div><!-- modal-footer -->

                <!-- 操作反馈 -->
                <div class="result"></div>

            </div><!-- modal-content -->
        </div><!-- modal-dialog -->
    </div><!-- addDomainNameModal -->

    <!-- 确定删除域名 -->
    <div class="modal fade" id="DelDomainModal">
        <div class="modal-dialog">
            <div class="modal-content">

                <!-- 头部 -->
                <div class="modal-header">
                    <h4 class="modal-title">删除域名</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div><!-- modal-header -->

                <!-- 内容 -->
                <div class="modal-body">
                    删除提示：在任何地方使用了该域名，只要不删除域名的解析，本次删除不会影响之前创建的活码、链接等的使用！
                </div><!-- modal-body -->

                <!-- 底部操作 -->
                <div class="modal-footer"></div><!-- modal-footer -->

                <!-- 操作反馈 -->
                <div class="result"></div>

            </div><!-- modal-content -->
        </div><!-- modal-dialog -->
    </div><!-- DelDomainModal -->
    <!-- 全局信息提示框 -->
    <div id="notification">
        <div id="notification-text"></div>
    </div>

</div><!-- app -->

</body>
</html>