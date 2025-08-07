<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<title></title>
	<meta charset="utf-8">
	<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/popper.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/qrcode.min.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/clipboard.min.js"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/ylb.css">
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/static/img/logo.png">
	<script type="text/javascript" src="${pageContext.request.contextPath}/static/js/qun.js"></script>
</head>
<body>

<div id="app">
	
	<!-- 左侧 -->
    <jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/common/left.jsp" />

	<!-- 右侧 -->
	<div id="right">
	    
		<h3>活码 ➜ <span class="mbx">群活码</span></h3>
		<div class="data-card">
		    
			<!-- 按钮区域 -->
			<div class="button-view" id="button-view" style="display:none;">
			    
			    <!--flex布局按钮容器-->
			    <div class="flex-button-view">
			        
    			    <!--导航-->
    			    <div class="button-daohang">
    			        <a href="${pageContext.request.contextPath}/qun/"><button class="default-btn">群活码</button></a>
    			        <a href="${pageContext.request.contextPath}/kf/"><button class="tint-btn" style="margin-left: 5px;">客服码</button></a>
    				    <a href="${pageContext.request.contextPath}/channel/"><button class="tint-btn" style="margin-left: 5px;">渠道码</button></a>
    			    </div>
    			    
    			    <!--功能-->
    			    <div class="button-gongneng">
    			        
    			        <button class="tint-btn" 
    			    	data-toggle="modal" 
    			    	data-target="#createQunModal" 
    			    	onclick="getDomainNameList('create')">创建群活码</button>
    			    	
    			    	<button class="tint-btn" 
    			    	data-toggle="modal" 
    			    	data-target="#bingliuModal" 
    		    		onclick="getBingliuList()">并流管理</button>
    			    </div>
			    </div><!--flex-button-view -->
			</div>

			<!-- 数据列表 -->
			<div class="data-list">
				<table class="table">
				    <thead></thead>
				    <tbody></tbody>
				</table>
			</div>
			
			<!--未加载出数据时显示的容器-->
			<p class="loading" style="display: none;"></p>
			
			<!-- 分页 -->
			<div class="fenye"></div>
			
		</div><!-- data-card -->
	</div><!-- right -->

	<!-- 创建群活码 -->
    <div class="modal fade" id="createQunModal">
        <div class="modal-dialog" style="max-width: 650px;">
            <div class="modal-content">
                
                <!-- 头部 -->
                <div class="modal-header">
                    <h4 class="modal-title">创建群活码</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                
                <!-- 表单 -->
                <div class="modal-body">
                    <form id="createQun">
                        <span class="text">标题</span>
                        <input type="text" name="qun_title" class="form-control" autocomplete="off" placeholder="标题或群名称">
                        
                        <div style="width:100%;height:70px;margin:-5px auto 20px;display:flex;">
                            <div style="flex:1;margin-right:7px;">
                                <span class="text">短链域名</span>
                                <select name="qun_dlym" class="form-control" title="短链域名"></select>
                            </div>
                            <div style="flex:1;margin-right:7px;">
                                <span class="text">入口域名</span>
                                <select name="qun_rkym" class="form-control" title="入口域名"></select>
                            </div>
                            <div style="flex:1;">
                                <span class="text">落地域名</span>
                                <select name="qun_ldym" class="form-control" title="落地域名"></select>
                            </div>
                        </div>
                    </form>
                    <span style="color:#bbbbbb;font-size:14px;display:block;">* 生成的短链接需配置好伪静态才可正常跳转，否则跳404页面。</span>
                    <span style="color:#bbbbbb;font-size:14px;display:block;">* 在您未了解去重功能的原理之前请勿开启去重。</span>
                </div>
                
                <!-- 底部操作 -->
                <div class="modal-footer">
                    <div class="footer-btn">
                    <div class="faqnav" title="阅读使用文档">
                        <span class="faq"><a href="${pageContext.request.contextPath}/faq.php?faq=qun" target="_blank">?</a></span>
                    </div>
                    <div class="btnnav">
                        <button type="button" class="default-btn" onclick="createQun();">立即创建</button>
                    </div>
                </div>
                    
                </div><!-- modal-footer -->
                
                <!-- 操作反馈 -->
                <div class="result"></div>
                
            </div><!-- modal-content -->
        </div><!-- modal-dialog -->
    </div><!-- createQunModal -->
  	
  	<!-- 编辑群活码 -->
    <div class="modal fade" id="editQunModal">
        <div class="modal-dialog">
            <div class="modal-content" style="width:650px;">
                
                <!-- 头部 -->
                <div class="modal-header">
                    <h4 class="modal-title">编辑群活码</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div><!-- modal-header -->
                
                <!-- 表单 -->
                <div class="modal-body">
                    <form id="editQun" enctype="multipart/form-data">
                    <span class="text">标题</span>
                    <input type="text" name="qun_title" class="form-control" autocomplete="off" placeholder="标题或群名称">
                    
                    <span class="text">群备注</span>
                    <textarea name="qun_beizhu" class="form-control" autocomplete="off" placeholder="群简介、进群要求等（可空）"></textarea>
                    
                    <div style="width:100%;height:70px;margin:-5px auto 20px;display:flex;">
                        <div style="flex:1;margin-right:7px;">
                            <span class="text">短链域名</span>
                            <select name="qun_dlym" class="form-control" title="短链域名"></select>
                        </div>
                        <div style="flex:1;margin-right:7px;">
                            <span class="text">入口域名</span>
                            <select name="qun_rkym" class="form-control" title="入口域名"></select>
                        </div>
                        <div style="flex:1;">
                            <span class="text">落地域名</span>
                            <select name="qun_ldym" class="form-control" title="落地域名"></select>
                        </div>
                    </div>
                    
                    <div style="width:100%;height:70px;margin:-5px auto 20px;display:flex;">
                        <div style="flex:1;margin-right:7px;">
                            <span class="text">客服</span>
                            <select name="qun_kf_status" class="form-control" title="客服"></select>
                        </div>
                        <div style="flex:1;margin-right:7px;">
                            <span class="text">通知渠道</span>
                            <select name="qun_notify" class="form-control" title="到达阈值上限就发送通知"></select>
                        </div>
                        <div style="flex:1;">
                            <span class="text">安全提示</span>
                            <select name="qun_safety" class="form-control" title="安全提示"></select>
                        </div>
                    </div>

                    <!--上传控件-->
                    <span class="upload_file">
                    	<div class="upload_qrcode">
                    	    <input type="file" class="file_input" name="file" accept="image/*" id="selectKfQrcode" />
                    	    <img src="${pageContext.request.contextPath}/static/img/uploadIcon.png" class="upload_icon" />
                    	</div>
                    	<p class="upload_text">上传客服二维码</p>
                    	<div class="Re-upload selectFromSCK" onclick="getSuCai('1','editQunModal');">从素材库选择</div>
                    </span>
                    
                    <!--二维码图片预览-->
                    <div class="qrcode_preview"></div>
                    <input type="hidden" name="qun_id">
                    <input type="hidden" name="qun_kf">
                    </form>
                </div><!-- modal-body -->
                
                <!-- 底部操作 -->
                <div class="modal-footer">
                    <div class="footer-btn">
                    	<div class="faqnav" title="阅读使用文档">
                    	    <span class="faq"><a href="${pageContext.request.contextPath}/faq.php?faq=qun" target="_blank">?</a></span>
                    	</div>
                    	<div class="btnnav">
                    	    <button type="button" class="default-btn" onclick="editQun();">提交更新</button>
                    	</div>
                    </div>
                </div><!-- modal-footer -->
                
                <!-- 操作反馈 -->
                <div class="result"></div>
                
            </div><!-- modal-content -->
        </div><!-- modal-dialog -->
    </div><!-- editQunModal -->
  	
  	<!-- 删除群活码 -->
    <div class="modal fade" id="delQunModal">
        <div class="modal-dialog">
            <div class="modal-content">
                
                <!-- 头部 -->
                <div class="modal-header">
                    <h4 class="modal-title">删除群活码</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                
                <!-- 内容 -->
                <div class="modal-body">
                    将会删除该群活码及其所有二维码！
                </div>
                
                <!-- 底部操作 -->
                <div class="modal-footer"></div>
                
                <!-- 操作反馈 -->
                <div class="result"></div>
                
            </div><!-- modal-content -->
        </div><!-- modal-dialog -->
    </div><!-- delQunModal -->
    
    <!-- 删除群二维码 -->
    <div class="modal fade" id="delQunQrcodeModal">
        <div class="modal-dialog">
            <div class="modal-content">
                
                <!-- 头部 -->
                <div class="modal-header">
                    <h4 class="modal-title">删除群二维码</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                
                <!-- 内容 -->
                <div class="modal-body">
                    将会删除该群二维码且无法恢复！
                </div>
                
                <!-- 底部操作 -->
                <div class="modal-footer"></div><!-- modal-footer -->
                
                <!-- 操作反馈 -->
                <div class="result"></div>
                
            </div><!-- modal-content -->
        </div><!-- modal-dialog -->
    </div><!-- delQunQrcodeModal -->
  	
  	<!--二维码管理-->
    <div class="modal fade" id="qunQrcodeListModal">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                
                <!-- 头部 -->
                <div class="modal-header">
                    <h4 class="modal-title">
                        <span id="qunQrcodeListModalTitle"></span>
                    </h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                
                <!-- 模态框主体 -->
                <div class="modal-body">
                    <div class="btn-view">
                        
                        <div class="upload-Btn-Group">
                            <button type="button" class="default-btn local">
                                <span>+ 上传二维码</span>
                                <form id="uploadQunQrcodeForm" enctype="multipart/form-data">
                                    <input type="file" name="file" class="fileSelectBtn" accept="image/*" id="uploadQunQrcode" />
                                    <input text="text" name="qun_id" id="uploadQunQrcode_qunid" style="display:none;" />
                                </form>
                            </button>
                            <button type="button" class="default-btn sucaiku" onclick="getSuCai('1','qunQrcodeListModal')">
                                <span>+ 从素材库选择</span>
                            </button>
                        </div>
                        
                    </div>
                    
                    <!-- 群二维码列表 -->
                    <div class="qunQrcodeList">
                        <table class="table">
                            <thead></thead>
                            <tbody></tbody>
                        </table>
                        
                    </div>
                    
                    <!--加载不到列表的时候展示-->
                    <p class="loading" style="display: none;"></p>
                    
                </div>
                
                <!-- 模态框底部 -->
                <div class="modal-footer">
                    <div class="footer-btn">
                    	<div class="faqnav" title="阅读使用文档">
                    	    <span class="faq"><a href="${pageContext.request.contextPath}/faq.php?faq=qun" target="_blank">?</a></span>
                    	</div>
                    	<div class="btnnav">
                    	    <button type="button" class="default-btn" data-dismiss="modal">关闭</button>
                    	</div>
                    </div>
                </div>
                
                <!-- 操作反馈 -->
                <div class="result"></div>
                
            </div>
        </div>
    </div><!-- qunQrcodeListModal -->
    
    <!-- 编辑群二维码 -->
    <div class="modal fade" id="editQunQrcodeModal">
        <div class="modal-dialog">
            <div class="modal-content">
                
                <!-- 头部 -->
                <div class="modal-header">
                    <h4 class="modal-title">编辑群二维码</h4>
                    <button type="button" class="close" onclick="hideEditQunQrcodeModal();">&times;</button>
                </div>
                
                <!-- 表单 -->
                <div class="modal-body">
                <form id="editQunQrcode" enctype="multipart/form-data" title="读音：阈（yù）值，不是fá值。点右上角&times;可返回二维码列表">
                    <div style="width:100%;height:70px;margin:-5px auto 20px;display:flex;">
                        <div style="flex:1;margin-right:10px;">
                            <span class="text">阈（yù）值</span>
                            <input type="text" name="zm_yz" class="form-control" autocomplete="off" id="zm_yz_edit" placeholder="设置阈值">
                        </div>
                        <div style="flex:1;">
                            <span class="text">群主微信号</span>
                            <input type="text" name="zm_leader" class="form-control" autocomplete="off" id="zm_leader_edit" placeholder="群主微信号（可空）">
                        </div>
                    </div>
                    
                    <!--上传控件-->
                    <span class="upload_file">
                    	<div class="upload_qrcode">
                    	    <input type="file" class="file_input" name="file" accept="image/*" id="selectQunQrcode" />
                    	    <img src="${pageContext.request.contextPath}/static/img/uploadIcon.png" class="upload_icon" />
                    	</div>
                    	<p class="upload_text">上传群二维码</p>
                    </span>
                    
                    <!--二维码图片预览-->
                    <div class="qrcode_preview"></div>
                    <input type="hidden" name="zm_id" id="zm_id_edit">
                    <input type="hidden" name="zm_qrcode" id="zm_qrcode_edit">
                </form>
                </div><!-- modal-body -->
                
                <!-- 底部操作 -->
                <div class="modal-footer">
                    <div class="footer-btn">
                    	<div class="faqnav" title="阅读使用文档">
                    	    <span class="faq"><a href="${pageContext.request.contextPath}/faq.php?faq=qun" target="_blank">?</a></span>
                    	</div>
                    	<div class="btnnav">
                    	    <button type="button" class="default-btn" onclick="editQunQrcode();">提交更新</button>
                    	</div>
                    </div>
                </div>
                
                <!-- 操作反馈 -->
                <div class="result"></div>
                
            </div><!-- modal-content -->
        </div><!-- modal-dialog -->
    </div><!-- editQunQrcodeModal -->
    
    <!--素材库-->
    <div class="modal fade" id="suCaiKu">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                
                <!-- 头部 -->
                <div class="modal-header" title="点击右上角&times;可返回二维码列表">
                    <h4 class="modal-title">素材库</h4>
                    <span class="hideSuCaiPannel_closeIcon"></span>
                </div>
                
                <!-- 模态框主体 -->
                <div class="modal-body">
                    <div class="sucai-upload">
                        <button type="button" class="default-btn upload_sucai_button">
                            <span>+ 上传素材</span>
                            <form id="uploadSuCaiTosuCaiKuForm" enctype="multipart/form-data">
                                <input type="file" name="file" class="upload_sucai" accept="image/*" id="uploadSuCaiTosuCaiKu" />
                                <input text="text" name="upload_sucai_qunid" style="display:none;" />
                                <input text="text" name="upload_sucai_fromPannel" style="display:none;" />
                            </form>
                        </button>
                    </div>
                    
                    <!--素材容器-->
                    <div class="sucai-view"></div>
                    
                    <!--分页-->
                    <div class="fenye"></div>
                </div>
                
                <!-- 模态框底部 -->
                <div class="modal-footer">
                    <div class="footer-btn">
                    	<div class="faqnav" title="阅读使用文档">
                    	    <span class="faq"><a href="${pageContext.request.contextPath}/faq.php?faq=qun" target="_blank">?</a></span>
                    	</div>
                    	<div class="btnnav">
                    	    <button type="button" class="default-btn" data-dismiss="modal" onclick="hideSuCaiPannel()">取消</button>
                    	</div>
                    </div>
                </div>
                
                <!-- 操作反馈 -->
                <div class="result"></div>
                
            </div>
        </div>
    </div><!-- suCaiKu -->
    
    <!-- 分享群 -->
    <div class="modal fade" id="shareQunModal">
        <div class="modal-dialog">
            <div class="modal-content">
                
                <!-- 头部 -->
                <div class="modal-header">
                    <h4 class="modal-title">分享群活码</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                
                <!-- 表单 -->
                <div class="modal-body">
                    <div class="box">
                        <div class="longUrl"><span class="text">长链接：</span><span id="longUrl"></span></div>
                        <div class="shortUrl"><span class="text">短链接：</span><span id="shortUrl"></span></div>
                        <div class="Qrcode" id="shareQrcode"></div>
                    </div>
                </div>
                
                <!-- 底部操作 -->
                <div class="modal-footer"></div>
                
                <!-- 操作反馈 -->
                <div class="result"></div>
                
            </div><!-- modal-content -->
        </div><!-- modal-dialog -->
    </div><!-- shareQunModal -->
    
    <!-- 并流管理 -->
    <div class="modal fade" id="bingliuModal">
        <div class="modal-dialog" style="max-width:700px;">
            <div class="modal-content">
                
                <!-- 头部 -->
                <div class="modal-header">
                    <h4 class="modal-title">并流管理</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>
                
                <!-- 表单 -->
                <div class="modal-body">
                    <form id="addBingliu">
                        <div class="addBingliuForm">
                            <input type="text" name="before_qun_id" class="form-control" placeholder="原活码id" />
                            <input type="text" name="before_qun_key" class="form-control" placeholder="原活码Key" title="短链接/s/后面那串5位随机字符" />
                            <input type="text" name="later_qun_id" class="form-control" placeholder="并入活码id" />
                            <button type="button" class="default-btn" onclick="addBingliu();">添加并流</button>
                        </div>
                    </form>
                    
                    <!--并流列表-->
                    <div class="bingliuList">
                        <table class="table">
                            <thead></thead>
                            <tbody></tbody>
                        </table>
                        
                        <!--noData-->
                        <div class="noData-view"></div>
                        
                        <!--分页组件-->
                        <div class="fenye"></div>
                    </div>
                    
                    <p style="font-size:14px;color:#999;">*并流，即合并引流链接。将已删除的群活码并入另一个群活码，无需再维护也能保证群活码删除后仍然能引流，不浪费一些零星流量。</p>
                </div>
                
                <!-- 操作反馈 -->
                <div class="result"></div>
                
            </div><!-- modal-content -->
        </div><!-- modal-dialog -->
    </div><!-- bingliuModal -->
    
    <!-- 全局信息提示框 -->
    <div id="notification">
        <div id="notification-text"></div>
    </div>
    
