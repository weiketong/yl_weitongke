package com.ylb.service;

import com.ylb.dto.loginCheck.LoginCheckReqDTO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * @author Ricky Li
 * @version 1.0
 * @date 7/27/25 4:00 PM
 */
public interface HomeService {

    /**
     * 安装检查
     *
     * @return {@link String}
     */
    String installCheck();

    /**
     * 登陆
     *
     * @param req req
     * @return {@link String}
     */
    String loginCheck(LoginCheckReqDTO req,
                      HttpServletRequest request,
                      HttpServletResponse response,
                      HttpSession session);
}
