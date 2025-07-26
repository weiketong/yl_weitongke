package com.ylb.controller;

import com.ylb.service.PluginService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

/**
 * @author Ricky Li
 * @version 1.0
 * @date 7/26/25 3:27 PM
 */
@Controller
@RequestMapping("/plugin")
public class PluginController {

    @Resource
    private PluginService pluginService;

    // 插件中心首页
    @GetMapping("/center")
    public String center(Model model, HttpSession session) {
        String userId = (String) session.getAttribute("userId");

        // 获取所有插件
        model.addAttribute("allPlugins", pluginService.getAllPlugins());

        // 获取已安装插件
        model.addAttribute("installedPlugins", pluginService.getUserInstalledPlugins(userId));

        return "plugin/center";
    }

    // 插件上传页面
    @GetMapping("/upload")
    public String upload() {
        return "plugin/upload";
    }

    // 处理插件上传
    @PostMapping("/doUpload")
    @ResponseBody
    public Map<String, Object> doUpload(@RequestParam("pluginFile") MultipartFile file, HttpSession session) {
        String userId = (String) session.getAttribute("userId");
        return pluginService.uploadPlugin(file, userId);
    }

    // 安装插件
    @PostMapping("/install")
    @ResponseBody
    public Map<String, Object> install(
            @RequestParam("pluginId") String pluginId,
            @RequestParam("version") String version,
            HttpSession session) {
        String userId = (String) session.getAttribute("userId");
        return pluginService.installPlugin(pluginId, version, userId);
    }

    // 升级插件
    @PostMapping("/upgrade")
    @ResponseBody
    public Map<String, Object> upgrade(
            @RequestParam("pluginId") String pluginId,
            @RequestParam("version") String version,
            HttpSession session) {
        String userId = (String) session.getAttribute("userId");
        return pluginService.upgradePlugin(pluginId, version, userId);
    }

    // 卸载插件
    @PostMapping("/uninstall")
    @ResponseBody
    public Map<String, Object> uninstall(
            @RequestParam("pluginId") String pluginId,
            HttpSession session) {
        String userId = (String) session.getAttribute("userId");
        return pluginService.uninstallPlugin(pluginId, userId);
    }

    // 获取插件版本
    @GetMapping("/versions")
    @ResponseBody
    public Map<String, Object> getVersions(@RequestParam("pluginId") String pluginId) {

        return new HashMap<>(0);
//        return Map.of(
//                "success", true,
//                "versions", pluginService.getPluginVersions(pluginId),
//                "latest", pluginService.getLatestPluginVersion(pluginId)
//        );
    }
}