</div><!-- app -->

<script>

    // 注册上传函数
    function handleQrcodeUpload() {

        // 上传客服二维码
        $("#selectKfQrcode").change(function(e){
            
            // 获取选择的文件
            var fileSelect = e.target.files;
            if(fileSelect.length>0){
                
                // file表单数据
                var imageData = new FormData(document.getElementById("editQun"));
                
                // 异步上传
                $.ajax({
                    url:"${pageContext.request.contextPath}/upload.php",
                    type:"POST",
                    data:imageData,
                    cache: false,
                    processData: false,
                    contentType: false,
                    success: function(res) {
                        
                        if(res.code == 200){
                            
                            // 上传成功
                            // 将上传成功的url谁知道隐藏的表单中
                            $('input[name="qun_kf"]').val(res.url);
                            
                            // 隐藏上传入口
                            $('#editQunModal .modal-body .upload_file').css('display','none');
                            
                            // 显示预览
                            $('#editQunModal .modal-body .qrcode_preview').css('display','block');
                            
                            // 显示上传成功文案
                            $('#editQunModal .modal-body .qrcode_preview').html(
                                '<img src="'+res.url+'" class="qrcode" />' +
                                '<p class="uploadSuccess_Reupload" onclick="newUpload()">重新上传</p>'
                            );
                        }else{
                            
                            // 上传失败
                            showErrorResult(res.msg)
                        }
                        
                    },
                    error: function() {
                        
                        // 上传失败
                        showErrorResultForphpfileName('upload.php');
                    }
                })
                
                // 清空file选择
                $('#selectKfQrcode').val('');
            }
        })
        
        // 上传群二维码
        $("#uploadQunQrcode").change(function(e){
            
            // 获取选择的文件
            var fileSelect = e.target.files;
            if(fileSelect.length>0){
                
                // file表单数据
                var imageData = new FormData(document.getElementById("uploadQunQrcodeForm"));
                
                // qun_id
                var qun_id = $("#uploadQunQrcode_qunid").val();
                
                // 异步上传
                $.ajax({
                    url:"${pageContext.request.contextPath}/qun/uploadQunQrcode.php",
                    type:"POST",
                    data:imageData,
                    cache: false,
                    processData: false,
                    contentType: false,
                    success: function(res) {
                        
                        if(res.code == 200){
                            
                            // 上传成功
                            // 刷新群二维码列表
                            freshenQunQrcodeList(qun_id)
                            
                        }else{
                            
                            // 上传失败
                            showErrorResult(res.msg)
                        }
                        
                    },
                    error: function() {
                        
                        // 上传失败
                        showErrorResultForphpfileName('uploadQunQrcode.php');
                    }
                })
            }
        })
        
        // 更换群二维码
        $("#selectQunQrcode").change(function(e){
            
            // 获取选择的文件
            var fileSelect = e.target.files;
            if(fileSelect.length>0){
                
                // file表单数据
                var imageData = new FormData(document.getElementById("editQunQrcode"));
                
                // 异步上传
                $.ajax({
                    url:"${pageContext.request.contextPath}/upload.php",
                    type:"POST",
                    data:imageData,
                    cache: false,
                    processData: false,
                    contentType: false,
                    success: function(res) {
                        
                        if(res.code == 200){
                            
                            // 上传成功
                            $('#zm_qrcode_edit').val(res.url);
                            $('#editQunQrcodeModal .modal-body .upload_file').css('display','none');
                            $('#editQunQrcodeModal .modal-body .qrcode_preview').css('display','block');
                            $('#editQunQrcodeModal .modal-body .qrcode_preview').html(
                                '<img src="'+res.url+'" class="qrcode" />' +
                                '<p class="uploadSuccess">上传成功</p>'
                            );
                        }else{
                            
                            // 上传失败
                            showErrorResult(res.msg)
                        }
                        
                    },
                    error: function() {
                        
                        // 上传失败
                        showErrorResultForphpfileName('upload.php');
                    }
                })
                
                // 清空file选择
                $("#selectQunQrcode").val('');
            }
        })
        
        // 上传至素材库
        $("#uploadSuCaiTosuCaiKu").change(function(e){
            
            // 获取选择的文件
            var fileSelect = e.target.files;
            if(fileSelect.length>0){
                
                // file表单数据
                var imageData = new FormData(document.getElementById("uploadSuCaiTosuCaiKuForm"));
                
                // 获取qunid
                var qunid = $('#suCaiKu input[name="upload_sucai_qunid"]').val();
                
                // 获取fromPannel
                var fromPannel = $('#suCaiKu input[name="upload_sucai_fromPannel"]').val();
                
                // 异步上传
                $.ajax({
                    url:"${pageContext.request.contextPath}/public/uploadToSuCaiKu.php",
                    type:"POST",
                    data:imageData,
                    cache: false,
                    processData: false,
                    contentType: false,
                    success: function(res) {
                        
                        if(res.code == 200){
                            
                            // 上传成功
                            // 重新获取素材列表
                            getSuCai(1,fromPannel);
                        }else{
                            
                            // 上传失败
                            showErrorResult(res.msg)
                        }
                        
                        // 清空file控件的选择
                        $('#uploadSuCaiTosuCaiKu').val('');
                    },
                    error: function() {
                        
                        // 上传失败
                        showErrorResultForphpfileName('uploadToSuCaiKu.php');
                    }
                })
            }
        })
    }
    
    // 注册上传函数
    handleQrcodeUpload();
    
</script>

</body>
</html>