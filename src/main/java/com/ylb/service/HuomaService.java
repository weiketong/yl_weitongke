package com.ylb.service;

import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * @author Ricky Li
 * @version 1.0
 * @date 8/7/25 3:35 PM
 */
public interface HuomaService {

    /**
     * 查询
     *
     * @param p       p
     * @param session session
     * @return {@link Map}
     * @author Ricky Li
     * @date 8/7/25 3:42 PM
     */
    Map<String, Object> getQunList(Integer p, HttpSession session);
}
