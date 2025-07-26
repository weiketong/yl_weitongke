package com.ylb.mapper;

import com.ylb.entity.PluginVersion;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author Ricky Li
 * @version 1.0
 * @date 7/26/25 3:34 PM
 */
@Mapper
public interface PluginVersionMapper {

    // 根据插件ID获取所有版本
    List<PluginVersion> findByPluginId(String pluginId);

    // 获取插件最新版本
    PluginVersion findLatestByPluginId(String pluginId);

    // 根据插件ID和版本号获取版本
    PluginVersion findByPluginIdAndVersion(@Param("pluginId") String pluginId, @Param("version") String version);

    // 新增版本
    int insert(PluginVersion version);

    // 更新版本状态
    int updateLatestStatus(@Param("pluginId") String pluginId, @Param("isLatest") Integer isLatest);

    // 删除版本
    int delete(Integer id);
}
