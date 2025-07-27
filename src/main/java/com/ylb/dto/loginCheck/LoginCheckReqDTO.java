package com.ylb.dto.loginCheck;

import lombok.Data;

import java.io.Serializable;

/**
 * @author Ricky Li
 * @version 1.0
 * @date 7/27/25 4:16 PM
 */
@Data
public class LoginCheckReqDTO implements Serializable {

    private String userName;

    private String password;
}
