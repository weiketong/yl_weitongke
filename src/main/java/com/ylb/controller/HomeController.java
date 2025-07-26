package com.ylb.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpSession;

/**
 * @author Ricky Li
 * @version 1.0
 * @date 7/26/25 3:26 PM
 */
@Controller
public class HomeController {

    @GetMapping("/")
    public String index(Model model, HttpSession session) {
        // 模拟登录用户
        session.setAttribute("userId", "user1");
        session.setAttribute("username", "管理员");
        session.setAttribute("role", "ADMIN");

        return "index";
    }
}