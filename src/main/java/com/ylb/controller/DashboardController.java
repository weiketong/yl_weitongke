package com.ylb.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * @author Ricky Li
 * @version 1.0
 * @date 7/26/25 3:25 PM
 */
@Controller
public class DashboardController {

    @GetMapping("/menu/index")
    public String menuIndex() {
        return "dashboard/index";
    }
}
