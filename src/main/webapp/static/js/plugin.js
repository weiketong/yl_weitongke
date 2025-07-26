$(function() {
    // 安装插件
    $('.btn-install').click(function() {
        var pluginId = $(this).data('plugin-id');
        var version = $(this).data('version');
        var $button = $(this);
        var $card = $button.closest('.plugin-card');

        if (confirm("确定要安装插件吗？\\n插件ID: " + pluginId + "\\n版本: " + version)) {
            $button.text('安装中...').prop('disabled', true);

            $.post('/plugin/install', {
                pluginId: pluginId,
                version: version
            }, function(response) {
                if (response.success) {
                    alert('插件安装成功！');
                    location.reload();
                } else {
                    alert('安装失败：' + response.message);
                    $button.text('安装').prop('disabled', false);
                }
            }).fail(function() {
                alert('安装请求失败，请重试');
                $button.text('安装').prop('disabled', false);
            });
        }
    });

    // 升级插件
    $('.btn-upgrade').click(function() {
        var pluginId = $(this).data('plugin-id');
        var version = $(this).data('version');
        var $button = $(this);

        if (confirm("确定要升级插件到版本 " + version +" 吗？")) {
            $button.text('升级中...').prop('disabled', true);

            $.post('/plugin/upgrade', {
                pluginId: pluginId,
                version: version
            }, function(response) {
                if (response.success) {
                    alert('插件升级成功！');
                    location.reload();
                } else {
                    alert('升级失败：' + response.message);
                    $button.text('升级').prop('disabled', false);
                }
            }).fail(function() {
                alert('升级请求失败，请重试');
                $button.text('升级').prop('disabled', false);
            });
        }
    });

    // 卸载插件
    $('.btn-uninstall').click(function() {
        var pluginId = $(this).data('plugin-id');
        var $button = $(this);
        var pluginName = $button.closest('.plugin-card').find('h3').text();

        if (confirm("确定要卸载插件 \" " + pluginName + "\" 吗？\\n此操作将移除插件的所有功能。")) {
            $button.text('卸载中...').prop('disabled', true);

            $.post('/plugin/uninstall', {
                pluginId: pluginId
            }, function(response) {
                if (response.success) {
                    alert('插件卸载成功！');
                    location.reload();
                } else {
                    alert('卸载失败：' + response.message);
                    $button.text('卸载').prop('disabled', false);
                }
            }).fail(function() {
                alert('卸载请求失败，请重试');
                $button.text('卸载').prop('disabled', false);
            });
        }
    });
});
