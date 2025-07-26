package com.ylb.service;

import com.ylb.entity.Plugin;
import com.ylb.entity.PluginVersion;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.Map;

/**
 * @author Ricky Li
 * @version 1.0
 * @date 7/26/25 3:35 PM
 */
public interface PluginService {

    // 插件上传（远程更新）
    Map<String, Object> uploadPlugin(MultipartFile file, String operatorId);

    // 获取所有插件
    List<Plugin> getAllPlugins();

    // 获取插件的所有版本
    List<PluginVersion> getPluginVersions(String pluginId);

    // 获取插件最新版本
    PluginVersion getLatestPluginVersion(String pluginId);

    // 安装插件
    Map<String, Object> installPlugin(String pluginId, String version, String userId);

    // 升级插件
    Map<String, Object> upgradePlugin(String pluginId, String version, String userId);

    // 卸载插件
    Map<String, Object> uninstallPlugin(String pluginId, String userId);

    // 获取用户已安装插件
    List<Map<String, Object>> getUserInstalledPlugins(String userId);
}
