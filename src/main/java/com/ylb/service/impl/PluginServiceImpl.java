package com.ylb.service.impl;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ylb.entity.Plugin;
import com.ylb.entity.PluginInstall;
import com.ylb.entity.PluginVersion;
import com.ylb.mapper.PluginInstallMapper;
import com.ylb.mapper.PluginMapper;
import com.ylb.mapper.PluginVersionMapper;
import com.ylb.service.PluginService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * @author Ricky Li
 * @version 1.0
 * @date 7/26/25 3:35 PM
 */
@Service
@Slf4j
public class PluginServiceImpl implements PluginService {

    @Resource
    private PluginMapper pluginMapper;

    @Resource
    private PluginVersionMapper versionMapper;

    @Resource
    private PluginInstallMapper installMapper;

    @Value("${plugin.storage-path}")
    private String pluginStoragePath;

    @Value("${plugin.max-version-count}")
    private Integer maxVersionCount;

    private final ObjectMapper objectMapper = new ObjectMapper();
    private final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    @Override
    @Transactional
    public Map<String, Object> uploadPlugin(MultipartFile file, String operatorId) {
        Map<String, Object> result = new HashMap<>();
        try {
            // 验证文件
            if (file.isEmpty()) {
                result.put("success", false);
                result.put("message", "请选择要上传的插件文件");
                return result;
            }

            String fileName = file.getOriginalFilename();
            if (!fileName.endsWith(".zip")) {
                result.put("success", false);
                result.put("message", "仅支持ZIP格式的插件文件");
                return result;
            }

            // 创建临时目录
            String tempDir = pluginStoragePath + "temp/" + UUID.randomUUID().toString();
            File tempDirectory = new File(tempDir);
            if (!tempDirectory.exists()) {
                tempDirectory.mkdirs();
            }

            // 保存上传的文件
            String tempFilePath = tempDir + "/" + fileName;
            File tempFile = new File(tempFilePath);
            file.transferTo(tempFile);

            // 解压文件并解析plugin.json
            // 实际项目中需要添加解压逻辑
            // 这里简化处理，假设已经解压并读取了plugin.json

            // 模拟解析插件元数据
            Plugin plugin = new Plugin();
            plugin.setId("plugin-" + System.currentTimeMillis());
            plugin.setName("示例插件");
            plugin.setDescription("这是一个示例插件");
            plugin.setAuthor("系统管理员");
            plugin.setStatus(1);
            plugin.setRequiredRole("USER");
            plugin.setCreateTime(new Date());
            plugin.setUpdateTime(new Date());

            // 检查插件是否已存在
            Plugin existingPlugin = pluginMapper.findById(plugin.getId());
            if (existingPlugin == null) {
                pluginMapper.insert(plugin);
            } else {
                plugin.setId(existingPlugin.getId());
                pluginMapper.update(plugin);
            }

            // 处理版本信息
            PluginVersion version = new PluginVersion();
            version.setPluginId(plugin.getId());
            version.setVersion("1.0." + System.currentTimeMillis() % 1000);
            version.setChangeLog("初始版本");
            version.setFileSize(file.getSize());
            version.setUploadTime(new Date());

            // 保存文件到正式目录
            String pluginDir = pluginStoragePath + plugin.getId() + "/versions/" + version.getVersion();
            File pluginDirectory = new File(pluginDir);
            if (!pluginDirectory.exists()) {
                pluginDirectory.mkdirs();
            }

            // 移动文件到正式目录
            Path sourcePath = Paths.get(tempFilePath);
            Path destPath = Paths.get(pluginDir + "/" + fileName);
            Files.move(sourcePath, destPath);

            version.setLocalPath(pluginDir + "/" + fileName);

            // 更新版本状态
            versionMapper.updateLatestStatus(plugin.getId(), 0);
            version.setIsLatest(1);
            versionMapper.insert(version);

            // 清理临时文件
            deleteDirectory(tempDirectory);

            result.put("success", true);
            result.put("message", "插件上传成功");
            result.put("pluginId", plugin.getId());
            result.put("version", version.getVersion());

        } catch (Exception e) {
            log.error("插件上传失败", e);
            result.put("success", false);
            result.put("message", "插件上传失败：" + e.getMessage());
        }

        return result;
    }

    @Override
    public List<Plugin> getAllPlugins() {
        return pluginMapper.findAll();
    }

    @Override
    public List<PluginVersion> getPluginVersions(String pluginId) {
        return versionMapper.findByPluginId(pluginId);
    }

    @Override
    public PluginVersion getLatestPluginVersion(String pluginId) {
        return versionMapper.findLatestByPluginId(pluginId);
    }

