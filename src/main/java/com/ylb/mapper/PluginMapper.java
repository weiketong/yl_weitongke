package com.ylb.mapper;

import com.ylb.entity.Plugin;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author Ricky Li
 * @version 1.0
 * @date 7/26/25 3:33 PM
 */
@Mapper
public interface PluginMapper {

    // 获取所有插件
    List<Plugin> findAll();

    // 根据ID获取插件
    Plugin findById(String id);

    // 新增插件
    int insert(Plugin plugin);

    // 更新插件
    int update(Plugin plugin);

    // 更新插件状态
    int updateStatus(@Param("id") String id, @Param("status") Integer status);

    // 删除插件
    int delete(String id);
}
