package com.ylb.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.ylb.entity.HuomaQun;
import com.ylb.mapper.HuomaQunMapper;
import com.ylb.service.HuomaService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import tk.mybatis.mapper.entity.Example;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author Ricky Li
 * @version 1.0
 * @date 8/7/25 3:35 PM
 */
@Slf4j
@Service
public class HuomaServiceImpl implements HuomaService {

    @Resource
    private HuomaQunMapper huomaQunMapper;

    @Override
    public Map<String, Object> getQunList(Integer p, HttpSession session) {

        Map<String, Object> result = new HashMap<>(0);

        // 检查登录状态
        String loginUser = (String) session.getAttribute("yinliubao");
        if (loginUser == null) {
            // 未登录
            result.put("code", 201);
            result.put("msg", "未登录");
            return result;
        }

        // 已登录，处理分页参数
        Integer pageNum = p;
        // 每页数量
        Integer pageSize = 10;
        Integer pageNumber = pageNum - 1;

        // 启动分页
        Page page = PageHelper.startPage(pageNumber, pageSize);

        // 查询数据
        List<HuomaQun> huomaQunList = huomaQunMapper.queryHuomaOrderBy();

        // 计算分页信息
        long qunNum = page.getTotal();
        int allPage = page.getPages();
        int prePage = pageNum > 1 ? pageNum - 1 : 1;
        int nextPage = pageNum < allPage ? pageNum + 1 : allPage;

        if (!CollectionUtils.isEmpty(huomaQunList)) {
            // 有结果
            result.put("qunList", huomaQunList);
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

        return result;
    }
}