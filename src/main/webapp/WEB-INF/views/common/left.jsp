<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
    .belongLogo {
        width: 147px;
        height: 114px;
        margin-bottom: 30px;
        background-image: url('/static/img/index_logo.png');
        background-position: center;
        background-size: 90%;
        background-repeat: no-repeat;
    }
</style>
<!-- 左侧布局 -->
<div class="left">

    <!--左侧容器-->
    <div class="dhview">

        <!-- LOGO -->
        <a href="${pageContext.request.contextPath}/menu/dataIndex/" class="index">
            <div class="belongLogo"></div>
        </a>

        <!-- 导航 -->
        <ul>
            <a href="${pageContext.request.contextPath}/menu/dataIndex/" class="selected">
                <li class="nav-li">
                    <i class="icon i-data-dark"></i>
                    <span class="nav-text">数据</span>
                </li>
            </a>

            <a href="${pageContext.request.contextPath}/menu/huomaIndex/">
                <li class="nav-li">
                    <i class="icon i-hm"></i>
                    <span class="nav-text">活码</span>
                </li>
            </a>

            <a href="${pageContext.request.contextPath}/dwz/">
                <li class="nav-li">
                    <i class="icon i-dwz"></i>
                    <span class="nav-text">短网址</span>
                </li>
            </a>

            <a href="${pageContext.request.contextPath}/config/">
                <li class="nav-li">
                    <i class="icon i-config"></i>
                    <span class="nav-text">配置中心</span>
                </li>
            </a>

            <a href="${pageContext.request.contextPath}/sucai/">
                <li class="nav-li">
                    <i class="icon i-sucai"></i>
                    <span class="nav-text">素材管理</span>
                </li>
            </a>

            <a href="${pageContext.request.contextPath}/user/">
                <li class="nav-li">
                    <i class="icon i-account"></i>
                    <span class="nav-text">账号管理</span>
                </li>
            </a>
        </ul>

        <!-- 账号及版本信息 -->
        <div class="account">
            <%
                // 这里可以添加Java代码获取用户信息
                String username = "admin"; // 示例值，实际应从会话中获取
                String version = "v1.0.0";
                out.println(username + " | " + version);
            %>
        </div>

    </div>
</div>