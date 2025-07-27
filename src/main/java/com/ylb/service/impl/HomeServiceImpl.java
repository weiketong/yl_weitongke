package com.ylb.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.ylb.dto.Result;
import com.ylb.dto.loginCheck.LoginCheckReqDTO;
import com.ylb.entity.HuomaUser;
import com.ylb.mapper.HuomaUserMapper;
import com.ylb.service.HomeService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import javax.annotation.Resource;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

/**
 * @author Ricky Li
 * @version 1.0
 * @date 7/27/25 4:00 PM
 */
@Slf4j
@Service
public class HomeServiceImpl implements HomeService {

    @Resource
    private HuomaUserMapper huomaUserMapper;

    private final String minVersion = "1.8";
    private final String maxVersion = "17";

    /**
     * 不安全字符正则（对应PHP的防注入校验）
     */
    private static final Pattern UNSAFE_CHAR_PATTERN = Pattern.compile("[',.:;*?~`!@#$%^&+=()<>{}\\]\\[\\/\\\\\"|]");
    /**
     * 中文正则
     */
    private static final Pattern CHINESE_CHAR_PATTERN = Pattern.compile("[\\x7f-\\xff]");
    /**
     * SQL关键字正则
     */
    private static final Pattern SQL_KEYWORD_PATTERN = Pattern.compile("(and|or|select|update|drop|insert|create|delete|where|join|script|set)", Pattern.CASE_INSENSITIVE);


    @Value("${upload.base-path:./console}")
    private String baseUploadPath;

    @Override
    public String installCheck() {
        // 初始化结果对象
        Result result = new Result();
        result.setCode(200);
        result.setMsg("检测完成");

        // 测试文件路径
        String consoleTestFile = baseUploadPath + File.separator + "test.txt";

        // 检查文件写入权限
        boolean consoleWriteSuccess;

        try {
            // 尝试创建console目录的测试文件
            File consoleFile = new File(consoleTestFile);
            // 确保父目录存在
            if (!consoleFile.getParentFile().exists()) {
                // 检查目录创建是否成功
                boolean consoleDirCreated = consoleFile.getParentFile().mkdirs();
                if (!consoleDirCreated) {
                    log.warn("无法创建console目录: {}", consoleFile.getParentFile().getAbsolutePath());
                }
            }
            consoleWriteSuccess = consoleFile.createNewFile();
            // 写入内容
            if (consoleWriteSuccess) {
                try (FileWriter writer = new FileWriter(consoleFile)) {
                    writer.write("上传测试文件，可删除.");
                }
            }

            // 判断上传权限结果
            if (consoleWriteSuccess) {
                result.setUploadResult("获得上传权限");
                result.setUploadResultText("<span style=\"color:#07C160;font-weight:bold;\">✓ 符合</span>");
            } else {
                result.setUploadResult("没有上传权限");
                result.setUploadResultText("<span style=\"color:#f00;font-weight:bold;\">不符合</span>");
            }
        } catch (Exception e) {
            result.setUploadResult("没有上传权限");
            result.setUploadResultText("<span style=\"color:#f00;font-weight:bold;\">不符合</span>");
        }

        // 获取JRE版本
        String javaVersion = System.getProperty("java.version");
        result.setJdkVersion(javaVersion);

        // JRE版本检查（可根据实际需求调整版本范围）
        if (isVersionInRange(javaVersion, minVersion, maxVersion)) {
            result.setJdkVersionResultText("<span style=\"color:#07C160;font-weight:bold;\">✓ 符合</span>");
        } else {
            result.setJdkVersionResultText("<span style=\"color:#f00;font-weight:bold;\">不符合</span>");
        }

        // 清理测试文件
        try {
            new File(consoleTestFile).delete();
        } catch (Exception e) {
            log.warn("清理测试文件失败", e);
        }

        // 返回JSON结果
        return JSONObject.toJSONString(result);
    }

    /**
     * 版本范围检查工具方法
     *
     * @param minVersion 最小版本
     * @param maxVersion 对大版本
     * @return {@link Boolean}
     * @author Ricky Li
     * @date 7/26/25 9:57 PM
     */
    private boolean isVersionInRange(String version, String minVersion, String maxVersion) {
        try {
            // 处理不同格式的版本号（如1.8.0_301、11.0.12、17.0.1）
            String[] versionParts = version.split("[._-]");
            double current = Double.parseDouble(versionParts[0] + "." + versionParts[1]);
            double min = Double.parseDouble(minVersion);
            double max = Double.parseDouble(maxVersion);
            return current >= min && current <= max;
        } catch (Exception e) {
            return false;
        }
    }

