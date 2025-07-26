<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>数据看板 - 私有化部署系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/dashboard.css">
</head>
<body>
<div class="page-container">
    <%@ include file="/WEB-INF/views/common/header.jsp" %>

    <main class="content">
        <div class="dashboard-header">
            <h1>系统数据看板</h1>
            <div class="date-filter">
                <select id="dateRange">
                    <option value="today">今日</option>
                    <option value="week" selected>本周</option>
                    <option value="month">本月</option>
                    <option value="year">全年</option>
                </select>
            </div>
        </div>

        <div class="stats-grid">
            <div class="stat-panel">
                <div class="panel-title">总用户数</div>
                <div class="panel-value">${totalUsers}</div>
                <div class="panel-trend">
                    <span class="up">↑ 5.2%</span> 较上月
                </div>
            </div>

            <div class="stat-panel">
                <div class="panel-title">插件总数</div>
                <div class="panel-value">${totalPlugins}</div>
                <div class="panel-trend">
                    <span class="up">↑ 2.0%</span> 较上月
                </div>
            </div>

            <div class="stat-panel">
                <div class="panel-title">活跃插件</div>
                <div class="panel-value">${activePlugins}</div>
                <div class="panel-trend">
                    <span class="down">↓ 1.0%</span> 较上月
                </div>
            </div>

            <div class="stat-panel">
                <div class="panel-title">系统版本</div>
                <div class="panel-value">${systemVersion}</div>
                <div class="panel-trend">
                    <span class="normal">最新版本</span>
                </div>
            </div>
        </div>

        <div class="charts-container">
            <div class="chart-panel">
                <div class="panel-title">插件使用统计</div>
                <div class="chart-placeholder">
                    <!-- 图表占位 -->
                    <img src="${pageContext.request.contextPath}/static/images/chart-placeholder.png"
                         alt="插件使用统计图表" class="chart-img">
                </div>
            </div>

            <div class="chart-panel">
                <div class="panel-title">系统资源占用</div>
                <div class="chart-placeholder">
                    <!-- 图表占位 -->
                    <img src="${pageContext.request.contextPath}/static/images/resource-placeholder.png"
                         alt="系统资源占用图表" class="chart-img">
                </div>
            </div>
        </div>
    </main>

    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</div>
</body>
</html>
