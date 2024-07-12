package com.ga.gaent.controller;

import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.ga.gaent.dto.LoginRequestDTO;
import com.ga.gaent.service.LoginService;
import com.ga.gaent.util.TeamColor;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class LoginController {

    @Autowired LoginService loginService;

    @GetMapping("/login")
    public String login() {
        return "user/login";
    }
    
    /*
     * @author : 정건희
     * @since : 2024. 07. 12.
     * Description : 로그인 유효성 검사
     */
    @PostMapping("/login")
    public String loginCheck(LoginRequestDTO loginRequestDTO, HttpSession session, RedirectAttributes redirectAttributes) {
        
        log.debug(TeamColor.BLUE_BG + "id: " + loginRequestDTO.getEmail() + " password: " + loginRequestDTO.getPassword() + TeamColor.RESET);

        Map<String, Object> loginInfo = loginService.selectLoginCheck(loginRequestDTO);
        log.debug(TeamColor.BLUE_BG + "loginInfo: " + loginInfo + TeamColor.RESET);
        
        if(loginInfo != null) {
            session.setAttribute("loginInfo", loginInfo);
            return "redirect:/home";
        }
        
        redirectAttributes.addFlashAttribute("messageType", "false");
        redirectAttributes.addFlashAttribute("message", "아이디와 비밀번호를 확인해주세요.");
        
        return "login";
    }

    /*
     * @author : 정건희
     * @since : 2024. 07. 12.
     * Description : 세션 초기화 후 로그아웃
     */
    @GetMapping("/logout")
    public String logout(HttpSession session, RedirectAttributes redirectAttributes) {
        
        session.invalidate();
        
        redirectAttributes.addFlashAttribute("message", "로그아웃 완료.");
        
        return "redirect:/login";
    }
    
    @GetMapping("/findId")
    public String findId() {
        return "user/findId";
    }
    
    /*
     * @author : 정건희
     * @since : 2024. 07. 12.
     * Description : 아이디 찾기
     */
    @PostMapping("/findId")
    public String findId(LoginRequestDTO loginRequestDTO, RedirectAttributes redirectAttributes) {
        
        log.debug(TeamColor.BLUE_BG + "name: " + loginRequestDTO.getName() + " phone: " + loginRequestDTO.getPhone() + TeamColor.RESET);
        
        Map<String, String> loginInfo = loginService.selectEmpId(loginRequestDTO);
        log.debug(TeamColor.BLUE_BG + "loginInfo: " + loginInfo + TeamColor.RESET);
        
        if(loginInfo != null) {
            redirectAttributes.addFlashAttribute("messageType", "true");
            redirectAttributes.addFlashAttribute("message", "아이디 찾기에 성공하셨습니다.");
            redirectAttributes.addFlashAttribute("loginInfo", loginInfo);
            return "redirect:/login";
        }
        
        redirectAttributes.addFlashAttribute("messageType", "false");
        redirectAttributes.addFlashAttribute("message", "아이디 찾기에 실패하셨습니다.");
        
        return "user/findId";
    }

    @GetMapping("/findPw")
    public String findPw() {
        return "user/findPw";
    }
    
    /*
     * @author : 정건희
     * @since : 2024. 07. 12.
     * Description : 비밀번호 찾기
     */
    @PostMapping("/findPw")
    public String findPw(LoginRequestDTO loginRequestDTO, RedirectAttributes redirectAttributes) {
        
        log.debug(TeamColor.BLUE_BG + "id: " + loginRequestDTO.getEmail() + " name: " + loginRequestDTO.getName() + " phone: " + loginRequestDTO.getPhone() + TeamColor.RESET);
        
        Map<String, String> loginInfo = loginService.selectEmpPw(loginRequestDTO);
        log.debug(TeamColor.BLUE_BG + "loginInfo: " + loginInfo + TeamColor.RESET);
        
        if(loginInfo != null) {
            redirectAttributes.addFlashAttribute("loginInfo", loginInfo);
            return "redirect:/resetPw";
        }
        
        return "user/findPw";
    }

    @GetMapping("/resetPw")
    public String resetPw() {
        return "user/resetPw";
    }
    
    /*
     * @author : 정건희
     * @since : 2024. 07. 12.
     * Description : 비밀번호 재설정
     */
    @PostMapping("/resetPw")
    public String resetPw(LoginRequestDTO loginRequestDTO, RedirectAttributes redirectAttributes) {
        
        log.debug(TeamColor.BLUE_BG + "id: " + loginRequestDTO.getEmail() + " password: " + loginRequestDTO.getPassword() + " name: " + loginRequestDTO.getName() + TeamColor.RESET);
        
        loginRequestDTO.validatePasswordCheck();
        
        int result = loginService.updateEmpPw(loginRequestDTO);
        
        if(result == 0) {
            redirectAttributes.addFlashAttribute("messageType", "false");
            redirectAttributes.addFlashAttribute("message", "비밀번호 변경에 실패하셨습니다.");
            return "redirect:/resetPw";
        }
        
        redirectAttributes.addFlashAttribute("messageType", "true");
        redirectAttributes.addFlashAttribute("message", "비밀번호가 변경에 성공하셨습니다.");
        
        return "redirect:/login";
    }
}
