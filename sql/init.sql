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
