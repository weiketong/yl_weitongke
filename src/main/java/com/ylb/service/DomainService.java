package com.ylb.service;

import com.ylb.entity.HuomaDomain;

import java.util.Map;

public interface DomainService {

    /**
     * 新增域名
     *
     * @param result      result
     * @param huomaDomain huomaDomain
     */
    Map<String, Object> addDomain(Map<String, Object> result, HuomaDomain huomaDomain);

    /**
     * 列表查询
     *
     * @param loginUser loginUser
     * @param p         p
     */
    void domainList(String loginUser, Integer p, Map<String, Object> result);

    /**
     * 修改备注
     *
     * @param beizhu   beizhu
     * @param domainId domainId
     */
    void updateBeizhu(String beizhu, Integer domainId);

    /**
     * 删除域名
     *
     * @param domainId domainId
     */
    void delDomain(Integer domainId);
}
