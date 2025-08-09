CREATE DATABASE IF NOT EXISTS private_deploy DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE private_deploy;

-- 用户表
CREATE TABLE IF NOT EXISTS user (
    id VARCHAR(50) PRIMARY KEY COMMENT '用户ID',
    username VARCHAR(50) NOT NULL COMMENT '用户名',
    password VARCHAR(100) NOT NULL COMMENT '密码（加密存储）',
    role VARCHAR(20) NOT NULL COMMENT '角色：ADMIN/USER',
    status TINYINT DEFAULT 1 COMMENT '状态：0-禁用，1-正常',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    UNIQUE KEY uk_username (username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户表';

-- 插件表
CREATE TABLE IF NOT EXISTS plugin (
    id VARCHAR(50) PRIMARY KEY COMMENT '插件唯一标识',
    name VARCHAR(100) NOT NULL COMMENT '插件名称',
    description TEXT COMMENT '插件描述',
    author VARCHAR(100) DEFAULT '' COMMENT '作者',
    homepage VARCHAR(255) DEFAULT '' COMMENT '插件主页',
    status TINYINT DEFAULT 1 COMMENT '状态：0-禁用，1-启用',
    required_role VARCHAR(20) DEFAULT 'USER' COMMENT '所需权限：ADMIN/USER',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='插件信息表';

-- 插件版本表
CREATE TABLE IF NOT EXISTS plugin_version (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT '版本ID',
    plugin_id VARCHAR(50) NOT NULL COMMENT '插件ID',
    version VARCHAR(50) NOT NULL COMMENT '版本号',
    change_log TEXT COMMENT '更新日志',
    download_url VARCHAR(255) DEFAULT '' COMMENT '下载地址',
    local_path VARCHAR(255) DEFAULT '' COMMENT '本地存储路径',
    file_size BIGINT DEFAULT 0 COMMENT '文件大小（字节）',
    is_latest TINYINT DEFAULT 0 COMMENT '是否最新版本：0-否，1-是',
    upload_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '上传时间',
    FOREIGN KEY (plugin_id) REFERENCES plugin(id) ON DELETE CASCADE,
    UNIQUE KEY uk_plugin_version (plugin_id, version)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='插件版本表';

-- 插件安装记录表
CREATE TABLE IF NOT EXISTS plugin_install (
    id INT AUTO_INCREMENT PRIMARY KEY COMMENT '记录ID',
    plugin_id VARCHAR(50) NOT NULL COMMENT '插件ID',
    version VARCHAR(50) NOT NULL COMMENT '安装版本',
    user_id VARCHAR(50) NOT NULL COMMENT '安装用户ID',
    status TINYINT DEFAULT 1 COMMENT '状态：0-卸载，1-安装',
    install_time DATETIME DEFAULT CURRENT_TIMESTAMP COMMENT '安装时间',
    uninstall_time DATETIME NULL COMMENT '卸载时间',
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
    FOREIGN KEY (plugin_id) REFERENCES plugin(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE,
    UNIQUE KEY uk_user_plugin (user_id, plugin_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='插件安装记录表';

-- 初始化管理员用户（密码：123456，加密处理）
INSERT INTO user (id, username, password, role)
VALUES ('admin', 'admin', '$2a$10$VJfYJ8D4Q5K8jGp8JQZ7AeGQxXQZ7AeGQxXQZ7AeGQxXQZ7AeGQ', 'ADMIN')
ON DUPLICATE KEY UPDATE password = VALUES(password);

-- 创建插件存储目录
-- 在实际部署时需要手动创建或通过脚本创建
-- mkdir -p ./plugins && chmod 775 ./plugins

CREATE TABLE `huoma_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `user_id` int(10) DEFAULT NULL COMMENT '用户ID',
  `user_name` varchar(32) DEFAULT NULL COMMENT '账号',
  `user_pass` varchar(64) DEFAULT NULL COMMENT '密码',
  `user_email` text COMMENT '邮箱',
  `user_mb_ask` text COMMENT '密保问题',
  `user_mb_answer` varchar(32) DEFAULT NULL COMMENT '密保答案',
  `user_creat_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  `user_expire_time` timestamp NULL DEFAULT '2035-12-31 23:59:59' COMMENT '到期时间',
  `user_expire` varchar(32) DEFAULT NULL COMMENT '到期时间',
  `user_admin` int(2) DEFAULT '2' COMMENT '管理权限（1是 2否）',
  `user_manager` varchar(32) DEFAULT NULL COMMENT '账号管理者',
  `user_beizhu` varchar(64) DEFAULT NULL COMMENT '备注信息',
  `user_group` varchar(32) DEFAULT NULL COMMENT '用户组',
  `user_status` int(2) NOT NULL DEFAULT '1' COMMENT '账号状态（1可用 2停用）',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

CREATE TABLE `huoma_qun` (
                           `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
                           `qun_id` int(10) DEFAULT NULL COMMENT '群ID',
                           `qun_title` varchar(64) DEFAULT NULL COMMENT '群标题',
                           `qun_status` int(2) NOT NULL DEFAULT '1' COMMENT '状态（1开启 2关闭）默认1',
                           `qun_creat_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                           `qun_pv` int(10) NOT NULL DEFAULT '0' COMMENT '访问量',
                           `qun_today_pv` varchar(64) DEFAULT NULL COMMENT '今天访问量',
                           `qun_qc` int(2) NOT NULL DEFAULT '2' COMMENT '去重（1开启 2关闭）默认2',
                           `qun_notify` varchar(32) DEFAULT NULL COMMENT '通知渠道',
                           `qun_rkym` text COMMENT '入口域名',
                           `qun_ldym` text COMMENT '落地域名',
                           `qun_dlym` text COMMENT '短链域名',
                           `qun_kf` text COMMENT '客服二维码',
                           `qun_kf_status` int(2) NOT NULL DEFAULT '2' COMMENT '客服开启状态（1开启 2关闭）默认2',
                           `qun_safety` int(2) NOT NULL DEFAULT '1' COMMENT '顶部安全提示（1显 2隐）',
                           `qun_beizhu` text COMMENT '群备注',
                           `qun_key` varchar(10) DEFAULT NULL COMMENT '短链接Key',
                           `qun_creat_user` varchar(32) DEFAULT NULL COMMENT '创建者账号',
                           PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='群活码列表';

CREATE TABLE `huoma_domain` (
                                `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
                                `domain_id` int(10) DEFAULT NULL COMMENT '域名ID',
                                `domain_type` int(2) DEFAULT NULL COMMENT '域名类型（1入口 2落地 3短链 4备用 5对象存储）',
                                `domain` text COMMENT '域名',
                                `domain_beizhu` varchar(32) DEFAULT NULL COMMENT '备注',
                                `domain_usergroup` varchar(255) DEFAULT NULL COMMENT '授权用户组',
                                PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='域名/落地页';