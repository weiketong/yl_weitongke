package com.ylb.controller.login;

import com.ylb.service.LoginService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * @author Ricky Li
 * @version 1.0
 * @date 8/7/25 2:58 PM
 */
@Controller
public class LoginController {

    @Resource
    private LoginService loginService;

    @PostMapping("/login/getLoginStatus")
    @ResponseBody
    public Map<String, Object> getLoginStatus(HttpSession session) {
        return loginService.getLoginStatus(session);
    }
}
