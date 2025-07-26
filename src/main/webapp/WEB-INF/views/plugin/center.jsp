<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>插件中心 - 私有化部署系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/plugin.css">
</head>
<body>
<div class="page-container">
    <%@ include file="/WEB-INF/views/common/header.jsp" %>

    <main class="content">
        <div class="plugin-header">
            <h1>插件中心</h1>
            <a href="/plugin/upload" class="btn-upload">上传新插件</a>
        </div>

        <!-- 已安装插件 -->
        <div class="plugin-section">
            <h2>已安装插件</h2>

            <c:if test="${empty installedPlugins}">
                <div class="empty-state">
                    <img src="${pageContext.request.contextPath}/static/images/empty-plugin.png" alt="暂无插件">
                    <p>您尚未安装任何插件</p>
                    <a href="#available-plugins" class="btn-primary">浏览可用插件</a>
                </div>
            </c:if>

            <div class="plugin-grid">
                <c:forEach items="${installedPlugins}" var="item">
                    <div class="plugin-card">
                        <div class="plugin-info">
                            <h3>${item.plugin.name}</h3>
                            <p class="plugin-desc">${item.plugin.description}</p>
                            <div class="plugin-meta">
                                <span>作者: ${item.plugin.author}</span>
                                <span>版本: ${item.installedVersion.version}</span>
                            </div>

                            <c:if test="${item.installedVersion.version != item.latestVersion.version}">
                                <div class="update-available">
                                    有新版本: ${item.latestVersion.version}
                                </div>
                            </c:if>
                        </div>

                        <div class="plugin-actions">
                            <button class="btn-action btn-upgrade"
                                    data-plugin-id="${item.plugin.id}"
                                    data-version="${item.latestVersion.version}"
                                    <c:if test="${item.installedVersion.version == item.latestVersion.version}">disabled</c:if>>
                                升级
                            </button>
                            <button class="btn-action btn-uninstall"
                                    data-plugin-id="${item.plugin.id}">
                                卸载
                            </button>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>

        <!-- 可用插件 -->
        <div class="plugin-section" id="available-plugins">
            <h2>可用插件</h2>

            <c:if test="${empty allPlugins}">
                <div class="empty-state">
                    <img src="${pageContext.request.contextPath}/static/images/empty-plugin.png" alt="暂无可用插件">
                    <p>暂无可用插件，请上传插件</p>
                    <a href="/plugin/upload" class="btn-primary">上传插件</a>
                </div>
            </c:if>

            <div class="plugin-grid">
                <c:forEach items="${allPlugins}" var="plugin">
                    <c:set var="isInstalled" value="false" />
                    <c:forEach items="${installedPlugins}" var="installed">
                        <c:if test="${installed.plugin.id == plugin.id}">
                            <c:set var="isInstalled" value="true" />
                        </c:if>
                    </c:forEach>

                    <c:if test="${!isInstalled}">
                        <div class="plugin-card">
                            <div class="plugin-info">
                                <h3>${plugin.name}</h3>
                                <p class="plugin-desc">${plugin.description}</p>
                                <div class="plugin-meta">
                                    <span>作者: ${plugin.author}</span>
                                    <span>最新版本:
                                            <c:set var="latestVersion" value="${pluginService.getLatestPluginVersion(plugin.id)}" />
                                            ${latestVersion.version}
                                        </span>
                                </div>
                            </div>

                            <div class="plugin-actions">
                                <button class="btn-action btn-install"
                                        data-plugin-id="${plugin.id}"
                                        data-version="${latestVersion.version}">
                                    安装
                                </button>
                            </div>
                        </div>
                    </c:if>
                </c:forEach>
            </div>
        </div>
    </main>

    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</div>

<script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
<script src="${pageContext.request.contextPath}/static/js/plugin.js"></script>
</body>
</html>
