package com.ylb.service.impl;

import com.ylb.entity.HuomaUser;
import com.ylb.mapper.HuomaUserMapper;
import com.ylb.service.LoginService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

/**
 * @author Ricky Li
 * @version 1.0
 * @date 8/7/25 3:06 PM
 */
@Slf4j
@Service
public class LoginServiceImpl implements LoginService {

    @Resource
    private HuomaUserMapper huomaUserMapper;

    @Override
    public Map<String, Object> getLoginStatus(HttpSession session) {
        Map<String, Object> result = new HashMap<>();

        // 检查会话中是否有登录信息
        Object loginUser = session.getAttribute("yinliubao");
        if (loginUser != null) {
            String userName = loginUser.toString();

            // 查询用户信息
            HuomaUser huomaUser = huomaUserMapper.findByUserName(userName);

            if (huomaUser != null) {
                result.put("code", 200);
                result.put("msg", "已登录");
                result.put("user_name", huomaUser.getUserName());
                result.put("user_admin", huomaUser.getUserAdmin());
                result.put("version", "当前版本：1.0.0");
            } else {
                // 用户不存在
                result.put("code", 204);
                result.put("msg", "无结果");
                result.put("version", "当前版本：1.0.0");
            }
        } else {
            // 未登录状态
            result.put("code", 201);
            result.put("msg", "未登录");
            result.put("version", "当前版本：1.0.0");
        }

        return result;
    }
}
