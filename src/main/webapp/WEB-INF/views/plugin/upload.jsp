<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <title>上传插件 - 私有化部署系统</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/main.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/plugin.css">
</head>
<body>
<div class="page-container">
    <%@ include file="/WEB-INF/views/common/header.jsp" %>

    <main class="content">
        <div class="upload-container">
            <h1>上传插件</h1>
            <p class="upload-desc">上传ZIP格式的插件包，系统将自动处理并添加到插件中心</p>

            <form id="uploadForm" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="pluginFile">选择插件文件（ZIP格式）</label>
                    <div class="file-upload-area">
                        <input type="file" id="pluginFile" name="pluginFile" accept=".zip" required>
                        <div class="upload-hint">
                            <i class="icon-upload"></i>
                            <p>点击或拖拽文件到此处上传</p>
                            <p class="file-size-hint">支持最大文件大小：20MB</p>
                        </div>
                    </div>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn-primary">上传插件</button>
                    <a href="/plugin/center" class="btn-secondary">取消</a>
                </div>
            </form>

            <div id="uploadStatus" class="upload-status hidden">
                <div class="progress-bar">
                    <div id="progress" class="progress" style="width: 0%"></div>
                </div>
                <div id="statusText" class="status-text">准备上传...</div>
            </div>
        </div>
    </main>

    <%@ include file="/WEB-INF/views/common/footer.jsp" %>
</div>

<script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
<script>
    $(function() {
        $('#uploadForm').submit(function(e) {
            e.preventDefault();

            const formData = new FormData(this);
            const $status = $('#uploadStatus');
            const $progress = $('#progress');
            const $statusText = $('#statusText');

            // 显示上传状态
            $status.removeClass('hidden');
            $statusText.text('正在上传...');

            $.ajax({
                url: '/plugin/doUpload',
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                xhr: function() {
                    const xhr = new XMLHttpRequest();
                    xhr.upload.addEventListener('progress', function(e) {
                        if (e.lengthComputable) {
                            const percent = (e.loaded / e.total) * 100;
                            $progress.css('width', percent + '%');
                        }
                    });
                    return xhr;
                },
                success: function(response) {
                    if (response.success) {
                        $statusText.text('上传成功！正在处理插件...');
                        setTimeout(function() {
                            window.location.href = '/plugin/center';
                        }, 1500);
                    } else {
                        $statusText.text('上传失败：' + response.message);
                        $status.addClass('error');
                    }
                },
                error: function() {
                    $statusText.text('上传失败，请重试');
                    $status.addClass('error');
                }
            });
        });

        // 拖拽上传
        const fileInput = document.getElementById('pluginFile');
        const uploadArea = document.querySelector('.file-upload-area');

        uploadArea.addEventListener('dragover', function(e) {
            e.preventDefault();
            uploadArea.classList.add('dragover');
        });

        uploadArea.addEventListener('dragleave', function() {
            uploadArea.classList.remove('dragover');
        });

        uploadArea.addEventListener('drop', function(e) {
            e.preventDefault();
            uploadArea.classList.remove('dragover');

            if (e.dataTransfer.files.length) {
                fileInput.files = e.dataTransfer.files;
                // 显示选中的文件名
                if (fileInput.files[0]) {
                    $('.upload-hint p:first').text('已选择：' + fileInput.files[0].name);
                }
            }
        });

        // 选择文件后显示文件名
        fileInput.addEventListener('change', function() {
            if (this.files[0]) {
                $('.upload-hint p:first').text('已选择：' + this.files[0].name);
            }
        });
    });
</script>
</body>
</html>
