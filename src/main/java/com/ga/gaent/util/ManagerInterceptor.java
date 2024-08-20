package com.ga.gaent.util;

import java.util.HashMap;
import java.util.Map;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Component
public class ManagerInterceptor implements HandlerInterceptor {

    /*
     * @author : 정건희
     * @since : 2024. 08. 20.
     * Description : 직급 인증 분기 인터셉터
     */
    @Override
    public boolean preHandle(
            HttpServletRequest request,
            HttpServletResponse response,
            Object handler) throws Exception {
        
        HttpServletRequest req = (HttpServletRequest)request;
        HttpServletResponse res = (HttpServletResponse)response;
        HttpSession session = req.getSession();
        
        Map<String, Object> loginInfo = new HashMap<>();
        
        loginInfo = (Map<String, Object>)session.getAttribute("loginInfo");
        
        if(loginInfo != null) {
            String rankCode = (String)loginInfo.get("rankCode");
            String teamCode = (String)loginInfo.get("teamCode");
            if((rankCode.equals("4") || rankCode.equals("5")) && !teamCode.substring(0, 1).equals("1")) {
                res.sendRedirect(req.getContextPath()+"/hr/notManager");
                return false;
            }
        }
        
        return true;
    }
}
