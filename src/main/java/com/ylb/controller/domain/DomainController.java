package com.ylb.controller.domain;

import com.ylb.entity.HuomaDomain;
import com.ylb.service.DomainService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
public class DomainController {

    @Resource
    private DomainService domainService;

    @PostMapping("/addDomain")
    @ResponseBody
    public Map<String, Object> addDomain(HttpSession session, @RequestBody HuomaDomain huomaDomain) {
        Map<String, Object> result = new HashMap<>();
        // 获取登录状态
        String loginUser = (String) session.getAttribute("yinliubao");

        if (loginUser != null && !loginUser.isEmpty()) {
            huomaDomain.setDomainUsergroup(loginUser);
            domainService.addDomain(result, huomaDomain);
        } else {
            // 未登录
            result.put("code", 201);
            result.put("msg", "未登录");
        }
        return result;
    }

    @PostMapping("/domainList")
    @ResponseBody
    public Map<String, Object> domainList(@RequestParam(defaultValue = "1") Integer p, HttpSession session) {
        Map<String, Object> result = new HashMap<>();

        // 获取登录状态
        String loginUser = (String) session.getAttribute("yinliubao");

        if (loginUser != null && !loginUser.isEmpty()) {

            domainService.domainList(loginUser, p, result);
            // 构建返回结果
            result.put("code", 200);
            result.put("msg", "获取成功");

        } else {
            // 未登录
            result.put("code", 201);
            result.put("msg", "未登录");
        }

        return result;
    }

    @GetMapping("/updateBeizhu")
    @ResponseBody
    public Map<String, Object> updateBeizhu(@RequestParam(required = false, value = "beizhu") String beizhu,
                                            @RequestParam("domainId") Integer domainId,
                                            HttpSession session) {
        Map<String, Object> result = new HashMap<>();

        // 获取登录状态
        String loginUser = (String) session.getAttribute("yinliubao");

        if (loginUser != null && !loginUser.isEmpty()) {

            domainService.updateBeizhu(beizhu, domainId);
            // 构建返回结果
            result.put("code", 200);
            result.put("msg", "修改成功");

        } else {
            // 未登录
            result.put("code", 201);
            result.put("msg", "未登录");
        }

        return result;
    }

    @GetMapping("/delDomain")
    @ResponseBody
    public Map<String, Object> delDomain(@RequestParam("domainId") Integer domainId, HttpSession session) {
        Map<String, Object> result = new HashMap<>();
        // 获取登录状态
        String loginUser = (String) session.getAttribute("yinliubao");

        if (loginUser != null && !loginUser.isEmpty()) {

            domainService.delDomain(domainId);
            // 构建返回结果
            result.put("code", 200);
            result.put("msg", "修改成功");

        } else {
            // 未登录
            result.put("code", 201);
            result.put("msg", "未登录");
        }

        return result;
    }
}