    @Override
    public String loginCheck(LoginCheckReqDTO req,
                             HttpServletRequest request,
                             HttpServletResponse response,
                             HttpSession session) {

        Map<String, Object> result = new HashMap<>(0);

        try {
            // 1. 检查是否已安装
            // 这里改为检查数据库是否有用户表数据，或检查安装标记文件
            HuomaUser huomaUser = huomaUserMapper.selectByOne();
            if (huomaUser == null) {
                result.put("code", 404);
                result.put("msg", "请安装后再登录...");
                return JSONObject.toJSONString(result);
            }

            // 2. 参数校验（防SQL注入）
            String username = req.getUserName().trim();
            String password = req.getPassword().trim();

            // 检查空值
            if (username.isEmpty() || password.isEmpty()) {
                result.put("code", 203);
                result.put("msg", username.isEmpty() ? "账号未填写" : "密码未填写");
                return JSONObject.toJSONString(result);
            }

            // 检查不安全字符
            if (UNSAFE_CHAR_PATTERN.matcher(username).find() || UNSAFE_CHAR_PATTERN.matcher(password).find()) {
                result.put("code", 203);
                result.put("msg", "你输入的内容包含了一些不安全字符");
                return JSONObject.toJSONString(result);
            }

            // 检查SQL关键字
            if (SQL_KEYWORD_PATTERN.matcher(username).find() || SQL_KEYWORD_PATTERN.matcher(password).find()) {
                result.put("code", 203);
                result.put("msg", "你输入的内容包含了一些不安全字符");
                return JSONObject.toJSONString(result);
            }

            // 检查中文
            if (CHINESE_CHAR_PATTERN.matcher(username).find()) {
                result.put("code", 203);
                result.put("msg", "账号不能存在中文");
                return JSONObject.toJSONString(result);
            }
            if (CHINESE_CHAR_PATTERN.matcher(password).find()) {
                result.put("code", 203);
                result.put("msg", "密码不能存在中文");
                return JSONObject.toJSONString(result);
            }

            // 3. 数据库查询验证
            HuomaUser user = huomaUserMapper.findByUserName(username);
            if (user == null) {
                result.put("code", 202);
                result.put("msg", "账号错误");
                return JSONObject.toJSONString(result);
            }

            // 4. 密码验证（不加密）
            if (!user.getUserPass().equals(password)) {
                result.put("code", 202);
                result.put("msg", "密码错误");
                return JSONObject.toJSONString(result);
            }

            // 5. 检查账号状态
            if (user.getUserStatus() != 1) {
                result.put("code", 202);
                result.put("msg", "账号已被管理员停用");
                return JSONObject.toJSONString(result);
            }

            // 6. 登录成功处理
            // 设置Session（有效期7天）
            // 秒
            session.setMaxInactiveInterval(7 * 24 * 3600);
            session.setAttribute("yinliubao", username);

            // 设置Cookie（有效期7天）
            String cookieValue = username + "_" + md5Encode(String.valueOf(System.currentTimeMillis()));
            Cookie cookie = new Cookie(username, cookieValue);
            // 秒
            cookie.setMaxAge(7 * 24 * 3600);
            cookie.setPath("/");
            response.addCookie(cookie);

            // 8. 返回成功结果
            result.put("code", 200);
            result.put("msg", "登录成功");
            return JSONObject.toJSONString(result);

        } catch (Exception e) {
            log.error("登录异常", e);
            result.put("code", 202);
            result.put("msg", "服务器发生错误");
            return JSONObject.toJSONString(result);
        }
    }

    /**
     * 不对密码进行加密（弃用方法）
     *
     * @param str str
     * @return {@link String}
     */
    private String md5Encode(String str) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] bytes = md.digest(str.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : bytes) {
                String hex = Integer.toHexString(b & 0xFF);
                if (hex.length() == 1) {
                    sb.append("0");
                }
                sb.append(hex);
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("MD5加密失败", e);
        }
    }
}
