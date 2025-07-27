<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>管理员登录</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,maximum-scale=1.0,user-scalable=0,viewport-fit=cover">
    <!-- 使用JSTL标签处理静态资源路径 -->
    <link rel="stylesheet" href="<c:url value='/static/css/bootstrap.min.css' />">
    <link rel="stylesheet" href="<c:url value='/static/css/ylb.css' />">
    <link rel="shortcut icon" href="<c:url value='/static/img/logo.png' />">
    <script type="text/javascript" src="<c:url value='/static/js/jquery.min.js' />"></script>
    <script type="text/javascript" src="<c:url value='/static/js/bootstrap.min.js' />"></script>
    <style>
        body {
            background: url('<c:url value='/static/img/login-bg.jpg' />') no-repeat center center fixed;
            background-size: cover;
        }
    </style>
</head>
<body>

<div id="app">

    <!--formBox-->
    <div class="formBox">

        <!--form-->
        <div class="form-box">
            <form onsubmit="return false" id="loginCheck">
                <label>管理员账号</label>
                <input type="text" class="form-control" autocomplete="off" placeholder="输入管理员账号" name="user_name" />
                <label>管理员密码</label>
                <input type="password" class="form-control" placeholder="输入管理员密码" name="user_pass" />
                <button class="form-control-login" onclick="loginCheck();">立即登录</button>
                <div class="links">
                    <a href="<c:url value='/find.html' />" class="link">找回密码</a>
                    <a href="<c:url value='/reg.html' />" class="link">注册账号</a>
                </div>
            </form>
        </div>

    </div>
    <!--result-->
    <p class="loginresult"></p>

</div><!-- app -->


<script type="text/javascript">

    function loginCheck(){

        // 验证账号
        $.ajax({
            type: "POST",
            url: "<c:url value='/loginCheck' />",
            contentType: "application/json;charset=UTF-8",
            dataType: "json",
            beforeSend: function() {
                // 获取输入值并去除空格
                const username = $("input[name='user_name']").val().trim();
                const password = $("input[name='user_pass']").val().trim();

                // 校验非空
                if (username === "") {
                    showErrorResult("账号未填写");
                    return false; // 阻止请求发送
                }
                if (password === "") {
                    showErrorResult("密码未填写");
                    return false; // 阻止请求发送
                }
            },
            data: JSON.stringify({
                userName: $("input[name='user_name']").val().trim(),
                password: $("input[name='user_pass']").val().trim()
            }),
            success: function(res){

                // 成功
                if(res.code == 200){

                    // 操作反馈（200状态码）
                    showSuccessResult(res.msg)

                    // 0.5秒后跳转到首页
                    redirectPage('<c:url value='/menu/index' />', 500);

                }else{

                    // 操作反馈（非200状态码）
                    showErrorResult(res.msg)
                }
            },
            error: function(xhr, status, error) {
                // 详细错误信息展示
                let errorMsg = '服务器发生错误！';
                if (xhr.responseText) {
                    try {
                        let errorObj = JSON.parse(xhr.responseText);
                        errorMsg += ' 原因：' + errorObj.msg;
                    } catch (e) {
                        errorMsg += ' 详情：' + xhr.responseText;
                    }
                }
                showErrorResult(errorMsg)
            }
        });
    }

    // 打开操作反馈（操作成功）
    function showSuccessResult(content){
        $('#app .loginresult').html('<div class="success">'+content+'</div>');
        $('#app .loginresult .success').css('display','block');
        setTimeout('hideResult()', 2500); // 2.5秒后自动关闭
    }

    // 打开操作反馈（操作失败）
    function showErrorResult(content){
        $('#app .loginresult').html('<div class="error">'+content+'</div>');
        $('#app .loginresult .error').css('display','block');
        setTimeout('hideResult()', 2500); // 2.5秒后自动关闭
    }

    // 关闭操作反馈
    function hideResult(){
        $("#app .loginresult .success").css("display","none");
        $("#app .loginresult .error").css("display","none");
        $("#app .loginresult .success").text('');
        $("#app .loginresult .error").text('');
    }

    // 跳转到指定路径
    function redirectPage(pagePath,timeout){
        setTimeout(function() {
            location.href = pagePath;
        }, timeout);
    }

</script>


</body>
</html>
