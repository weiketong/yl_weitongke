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

                        <button class="tint-btn"
                                data-toggle="modal"
                                data-target="#notiConfigModal"
                                onclick="getNotificationConfig()"
                                style="margin-left: 5px;">通知渠道</button>
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

    <!-- 添加授权用户组 -->
    <div class="modal fade" id="addUsergroupModal">
        <div class="modal-dialog" style="max-width:700px;">
            <div class="modal-content">

                <div class="modal-header">
                    <h4 class="modal-title">添加授权用户组</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <div class="modal-body">
                    <span class="text" style="margin-bottom: 10px;">选择一个或多个用户组</span>
                    <span id="selectedTags"></span>
                    <span id="availableTags"></span>
                    <input type="hidden" class="newUsergroupArray" />
                    <input type="hidden" class="domain_id" />
                </div>

                <div class="modal-footer">
                    <div class="footer-btn">
                        <div class="faqnav" title="阅读使用指南">
                            <span class="faq"><a href="<c:url value='/faq?faq=config' />" target="_blank">?</a></span>  <!-- 修正链接路径 -->
                        </div>
                        <div class="btnnav">
                            <button type="button" class="default-btn" onclick="setUsergroup()">立即添加</button>
                        </div>
                    </div>
                </div>
                <div class="result"></div>
            </div>
        </div>
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

    <!-- 通知渠道配置 -->
    <div class="modal fade" id="notiConfigModal">
        <div class="modal-dialog" style="max-width: 800px;">
            <div class="modal-content">

                <!-- 头部 -->
                <div class="modal-header">
                    <h4 class="modal-title">通知渠道配置</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <!-- 表单 -->
                <div class="modal-body">
                    <form id="notiConfig">

                            <span class="text" style="width:96%;color:#333;font-size:19px;">
                                企业微信
                                <button type="button" class="tint-btn" style="padding:3px 10px;float:right;" onclick="testQywx()">测试一下</button>
                            </span>
                        <div style="width:96%;height:70px;margin:-5px auto 10px;display:flex;">
                            <div style="flex:1;margin-right:7px;">
                                <span class="text">corpid</span>
                                <input type="text" name="corpid" class="form-control" placeholder="企业微信appid">
                            </div>
                            <div style="flex:1;">
                                <span class="text">corpsecret</span>
                                <input type="text" name="corpsecret" class="form-control" placeholder="应用appsecret">
                            </div>
                        </div>
                        <div style="width:96%;height:70px;margin:0 auto 30px;display:flex;">
                            <div style="flex:1;margin-right:7px;">
                                <span class="text">接收者id</span>
                                <input type="text" name="touser" class="form-control" placeholder="即touser">
                            </div>
                            <div style="flex:1;">
                                <span class="text">应用id</span>
                                <input type="text" name="agentid" class="form-control" placeholder="即agentid">
                            </div>
                        </div>

                        <p style="width:96%;height:1px;background:#ddd;margin:0 auto;"></p>

                        <span class="text" style="width:96%;color:#333;font-size:19px;">
                                电子邮件
                                <button type="button" class="tint-btn" style="padding:3px 10px;float:right;" onclick="testEmail()">测试一下</button>
                            </span>
                        <div style="width:96%;height:70px;margin:-5px auto 10px;display:flex;">
                            <div style="flex:1;margin-right:7px;">
                                <span class="text">发送端邮箱账号</span>
                                <input type="text" name="email_acount" class="form-control" placeholder="用于发送电子邮件的邮箱">
                            </div>
                            <div style="flex:1;margin-right:7px;">
                                <span class="text">发送端邮箱密码</span>
                                <input type="text" name="email_pwd" class="form-control" placeholder="登录授权码">
                            </div>
                        </div>
                        <div style="width:96%;height:70px;margin:0 auto 30px;display:flex;">
                            <div style="flex:1;margin-right:7px;">
                                <span class="text">SMTP邮件服务器</span>
                                <input type="text" name="email_smtp" class="form-control" placeholder="发送端的邮件服务器">
                            </div>
                            <div style="flex:1;margin-right:7px;">
                                <span class="text">邮件服务器端口</span>
                                <input type="text" name="email_port" class="form-control" placeholder="发送端的邮件服务器端口">
                            </div>
                            <div style="flex:1;">
                                <span class="text">接收通知邮箱</span>
                                <input type="text" name="email_receive" class="form-control" placeholder="用于接收通知的电子邮箱">
                            </div>
                        </div>

                        <p style="width:96%;height:1px;background:#ddd;margin:0 auto;"></p>

                        <span class="text" style="width:96%;color:#333;font-size:19px;">Bark、Server酱、HTTP</span>
                        <div style="width:96%;height:70px;margin:-5px auto 20px;display:flex;">
                            <div style="flex:1;margin-right:7px;">
                                <span class="text">Bark：URL</span>
                                <input type="text" name="bark_url" class="form-control" placeholder="粘贴Bark APP复制过来的URL">
                            </div>
                            <div style="flex:1;margin-right:7px;">
                                <span class="text">Server酱：SendKey</span>
                                <input type="text" name="SendKey" class="form-control" placeholder="SendKey">
                            </div>
                            <div style="flex:1;">
                                <span class="text">HTTP：接收POST的URL</span>
                                <input type="text" name="http_url" class="form-control" placeholder="https://">
                            </div>
                        </div>
                    </form>

                    <p style="margin-top:30px;font-size:15px;text-align:center;color:#999">
                        👉 <a href="<c:url value='/faq?faq=config' />" target="_blank">以上参数如何获取？</a>  <!-- 修正链接路径 -->
                    </p>
                </div>

                <!-- 底部操作 -->
                <div class="modal-footer">
                    <div class="footer-btn">
                        <div class="faqnav" title="阅读使用文档">
                            <span class="faq"><a href="<c:url value='/faq?faq=config' />" target="_blank">?</a></span>  <!-- 修正链接路径 -->
                        </div>
                        <div class="btnnav">
                            <button type="button" class="default-btn" onclick="notiConfig()">保存配置</button>
                        </div>
                    </div>
                </div><!-- modal-footer -->

                <!-- 操作反馈 -->
                <div class="result"></div>

            </div><!-- modal-content -->
        </div><!-- modal-dialog -->
    </div><!-- notiConfigModal -->

    <!-- 全局信息提示框 -->
    <div id="notification">
        <div id="notification-text"></div>
    </div>

</div><!-- app -->

</body>
</html>