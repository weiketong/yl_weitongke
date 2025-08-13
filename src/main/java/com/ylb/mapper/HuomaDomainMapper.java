package com.ylb.mapper;

import com.ylb.entity.HuomaDomain;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 域名/落地页(HuomaDomain)表数据库访问层
 *
 * @author makejava
 * @since 2025-08-09 16:55:16
 */
public interface HuomaDomainMapper {

    /**
     * 根据类型和域名查询数据库
     *
     * @param domainType domainType
     * @param domain     domain
     * @return {@link List}
     */
    List<HuomaDomain> selectByTypeAndDomain(@Param("domainType") Integer domainType, @Param("domain") String domain);

    /**
     * 通过ID查询单条数据
     *
     * @param id 主键
     * @return 实例对象
     */
    HuomaDomain queryById(Integer id);

    /**
     * 通过ID查询单条数据
     *
     * @param domainId 随机ID
     * @return 实例对象
     */
    HuomaDomain queryByDomainId(@Param("domainId") Integer domainId);

    /**
     * 获取当前登陆人的所有维护域名
     *
     * @param userGroup userGroup
     * @return {@link HuomaDomain}
     */
    List<HuomaDomain> queryAllByDomainUserGroup(@Param("userGroup") String userGroup);

    /**
     * 统计总行数
     *
     * @param huomaDomain 查询条件
     * @return 总行数
     */
    long count(HuomaDomain huomaDomain);

    /**
     * 新增数据
     *
     * @param huomaDomain 实例对象
     * @return 影响行数
     */
    int insert(HuomaDomain huomaDomain);

    /**
     * 批量新增数据（MyBatis原生foreach方法）
     *
     * @param entities List<HuomaDomain> 实例对象列表
     * @return 影响行数
     */
    int insertBatch(@Param("entities") List<HuomaDomain> entities);

    /**
     * 批量新增或按主键更新数据（MyBatis原生foreach方法）
     *
     * @param entities List<HuomaDomain> 实例对象列表
     * @return 影响行数
     * @throws org.springframework.jdbc.BadSqlGrammarException 入参是空List的时候会抛SQL语句错误的异常，请自行校验入参
     */
    int insertOrUpdateBatch(@Param("entities") List<HuomaDomain> entities);

    /**
     * 修改数据
     *
     * @param huomaDomain 实例对象
     * @return 影响行数
     */
    int update(HuomaDomain huomaDomain);

    /**
     * 通过主键删除数据
     *
     * @param id 主键
     * @return 影响行数
     */
    int deleteById(Integer id);

    /**
     * 删除
     *
     * @param domainId domainId
     */
    void deleteByDomainId(@Param("domainId") Integer domainId);
}

