package com.ylb.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * 菜单跳转
 *
 * @author Ricky Li
 * @version 1.0
 * @date 7/26/25 3:25 PM
 */
@Controller
public class MenuController {

    @GetMapping("/menu/dataIndex")
    public String dataIndex() {
        return "menu/dataIndex";
    }

    @GetMapping("/menu/huomaIndex")
    public String huomaIndex() {
        return "menu/huomaIndex";
    }
}
