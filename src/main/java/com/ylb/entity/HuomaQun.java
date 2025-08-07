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
 * 群活码列表(HuomaQun)实体类
 *
 * @author makejava
 * @since 2025-08-07 15:28:18
 */
@Table(name = "`huoma_qun`")
@NoArgsConstructor
@AllArgsConstructor
@Data
public class HuomaQun implements Serializable {
    private static final long serialVersionUID = 605561284950596856L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    /**
     * 群ID
     */
    @Column(name = "`qun_id`")
    private Integer qunId;
    /**
     * 群标题
     */
    @Column(name = "`qun_title`")
    private String qunTitle;
    /**
     * 状态（1开启 2关闭）默认1
     */
    @Column(name = "`qun_status`")
    private Integer qunStatus;
    /**
     * 创建时间
     */
    @Column(name = "`qun_creat_time`")
    private Date qunCreatTime;
    /**
     * 访问量
     */
    @Column(name = "`qun_pv`")
    private Integer qunPv;
    /**
     * 今天访问量
     */
    @Column(name = "`qun_today_pv`")
    private String qunTodayPv;
    /**
     * 去重（1开启 2关闭）默认2
     */
    @Column(name = "`qun_qc`")
    private Integer qunQc;
    /**
     * 通知渠道
     */
    @Column(name = "`qun_notify`")
    private String qunNotify;
    /**
     * 入口域名
     */
    @Column(name = "`qun_rkym`")
    private String qunRkym;
    /**
     * 落地域名
     */
    @Column(name = "`qun_ldym`")
    private String qunLdym;
    /**
     * 短链域名
     */
    @Column(name = "`qun_dlym`")
    private String qunDlym;
    /**
     * 客服二维码
     */
    @Column(name = "`qun_kf`")
    private String qunKf;
    /**
     * 客服开启状态（1开启 2关闭）默认2
     */
    @Column(name = "`qun_kf_status`")
    private Integer qunKfStatus;
    /**
     * 顶部安全提示（1显 2隐）
     */
    @Column(name = "`qun_safety`")
    private Integer qunSafety;
    /**
     * 群备注
     */
    @Column(name = "`qun_beizhu`")
    private String qunBeizhu;
    /**
     * 短链接Key
     */
    @Column(name = "`qun_key`")
    private String qunKey;
    /**
     * 创建者账号
     */
    @Column(name = "`qun_creat_user`")
    private String qunCreatUser;

}

