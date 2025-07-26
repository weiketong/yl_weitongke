package com.ylb;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.support.SpringBootServletInitializer;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.EnableScheduling;

/**
 * @author Ricky Li
 * @version 1.0
 * @date 7/26/25 2:45 PM
 */
@SpringBootApplication
@MapperScan(value = "com.ylb.mapper")
@EnableAsync
@EnableScheduling
public class YlbApplication extends SpringBootServletInitializer {
    public static void main(String[] args) {
        SpringApplication.run(YlbApplication.class, args);
    }
}
