package com.ylb.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * @author Ricky Li
 * @version 1.0
 * @date 7/26/25 3:25 PM
 */
@Controller
public class DashboardController {

    @GetMapping("/dashboard")
    public String dashboard(Model model) {
        // 模拟数据
        model.addAttribute("totalUsers", 128);
        model.addAttribute("totalPlugins", 8);
        model.addAttribute("activePlugins", 5);
        model.addAttribute("systemVersion", "1.0.0");

        return "dashboard";
    }
}
