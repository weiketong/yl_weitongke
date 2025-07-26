<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>引流宝 - 私域流量获取与监控工具</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link href="${pageContext.request.contextPath}/static/css/font-awesome.min.css" rel="stylesheet">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#385EE2',
                        secondary: '#666666',
                        accent: '#4CAF50',
                        neutral: '#F5F5F5',
                        dark: '#333333',
                    },
                    fontFamily: {
                        inter: ['Inter', 'system-ui', 'sans-serif'],
                    },
                }
            }
        }
    </script>
    <style>
        .content-auto {
            content-visibility: auto;
        }
        .text-shadow {
            text-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .btn-hover {
            transition-all: 300ms;
        }
        .btn-hover:hover {
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
            transform: translateY(-1px);
        }
        .feature-card {
            background-color: white;
            border-radius: 0.75rem;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
            padding: 1.5rem;
            transition-all: 300ms;
        }
        .feature-card:hover {
            box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
            transform: translateY(-2px);
        }
    </style>
</head>
<body class="bg-gray-50 font-inter text-secondary">
<div id="app" class="min-h-screen flex flex-col">
    <!-- 导航栏 -->
    <nav class="bg-white shadow-sm sticky top-0 z-50 transition-all duration-300" id="navbar">
        <div class="container mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-16">
                <div class="flex items-center">
                    <a href="#" class="flex items-center">
                        <div>
                            <img src="<c:url value='/static/img/index_logo.png' />" style="width:64px;" />
                        </div>
                    </a>
                </div>
                <div class="hidden md:flex items-center space-x-8">
                    <a href="#features" class="text-secondary hover:text-primary transition-colors">功能</a>
                    <a href="#changelog" class="text-secondary hover:text-primary transition-colors">更新日志</a>
                    <a href="#support" class="text-secondary hover:text-primary transition-colors">支持作者</a>
                    <a href="https://docs.qq.com/doc/DREdWVGJxeFFOSFhI" target="_blank" class="btn-hover bg-primary text-white px-5 py-2 rounded-lg">快速上手</a>
                </div>
                <div class="md:hidden flex items-center">
                    <button id="menu-toggle" class="text-secondary hover:text-primary">
                        <i class="fa fa-bars text-2xl"></i>
                    </button>
                </div>
            </div>
        </div>
        <!-- 移动端菜单 -->
        <div id="mobile-menu" class="hidden md:hidden bg-white border-t">
            <div class="container mx-auto px-4 py-3 space-y-3">
                <a href="#features" class="block text-secondary hover:text-primary py-2">功能</a>
                <a href="#changelog" class="block text-secondary hover:text-primary py-2">更新日志</a>
                <a href="#support" class="block text-secondary hover:text-primary py-2">支持作者</a>
                <a href="https://docs.qq.com/doc/DREdWVGJxeFFOSFhI" target="_blank" class="block btn-hover bg-primary text-white px-5 py-2 rounded-lg text-center">快速上手</a>
            </div>
        </div>
    </nav>

    <!-- 英雄区 -->
    <header class="relative bg-gradient-to-br from-primary/90 to-primary py-16 md:py-24 overflow-hidden">
        <div class="absolute inset-0 overflow-hidden opacity-10">
            <div class="absolute -right-20 -top-20 w-96 h-96 rounded-full bg-white blur-3xl"></div>
            <div class="absolute -left-20 bottom-0 w-80 h-80 rounded-full bg-white blur-3xl"></div>
        </div>
        <div class="container mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
            <div class="max-w-4xl mx-auto text-center">
                <h1 class="text-[clamp(2rem,5vw,3.5rem)] font-bold text-white mb-6 leading-tight text-shadow">
                    私域流量获取与监控工具
                </h1>
                <p class="text-[clamp(1rem,2vw,1.25rem)] text-white/90 mb-10 max-w-2xl mx-auto">
                    多平台引流增效，全方位数据监控，助力企业私域流量增长
                </p>
                <div class="flex flex-col sm:flex-row justify-center gap-4">
                    <a href="https://docs.qq.com/doc/DREdWVGJxeFFOSFhI" target="_blank" class="btn-hover bg-white/20 text-white px-8 py-3 rounded-lg font-medium backdrop-blur-sm border border-white/30">
                        快速上手 <i class="fa fa-arrow-right ml-2"></i>
                    </a>
                    <a href="<c:url value='/install/?from=index.jsp' />" target="_blank" class="btn-hover bg-white/20 text-white px-8 py-3 rounded-lg font-medium backdrop-blur-sm border border-white/30">
                        立即安装 <i class="fa fa-download ml-2"></i>
                    </a>
                    <a href="<c:url value='/console/login/?from=index.jsp' />" target="_blank" class="btn-hover bg-white/20 text-white px-8 py-3 rounded-lg font-medium backdrop-blur-sm border border-white/30">
                        登录后台 <i class="fa fa-arrow-right ml-2"></i>
                    </a>
                </div>
            </div>
        </div>
        <div class="absolute bottom-0 left-0 right-0">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1440 120">
                <path fill="#F9FAFB" fill-opacity="1" d="M0,64L80,69.3C160,75,320,85,480,80C640,75,800,53,960,48C1120,43,1280,53,1360,58.7L1440,64L1440,120L1360,120C1280,120,1120,120,960,120C800,120,640,120,480,120C320,120,160,120,80,120L0,120Z"></path>
            </svg>
        </div>
    </header>

    <!-- 主要内容 -->
    <main class="flex-grow">
        <!-- 功能特性 -->
        <section id="features" class="py-16 bg-white">
            <div class="container mx-auto px-4 sm:px-6 lg:px-8">
                <div class="text-center mb-16">
                    <h2 class="text-[clamp(1.5rem,3vw,2.5rem)] font-bold text-dark mb-4">强大功能</h2>
                    <p class="text-secondary max-w-2xl mx-auto">引流宝提供全方位的私域流量运营解决方案，帮助企业高效获取、管理和转化私域流量</p>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                    <!-- 功能卡片1 -->
                    <div class="feature-card">
                        <div class="w-14 h-14 bg-primary/10 rounded-lg flex items-center justify-center mb-5">
                            <i class="fa fa-bullhorn text-2xl text-primary"></i>
                        </div>
                        <h3 class="text-xl font-semibold text-dark mb-3">多平台引流</h3>
                        <p class="text-gray-600">支持微信、抖音、快手等多平台引流，提供多种引流方式和策略，提高引流效率。</p>
                    </div>

                    <!-- 功能卡片2 -->
                    <div class="feature-card">
                        <div class="w-14 h-14 bg-primary/10 rounded-lg flex items-center justify-center mb-5" style="color: #4065e3">
                            <i class="fa fa-bar-chart text-2xl text-primary"></i>
                        </div>
                        <h3 class="text-xl font-semibold text-dark mb-3">数据监控</h3>
                        <p class="text-gray-600">实时监控引流数据和用户行为，提供详细数据分析和报表，帮助优化引流效果。</p>
                    </div>

                    <!-- 功能卡片3 -->
                    <div class="feature-card">
                        <div class="w-14 h-14 bg-primary/10 rounded-lg flex items-center justify-center mb-5">
                            <i class="fa fa-qrcode text-2xl text-primary"></i>
                        </div>
                        <h3 class="text-xl font-semibold text-dark mb-3">活码系统</h3>
                        <p class="text-gray-600">提供群活码、客服码、渠道码等多种活码类型，支持自动切换和数据统计。</p>
                    </div>

                    <!-- 功能卡片4 -->
                    <div class="feature-card">
                        <div class="w-14 h-14 bg-primary/10 rounded-lg flex items-center justify-center mb-5">
                            <i class="fa fa-link text-2xl text-primary"></i>
                        </div>
                        <h3 class="text-xl font-semibold text-dark mb-3">微信群控管理工具</h3>
                        <p class="text-gray-600">支持对一个或多个个人微信进行网页操作，聊天、加好友、发朋友圈等。</p>
                    </div>

                    <!-- 功能卡片5 -->
                    <div class="feature-card">
                        <div class="w-14 h-14 bg-primary/10 rounded-lg flex items-center justify-center mb-5">
                            <i class="fa fa-plug text-2xl text-primary"></i>
                        </div>
                        <h3 class="text-xl font-semibold text-dark mb-3">插件扩展</h3>
                        <p class="text-gray-600">支持插件扩展，如外部跳微信插件等，满足多样化的业务需求和场景。</p>
                    </div>

                    <!-- 功能卡片6 -->
                    <div class="feature-card">
                        <div class="w-14 h-14 bg-primary/10 rounded-lg flex items-center justify-center mb-5">
                            <i class="fa fa-users text-2xl text-primary"></i>
                        </div>
                        <h3 class="text-xl font-semibold text-dark mb-3">用户管理</h3>
                        <p class="text-gray-600">提供完善的用户账号注册和管理系统，支持多角色权限控制和数据安全保护。</p>
                    </div>
                </div>
            </div>
        </section>

        <!-- 支持作者 -->
        <section id="support" class="py-16 bg-white">
            <div class="container mx-auto px-4 sm:px-6 lg:px-8">
                <div class="text-center mb-12">
                    <h2 class="text-[clamp(1.5rem,3vw,2.5rem)] font-bold text-dark mb-4">支持作者</h2>
                    <p class="text-secondary max-w-2xl mx-auto">视个人能力适当支持作者，帮助项目持续更新和维护</p>
                </div>

                <div class="max-w-3xl mx-auto">
                    <div class="bg-gradient-to-br from-primary/5 to-primary/10 rounded-2xl p-8 shadow-sm">
                        <div class="text-center mb-8">
                            <p class="text-lg text-secondary mb-2">您的支持是项目持续发展的动力</p>
                            <p class="text-dark font-medium">感谢每一位支持者的慷慨捐赠</p>
                        </div>

                        <div class="bg-white rounded-xl shadow-sm p-6 text-center">
                            <div class="p-2 rounded-lg inline-block mb-3">
                                <img src="<c:url value='/static/img/pay_QR.JPG' />" alt="微信支付二维码" class="w-48 h-88">
                            </div>
                            <p class="text-sm text-gray-500">微信扫码支持作者</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <!-- 页脚 -->
    <footer class="bg-dark text-white py-12">
        <div class="container mx-auto px-4 sm:px-6 lg:px-8">
            <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                <div>
                    <div class="flex items-center mb-4">
                        <span class="ml-3 text-xl font-semibold text-white">私域引流宝</span>
                    </div>
                    <p class="text-gray-400 mb-4">致力于获取私域流量，多平台引流增效，数据监控工具</p>
                    <div class="flex space-x-4">
                        <a href="https://github.com/likeyun/liKeYun_Ylb" target="_blank" class="text-gray-400 hover:text-white transition-colors">
                            <i class="fa fa-github text-xl"></i>
                        </a>
                        <a href="#" class="text-gray-400 hover:text-white transition-colors">
                            <i class="fa fa-weibo text-xl"></i>
                        </a>
                        <a href="#" class="text-gray-400 hover:text-white transition-colors">
                            <i class="fa fa-wechat text-xl"></i>
                        </a>
                    </div>
                </div>

                <div>
                    <h3 class="text-lg font-semibold mb-4">快速链接</h3>
                    <ul class="space-y-2">
                        <li><a href="https://docs.qq.com/doc/DREdWVGJxeFFOSFhI" target="_blank" class="text-gray-400 hover:text-white transition-colors">快速上手</a></li>
                        <li><a href="<c:url value='/install' />" target="_blank" class="text-gray-400 hover:text-white transition-colors">安装指南</a></li>
                        <li><a href="<c:url value='/console/login' />" target="_blank" class="text-gray-400 hover:text-white transition-colors">管理后台</a></li>
                        <li><a href="#features" class="text-gray-400 hover:text-white transition-colors">功能介绍</a></li>
                        <li><a href="#changelog" class="text-gray-400 hover:text-white transition-colors">更新日志</a></li>
                    </ul>
                </div>

                <div>
                    <h3 class="text-lg font-semibold mb-4">关于我们</h3>
                    <ul class="space-y-2">
                        <li><a href="https://segmentfault.com/u/tanking" target="_blank" class="text-gray-400 hover:text-white transition-colors">作者博客</a></li>
                        <li><a href="https://github.com/likeyun/liKeYun_Ylb" target="_blank" class="text-gray-400 hover:text-white transition-colors">开源仓库</a></li>
                        <li><a href="#" class="text-gray-400 hover:text-white transition-colors">联系我们</a></li>
                    </ul>
                </div>
            </div>

            <div class="border-t border-gray-800 mt-8 pt-8 text-center text-gray-500 text-sm">
                <p>© 2025 引流宝. 本软件遵循 MIT 开源协议，部分页面样式采用likeyun开源代码提供</p>
            </div>
        </div>
    </footer>
</div>

<script>
    // 导航栏滚动效果
    var navbar = document.getElementById('navbar');
    window.addEventListener('scroll', () => {
        if (window.scrollY > 50) {
        navbar.classList.add('shadow-md', 'bg-white/95', 'backdrop-blur-sm');
        navbar.classList.remove('shadow-sm');
    } else {
        navbar.classList.remove('shadow-md', 'bg-white/95', 'backdrop-blur-sm');
        navbar.classList.add('shadow-sm');
    }
    });

    // 移动端菜单切换
    var menuToggle = document.getElementById('menu-toggle');
    var mobileMenu = document.getElementById('mobile-menu');
    menuToggle.addEventListener('click', () => {
        mobileMenu.classList.toggle('hidden');
    });

    // 平滑滚动
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                window.scrollTo({
                    top: target.offsetTop - 80,
                    behavior: 'smooth'
                });
                // 关闭移动端菜单
                if (!mobileMenu.classList.contains('hidden')) {
                    mobileMenu.classList.add('hidden');
                }
            }
        });
    });
</script>
</body>
</html>