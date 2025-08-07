package com.ylb.controller.huoma;

import com.ylb.service.HuomaService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * @author Ricky Li
 * @version 1.0
 * @date 8/7/25 3:34 PM
 */
@Controller
public class HuomaController {

    @Resource
    private HuomaService huomaService;

    @PostMapping("/menu/huomaIndex/getQunList")
    @ResponseBody
    public Map<String, Object> getQunList(@RequestParam(defaultValue = "1") Integer p, HttpSession session) {
        return huomaService.getQunList(p, session);
    }
}
