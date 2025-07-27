package com.ylb.dto;

import lombok.Data;

/**
 * @author Ricky Li
 * @version 1.0
 * @date 7/26/25 9:52 PM
 */
@Data
public class Result {

    private int code;
    private String msg;
    private String jdkVersion;
    private String jdkVersionResultText;
    private String uploadResult;
    private String uploadResultText;
}
