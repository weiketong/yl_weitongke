<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <title>引流宝 - 安装环境检测</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="shortcut icon" href="<c:url value='/static/img/favicon.png' />">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Arial', sans-serif;
            color: #333;
            line-height: 1.6;
            display: flex;
            justify-content: center;
            min-height: 100vh;
            background: url('<c:url value='/static/img/login-bg.jpg' />') no-repeat center center fixed;
            background-size: cover;
        }

        #app {
            max-width: 1200px;
            width: 100%;
            padding: 20px;
            margin: 80px auto 0;
        }

        .h2-title {
            text-align: center;
            padding: 20px 0;
            font-size: 28px;
            font-weight: 500;
        }

        .container {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            padding: 20px;
            margin-bottom: 20px;
        }

        .logo {
            background: url('<c:url value='/static/img/favicon.png' />') no-repeat center;
            background-size: contain;
            height: 80px;
            margin: 0 auto 20px;
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }

        .table th, .table td {
            padding: 10px;
            text-align: center;
            border-bottom: 1px solid #e0e0e0;
        }

        .table th {
            background-color: #f8f9fa;
            font-weight: 600;
            color: #555;
        }

        .table td {
            color: #333;
        }

        .status-pass {
            color: #28a745;
        }

        .status-fail {
            color: #dc3545;
        }

        .button-view {
            display: flex;
            justify-content: center;
            margin-top: 20px;
            min-height: 40px;
        }

        .install-button {
            background-color: #385fe2;
            color: #fff;
            border: none;
            padding: 10px 25px;
            font-size: 16px;
            border-radius: 12px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .install-button:hover {
            background-color: #0056b3;
        }

        .update {
            font-size: 22px;
            font-weight: 600;
            color: #333;
            margin-bottom: 15px;
            text-align: center;
        }

        .table a {
            color: #007bff;
            text-decoration: none;
        }

        .table a:hover {
            text-decoration: underline;
        }

        .error-message {
            text-align: center;
            color: #dc3545;
            font-size: 16px;
            margin-top: 20px;
        }

        .error-message a {
            display: block;
            color: #007bff;
            text-decoration: underline;
            margin-top: 8px;
        }

        .loader {
            width: 30px;
            height: 30px;
            border: 4px solid #f3f3f3;
            border-top: 4px solid #385fe2;
            border-radius: 50%;
            animation: spin 0.3s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        @media (max-width: 768px) {
            .container {
                padding: 15px;
            }

            .h2-title {
                font-size: 24px;
                padding: 15px 0;
            }

            .table th, .table td {
                padding: 8px;
                font-size: 14px;
            }

            .install-button {
                padding: 8px 20px;
                font-size: 14px;
            }

            .update {
                font-size: 18px;
            }

            .loader {
                width: 24px;
                height: 24px;
                border: 3px solid #f3f3f3;
                border-top: 3px solid #385fe2;
            }
        }
    </style>
</head>
<body>
<div id="app">
    <h2 class="h2-title">安装环境检测</h2>
    <div class="container">
        <div class="logo"></div>
        <table class="table">
            <thead>
            <tr>
                <th>安装环境</th>
                <th>环境要求</th>
                <th>当前情况</th>
                <th>检测结果</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>JDK版本</td>
                <td>JDK1.8</td>
                <td class="current-jdk">-</td>
                <td class="jdk-result">-</td>
            </tr>
            <tr>
                <td>上传权限</td>
                <td>允许上传文件</td>
                <td class="current-upload">-</td>
                <td class="upload-result">-</td>
            </tr>
            </tbody>
        </table>
        <div class="button-view">
            <div class="loader"></div>
        </div>
    </div>
    <div class="container update-container" style="display: none;">
        <p class="update">版本升级</p>
        <table class="table">
            <thead>
            <tr>
                <th>最低版本要求</th>
                <th>升级版本</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>2.3.0</td>
                <td>2.4.0</td>
                <td><a href="<c:url value='/2.4.0' />">立即升级</a></td>
            </tr>
            </tbody>
        </table>
    </div>
</div>

<script>
    async function checkEnvironment() {
        var buttonView = document.querySelector('.button-view');
        var minDelay = 1500;

        var startTime = Date.now();
        try {
            var response = await fetch('<c:url value='/installCheck' />');
            var data = await response.json();

            var elapsedTime = Date.now() - startTime;
            var remainingDelay = Math.max(0, minDelay - elapsedTime);

            await new Promise(resolve => setTimeout(resolve, remainingDelay));

            if (data.code === 200) {

                document.querySelector('.current-jdk').textContent = data.jdkVersion;
                document.querySelector('.jdk-result').innerHTML = data.jdkVersionResultText;
                document.querySelector('.current-upload').textContent = data.uploadResult;
                document.querySelector('.upload-result').innerHTML = data.uploadResultText;

                document.querySelector('.jdk-result').classList.add(data.jdkVersionResultText.includes('失败') ? 'status-fail' : 'status-pass');
                document.querySelector('.upload-result').classList.add(data.uploadResultText.includes('失败') ? 'status-fail' : 'status-pass');

                if (compareVersion(data.jdkVersion,'1.8','17.0') && data.uploadResult === '获得上传权限') {
                    // 修正安装页面路径
                    buttonView.innerHTML = '<button class="install-button" onclick="window.location.href=\'<c:url value='/install.html' />\'">全新安装</button>';
                } else {

                    if((getMajorVersion(data.jdkVersion) < '7.0' || getMajorVersion(data.jdkVersion) > '7.5') && (data.uploadResult === '没有上传权限')) {

                        buttonView.innerHTML = '<p style="color:#013eed;">解决办法：</p><p style="color:#013eed;">1、修改PHP版本为7.0 - 7.5之间；</p><p style="color:#013eed;">2、修改 /console 目录及其子目录的服务器权限为777，<a href="<c:url value='/jietu.png' />" target="blank">点击查看截图</a></p>';
                    }else if(getMajorVersion(data.jdkVersion) < '7.0' || getMajorVersion(data.jdkVersion) > '7.5') {

                        buttonView.innerHTML = '<p style="color:#013eed;">解决办法：修改PHP版本为7.0 - 7.5之间即可，<a href="<c:url value='/jietu2.png' />" target="blank">点击查看截图</a></p>';
                    }else if(data.uploadResult === '没有上传权限') {

                        buttonView.innerHTML = '<p style="color:#013eed;">解决办法：修改 /console 目录及其子目录的服务器权限为777即可，<a href="<c:url value='/jietu.png' />" target="blank">点击查看截图</a></p>';
                    }
                }
            }
        } catch (error) {
            var elapsedTime = Date.now() - startTime;
            var remainingDelay = Math.max(0, minDelay - elapsedTime);
            await new Promise(resolve => setTimeout(resolve, remainingDelay));

            buttonView.innerHTML = `
                    <p class="error-message">
                        安装环境异常，请检查你建立的网站是否选择了java环境。
                        <a href="<c:url value='/static/img/errorIMG.png' />" target="_blank">点击查看解决方法</a>
                    </p>`;
        }
    }

    checkEnvironment();

    function compareVersion(version, min, max) {
        // 解析版本号为数字数组（如 "1.8.0_201" → [1,8]）
        const parts = version.split(/[._-]/).map(Number);
        const mainVersion = parts[0] + parts[1] / 10; // 转换为 1.8 这样的数字

        const minVersion = parseFloat(min);
        const maxVersion = parseFloat(max);

        return mainVersion >= minVersion && mainVersion <= maxVersion;
    }

    function getMajorVersion(version) {
        // 提取主版本号（如 "1.8.0_201" → 1.8，"11.0.12" → 11.0）
        const parts = version.split(/[._-]/).map(Number);
        if (parts.length >= 2) {
            return parts[0] + parts[1] / 10; // 转换为数字（1.8、11.0等）
        }
        return parseFloat(version) || 0;
    }
</script>
</body>
</html>
