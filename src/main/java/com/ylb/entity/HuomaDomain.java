package com.ylb.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.io.Serializable;

/**
 * 域名/落地页(HuomaDomain)实体类
 *
 * @author makejava
 * @since 2025-08-09 16:55:16
 */
@Data
@Table(name = "`huoma_domain`")
@NoArgsConstructor
@AllArgsConstructor
public class HuomaDomain implements Serializable {
    private static final long serialVersionUID = 288296626017062040L;
    /**
     * 自增ID
     */
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    /**
     * 域名ID
     */
    @Column(name = "`domain_id`")
    private Integer domainId;
    /**
     * 域名类型（1入口 2落地 3短链 4备用 5对象存储）
     */
    @Column(name = "`domain_type`")
    private Integer domainType;
    /**
     * 域名
     */
    @Column(name = "`domain`")
    private String domain;
    /**
     * 备注
     */
    @Column(name = "`domain_beizhu`")
    private String domainBeizhu;
    /**
     * 授权用户组
     */
    @Column(name = "`domain_usergroup`")
    private String domainUsergroup;
}