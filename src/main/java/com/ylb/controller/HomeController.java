package com.ylb.controller;

import com.ylb.dto.loginCheck.LoginCheckReqDTO;
import com.ylb.service.HomeService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * @author Ricky Li
 * @version 1.0
 * @date 7/26/25 3:26 PM
 */
@Slf4j
@Controller
public class HomeController {

    @Resource
    private HomeService homeService;

    @GetMapping("/")
    public String index() {
        return "index";
    }

    @GetMapping("/installIndex")
    public String installIndex() {
        return "install/index";
    }

    @GetMapping("/loginIndex")
    public String loginIndex() {
        return "login/index";
    }

    @GetMapping("/installCheck")
    @ResponseBody
    public String installCheck() {
        return homeService.installCheck();
    }

    @PostMapping("/loginCheck")
    @ResponseBody
    public String loginCheck(@RequestBody LoginCheckReqDTO req,
                             HttpServletRequest request,
                             HttpServletResponse response,
                             HttpSession session) {
        return homeService.loginCheck(req, request, response, session);
    }
}