package com.ylb.entity;

import lombok.Data;

import java.util.Date;

/**
 * @author Ricky Li
 * @version 1.0
 * @date 7/26/25 3:29 PM
 */
@Data
public class Plugin {

    private String id;                 // 插件唯一标识
    private String name;               // 插件名称
    private String description;        // 插件描述
    private String author;             // 作者
    private String homepage;           // 插件主页
    private Integer status;            // 状态：0-禁用，1-启用
    private String requiredRole;       // 所需权限：ADMIN/USER
    private Date createTime;           // 创建时间
    private Date updateTime;           // 更新时间
}
