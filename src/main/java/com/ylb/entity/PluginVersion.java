package com.ylb.entity;

import lombok.Data;

import java.util.Date;

/**
 * @author Ricky Li
 * @version 1.0
 * @date 7/26/25 3:30 PM
 */
@Data
public class PluginVersion {
    private Integer id;                // 版本ID
    private String pluginId;           // 插件ID
    private String version;            // 版本号
    private String changeLog;          // 更新日志
    private String downloadUrl;        // 下载地址
    private String localPath;          // 本地存储路径
    private Long fileSize;             // 文件大小
    private Integer isLatest;          // 是否最新版本：0-否，1-是
    private Date uploadTime;           // 上传时间
}
