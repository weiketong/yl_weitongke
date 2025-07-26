package com.ylb.entity;

import lombok.Data;

import java.util.Date;

/**
 * @author Ricky Li
 * @version 1.0
 * @date 7/26/25 3:30 PM
 */
@Data
public class PluginInstall {

    private Integer id;                // 记录ID
    private String pluginId;           // 插件ID
    private String version;            // 安装版本
    private String userId;             // 安装用户ID
    private Integer status;            // 状态：0-卸载，1-安装
    private Date installTime;          // 安装时间
    private Date uninstallTime;        // 卸载时间
    private Date updateTime;           // 更新时间
}
