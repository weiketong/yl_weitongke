<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>私域引流宝</title>
    <meta charset="utf-8">
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/popper.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/chart.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/ylb.css">
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/static/img/favicon.png">
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/index.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/index.css">
</head>
<body>

<div id="app">

    <!-- 左侧布局 -->
    <jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/left.jsp" />

    <!-- 右侧布局 -->
    <div id="right">

        <h3>数据</h3>
        <div class="data-card" style="background:none;padding:0;">

            <!--数据卡片-->
            <div class="data-card-1"></div>

            <!--图表-->
            <div class="data-card-2">
                <div class="chart-view-container">
                    <div class="chart-view">
                        <canvas id="eachHourPvChart" style="width:100%;"></canvas>
                    </div>

                    <view class="openResourceInfo"></view>
                </div>
            </div>

            <div class="data-card-3">
                <div class="container-view">
                    <div class="uvdata-view">
                        <p class="table-title">近7天UV数据</p>
                        <table class="table" style="text-align: center;font-size:15px;">
                            <thead></thead>
                            <tbody></tbody>
                        </table>
                    </div>
                </div>
            </div>

        </div><!-- data-card -->
    </div><!-- right -->
</div><!-- app -->

</body>
</html>