package com.ylb.mapper;

import com.ylb.entity.PluginInstall;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author Ricky Li
 * @version 1.0
 * @date 7/26/25 3:33 PM
 */
@Mapper
public interface PluginInstallMapper {

    // 获取用户已安装的插件
    List<PluginInstall> findByUserId(String userId);

    // 获取用户安装的特定插件
    PluginInstall findByUserIdAndPluginId(@Param("userId") String userId, @Param("pluginId") String pluginId);

    // 新增安装记录
    int insert(PluginInstall install);

    // 更新安装记录
    int update(PluginInstall install);

    // 卸载插件
    int uninstall(@Param("userId") String userId, @Param("pluginId") String pluginId);
}
