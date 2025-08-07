package com.ylb.service;

import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * @author Ricky Li
 * @version 1.0
 * @date 8/7/25 3:06 PM
 */
public interface LoginService {

    /**
     * 获取登陆信息
     *
     * @param session
     * @return {@link Map}
     * @author Ricky Li
     * @date 8/7/25 3:08 PM
     */
    Map<String, Object> getLoginStatus(HttpSession session);
}
