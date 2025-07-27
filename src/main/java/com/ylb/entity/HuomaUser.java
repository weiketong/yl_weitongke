package com.ylb.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import java.io.Serializable;
import java.util.Date;

/**
 * (HuomaUser)实体类
 *
 * @author makejava
 * @since 2025-07-27 15:54:46
 */
@Table(name = "`huoma_user`")
@NoArgsConstructor
@AllArgsConstructor
@Data
public class HuomaUser implements Serializable {
    private static final long serialVersionUID = -27520660615090796L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    /**
     * 用户ID
     */
    @Column(name = "`user_id`")
    private Integer userId;
    /**
     * 账号
     */
    @Column(name = "`user_name`")
    private String userName;
    /**
     * 密码
     */
    @Column(name = "`user_pass`")
    private String userPass;
    /**
     * 邮箱
     */
    @Column(name = "`user_email`")
    private String userEmail;
    /**
     * 密保问题
     */
    @Column(name = "`user_mb_ask`")
    private String userMbAsk;
    /**
     * 密保答案
     */
    @Column(name = "`user_mb_answer`")
    private String userMbAnswer;
    /**
     * 注册时间
     */
    @Column(name = "`user_creat_time`")
    private Date userCreatTime;
    /**
     * 到期时间
     */
    @Column(name = "`user_expire_time`")
    private Date userExpireTime;
    /**
     * 到期时间
     */
    @Column(name = "`user_expire`")
    private String userExpire;
    /**
     * 管理权限（1是 2否）
     */
    @Column(name = "`user_admin`")
    private Integer userAdmin;
    /**
     * 账号管理者
     */
    @Column(name = "`user_manager`")
    private String userManager;
    /**
     * 备注信息
     */
    @Column(name = "`user_beizhu`")
    private String userBeizhu;
    /**
     * 用户组
     */
    @Column(name = "`user_group`")
    private String userGroup;
    /**
     * 账号状态（1可用 2停用）
     */
    @Column(name = "`user_status`")
    private Integer userStatus;

}

