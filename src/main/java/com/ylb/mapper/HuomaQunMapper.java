package com.ylb.mapper;

import com.ylb.entity.HuomaQun;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

/**
 * 群活码列表(HuomaQun)表数据库访问层
 *
 * @author makejava
 * @since 2025-08-07 15:28:17
 */
public interface HuomaQunMapper extends Mapper<HuomaQun> {

    /**
     * 查询活码列表排序
     *
     * @return {@link List}
     * @author Ricky Li
     * @date 8/7/25 5:03 PM
     */
    List<HuomaQun> queryHuomaOrderBy();
}