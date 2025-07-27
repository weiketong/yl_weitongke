package com.ylb.mapper;

import com.ylb.entity.HuomaUser;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

/**
 * (HuomaUser)表数据库访问层
 *
 * @author makejava
 * @since 2025-07-27 15:54:46
 */
public interface HuomaUserMapper extends Mapper<HuomaUser> {

    /**
     * 根据用户名查询用户
     *
     * @param userName userName
     * @return {@link HuomaUser}
     */
    HuomaUser findByUserName(@Param("userName") String userName);

    /**
     * 查一下用户表是否有数据，用于确认是否安装
     *
     * @return {@link HuomaUser}
     */
    HuomaUser selectByOne();
}