    @Override
    @Transactional
    public Map<String, Object> installPlugin(String pluginId, String version, String userId) {
        Map<String, Object> result = new HashMap<>();
        try {
            // 验证插件是否存在
            Plugin plugin = pluginMapper.findById(pluginId);
            if (plugin == null) {
                result.put("success", false);
                result.put("message", "插件不存在");
                return result;
            }

            // 验证版本是否存在
            PluginVersion pluginVersion = versionMapper.findByPluginIdAndVersion(pluginId, version);
            if (pluginVersion == null) {
                result.put("success", false);
                result.put("message", "插件版本不存在");
                return result;
            }

            // 检查是否已安装
            PluginInstall existingInstall = installMapper.findByUserIdAndPluginId(userId, pluginId);
            if (existingInstall != null && existingInstall.getStatus() == 1) {
                result.put("success", false);
                result.put("message", "插件已安装");
                return result;
            }

            // 执行安装逻辑
            PluginInstall install = new PluginInstall();
            install.setPluginId(pluginId);
            install.setVersion(version);
            install.setUserId(userId);
            install.setStatus(1);
            install.setInstallTime(new Date());

            if (existingInstall != null) {
                install.setId(existingInstall.getId());
                installMapper.update(install);
            } else {
                installMapper.insert(install);
            }

            // 实际项目中需要添加解压插件、加载资源等逻辑

            result.put("success", true);
            result.put("message", "插件安装成功");

        } catch (Exception e) {
            log.error("插件安装失败", e);
            result.put("success", false);
            result.put("message", "插件安装失败：" + e.getMessage());
        }

        return result;
    }

    @Override
    @Transactional
    public Map<String, Object> upgradePlugin(String pluginId, String version, String userId) {
        Map<String, Object> result = new HashMap<>();
        try {
            // 验证插件是否已安装
            PluginInstall existingInstall = installMapper.findByUserIdAndPluginId(userId, pluginId);
            if (existingInstall == null || existingInstall.getStatus() == 0) {
                result.put("success", false);
                result.put("message", "插件未安装，无法升级");
                return result;
            }

            // 执行升级逻辑（类似安装逻辑）
            existingInstall.setVersion(version);
            existingInstall.setUpdateTime(new Date());
            installMapper.update(existingInstall);

            // 实际项目中需要添加替换插件资源、重新加载等逻辑

            result.put("success", true);
            result.put("message", "插件升级成功");

        } catch (Exception e) {
            log.error("插件升级失败", e);
            result.put("success", false);
            result.put("message", "插件升级失败：" + e.getMessage());
        }

        return result;
    }

    @Override
    @Transactional
    public Map<String, Object> uninstallPlugin(String pluginId, String userId) {
        Map<String, Object> result = new HashMap<>();
        try {
            // 验证插件是否已安装
            PluginInstall existingInstall = installMapper.findByUserIdAndPluginId(userId, pluginId);
            if (existingInstall == null || existingInstall.getStatus() == 0) {
                result.put("success", false);
                result.put("message", "插件未安装，无法卸载");
                return result;
            }

            // 执行卸载逻辑
            existingInstall.setStatus(0);
            existingInstall.setUninstallTime(new Date());
            installMapper.update(existingInstall);

            // 实际项目中需要添加清理插件资源等逻辑

            result.put("success", true);
            result.put("message", "插件卸载成功");

        } catch (Exception e) {
            log.error("插件卸载失败", e);
            result.put("success", false);
            result.put("message", "插件卸载失败：" + e.getMessage());
        }

        return result;
    }

    @Override
    public List<Map<String, Object>> getUserInstalledPlugins(String userId) {
        List<PluginInstall> installs = installMapper.findByUserId(userId);
        List<Map<String, Object>> result = new ArrayList<>();

        for (PluginInstall install : installs) {
            if (install.getStatus() == 1) {
                Plugin plugin = pluginMapper.findById(install.getPluginId());
                PluginVersion version = versionMapper.findByPluginIdAndVersion(
                        install.getPluginId(), install.getVersion());

                if (plugin != null && version != null) {
                    Map<String, Object> pluginInfo = new HashMap<>();
                    pluginInfo.put("plugin", plugin);
                    pluginInfo.put("installedVersion", version);
                    pluginInfo.put("latestVersion", versionMapper.findLatestByPluginId(install.getPluginId()));
                    pluginInfo.put("installTime", install.getInstallTime());

                    result.add(pluginInfo);
                }
            }
        }

        return result;
    }

    // 递归删除目录
    private boolean deleteDirectory(File directory) {
        if (directory.exists()) {
            File[] files = directory.listFiles();
            if (files != null) {
                for (File file : files) {
                    if (file.isDirectory()) {
                        deleteDirectory(file);
                    } else {
                        file.delete();
                    }
                }
            }
        }
        return directory.delete();
    }
}
