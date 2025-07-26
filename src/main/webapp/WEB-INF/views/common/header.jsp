<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<div class="header">
    <div class="logo">私有化部署系统</div>
    <div class="user-info">
        <span>${sessionScope.username}</span>
        <a href="/logout" class="logout-btn">退出</a>
    </div>
</div>

<nav class="main-nav">
    <ul>
        <li><a href="/" class="${requestScope.servletPath == '/' ? 'active' : ''}">首页</a></li>
        <li><a href="/dashboard" class="${requestScope.servletPath == '/dashboard' ? 'active' : ''}">数据看板</a></li>
        <li><a href="/plugin/center" class="${requestScope.servletPath.startsWith('/plugin/') ? 'active' : ''}">插件中心</a></li>
    </ul>
</nav>
