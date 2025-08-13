package com.ylb.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.ylb.entity.HuomaDomain;
import com.ylb.mapper.HuomaDomainMapper;
import com.ylb.service.DomainService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.regex.Pattern;

@Slf4j
@Service
public class DomainServiceImpl implements DomainService {

    // 域名格式验证正则
    private static final String URL_REGEX = "https?://(\\*|[\\w-]+(\\.[\\w-]+)+)(/[\\w-./?%&=]*)?";
    private static final Pattern URL_PATTERN = Pattern.compile(URL_REGEX);

    @Resource
    private HuomaDomainMapper huomaDomainMapper;

    @Override
    public Map<String, Object> addDomain(Map<String, Object> result, HuomaDomain huomaDomain) {

        // 处理域名结尾斜杠
        String processedDomain = processDomainSlash(huomaDomain.getDomain());

        // 参数验证
        if (processedDomain == null || processedDomain.isEmpty()) {
            result.put("code", 203);
            result.put("msg", "域名未填写");
            return result;
        }

        if (!isUrl(processedDomain)) {
            result.put("code", 203);
            result.put("msg", "你输入的不是正确的域名格式");
            return result;
        }

        if (huomaDomain.getDomainType() == null) {
            result.put("code", 203);
            result.put("msg", "域名类型未选择");
            return result;
        }

        // 泛解析域名验证（仅允许落地域名类型）
        if (processedDomain.contains("*.")) {
            if (huomaDomain.getDomainType() != 2) {
                result.put("code", 203);
                result.put("msg", "仅支持落地域名使用泛解析~");
                return result;
            }
        }

        // 检查域名是否已存在
        if (isDomainExists(processedDomain, huomaDomain.getDomainType())) {
            String typeText = getDomainTypeText(huomaDomain.getDomainType());
            result.put("code", 202);
            result.put("msg", "该域名已被添加为" + typeText + "，可尝试添加为其它类型！");
            return result;
        }

        // 7. 生成域名ID并添加到数据库
        try {
            String domainId = generateDomainId();
            huomaDomain.setDomainId(Integer.valueOf(domainId));
            huomaDomainMapper.insert(huomaDomain);
            result.put("code", 200);
            result.put("msg", "添加成功");
        } catch (Exception e) {
            result.put("code", 202);
            result.put("msg", "添加失败");
        }

        return result;
    }

    @Override
    public void domainList(String loginUser, Integer p, Map<String, Object> result) {

        // 已登录，处理分页参数
        Integer pageNum = p;
        // 每页数量
        Integer pageSize = 10;
        Integer pageNumber = pageNum - 1;

        Page page = PageHelper.startPage(pageNum, pageSize);
        List<HuomaDomain> huomaDomainList = huomaDomainMapper.queryAllByDomainUserGroup(loginUser);
        // 计算分页信息
        long qunNum = page.getTotal();
        int allPage = page.getPages();
        int prePage = pageNum > 1 ? pageNum - 1 : 1;
        int nextPage = pageNum < allPage ? pageNum + 1 : allPage;

        if (!CollectionUtils.isEmpty(huomaDomainList)) {
            // 有结果
            result.put("domainList", page.getResult());
            result.put("qunNum", qunNum);
            result.put("prepage", prePage);
            result.put("nextpage", nextPage);
            result.put("allpage", allPage);
            result.put("page", page);
            result.put("code", 200);
            result.put("msg", "获取成功");
        } else {
            // 无结果
            result.put("code", 204);
            result.put("msg", "暂无群活码");
        }
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateBeizhu(String beizhu, Integer domainId) {
        HuomaDomain huomaDomain = huomaDomainMapper.queryByDomainId(domainId);
        huomaDomain.setDomainBeizhu(beizhu);
        huomaDomainMapper.update(huomaDomain);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void delDomain(Integer domainId) {
        huomaDomainMapper.deleteByDomainId(domainId);
    }

    /**
     * 验证域名格式
     */
    public boolean isUrl(String url) {
        if (url == null) return false;
        return URL_PATTERN.matcher(url).matches();
    }

    /**
     * 处理域名结尾的斜杠（移除末尾的/）
     */
    public String processDomainSlash(String domain) {
        if (domain != null && domain.endsWith("/")) {
            return domain.substring(0, domain.length() - 1);
        }
        return domain;
    }

    /**
     * 生成域名ID（$domain_id = '10' . mt_rand(1000,9999)）
     */
    public String generateDomainId() {
        Random random = new Random();
        int num = random.nextInt(9000) + 1000; // 生成1000-9999的随机数
        return "10" + num;
    }

    /**
     * 获取域名类型对应的文本描述
     */
    public String getDomainTypeText(Integer domainType) {
        switch (domainType) {
            case 1:
                return "入口域名";
            case 2:
                return "落地域名";
            case 3:
                return "短链域名";
            case 4:
                return "备用域名";
            case 5:
                return "对象存储域名";
            case 6:
                return "轮询域名";
            default:
                return "未知类型";
        }
    }

    /**
     * 检查域名是否已存在（相同域名+相同类型）
     */
    public boolean isDomainExists(String domain, Integer domainType) {
        return !huomaDomainMapper.selectByTypeAndDomain(domainType, domain).isEmpty();
    }
}
