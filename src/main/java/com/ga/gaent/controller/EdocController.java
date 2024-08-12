package com.ga.gaent.controller;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.ga.gaent.service.EdocService;
import com.ga.gaent.util.TeamColor;
import com.ga.gaent.util.getSessionEmpCode;
import com.ga.gaent.vo.EdocFormTypeVO;
import com.ga.gaent.vo.EdocVO;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class EdocController {
    
    @Autowired private EdocService edocService;
    
    @Autowired private getSessionEmpCode getSessionEmpCode;
    
    /*
     * @author : 정건희
     * @since : 2024. 07. 15.
     * Description : 전자결재 페이지
     */
    @GetMapping("/approval")
    public String approval(HttpSession session, Model model,
            @RequestParam(name = "currentPage", defaultValue = "1") int currentPage,
            @RequestParam(name = "rowPerPage", defaultValue = "5") int rowPerPage) {
        
        String empCode = getSessionEmpCode.getEmpCode(session);
        
        // 전자결재 페이지에서 보이는 카드(결재하기 -> 결재 대기 문서)
        List<Map<String, String>> toDoList = edocService.selectToDoAtHome(currentPage, rowPerPage, empCode);
        // log.debug(TeamColor.BLUE_BG + "toDoList: " + toDoList + TeamColor.RESET);
        
        // 전자결재 페이지에서 보이는 리스트(개인문서함 -> 대기 문서)
        List<EdocVO> draftList = edocService.selectDraftAtHome(currentPage, rowPerPage, empCode);
        // log.debug(TeamColor.BLUE_BG + "draftList: " + draftList + TeamColor.RESET);
        
        // 전자결재 페이지에서 보이는 리스트(개인문서함 -> 대기 문서)에 대한 페이징
        Map<String, Object> pagingMap = edocService.getDraftPagingAtHome(currentPage, rowPerPage, empCode, 0);
        // log.debug(TeamColor.BLUE_BG + "pagingMap: " + pagingMap + TeamColor.RESET);
        
        model.addAttribute("toDoList", toDoList);
        model.addAttribute("draftList", draftList);
        model.addAttribute("pg", pagingMap);
        
        return "edoc/approval";
    }
    
    /*
     * @author : 정건희
     * @since : 2024. 07. 15.
     * Description : 기안일 구하기
     */
    @GetMapping("/edoc")
    public String edocFrom(Model model) {
        
        Calendar now = Calendar.getInstance();
        int year = now.get(Calendar.YEAR);
        int month = now.get(Calendar.MONTH);
        int day = now.get(Calendar.DATE);
        
        model.addAttribute("date", year + "년 " + (month + 1) + "월" + day + "일");
        
        return "edoc/edoc";
    }
    
    /*
     * @author : 정건희
     * @since : 2024. 07. 15.
     * Description : 전자결재문서 양식 호출
     */
    @GetMapping("/edocType")
    @ResponseBody
    public List<EdocFormTypeVO> getEdocType() {
        return edocService.selectEdocType();
    }
    
    /*
     * @author : 정건희
     * @since : 2024. 07. 15.
     * Description : select-box 선택에 따른 양식 호출
     */
    @GetMapping("/edoc/{request}")
    public String getEdocType(@PathVariable(name = "request", required = false) Integer request) {
        
        if(request == 0) {
            return "edoc/edoc-form-type/draftForm";
        } else if (request == 1){
            return "edoc/edoc-form-type/vacationForm";
        } else if (request == 2){
            return "edoc/edoc-form-type/projectForm";
        } else if (request == 3){
            return "edoc/edoc-form-type/eventForm";
        } else if (request == 4) {
            return "edoc/edoc-form-type/reportForm";
        } else {
            return "edoc/보고서";
        }
    }
    
    /*
     * @author : 정건희
     * @since : 2024. 07. 16.
     * Description : 결재하기 -> 결재 대기 문서 조회
     */
    @GetMapping("/approval/toDo")
    public String getToDo(
            HttpSession session, Model model,
            @RequestParam(name = "currentPage", defaultValue = "1") int currentPage,
            @RequestParam(name = "rowPerPage", defaultValue = "10") int rowPerPage) {
        
        String empCode = getSessionEmpCode.getEmpCode(session);
        
        List<Map<String, String>> list = edocService.selectToDo(currentPage, rowPerPage, empCode);
        /* log.debug(TeamColor.BLUE_BG + "toDoList: " + toDoList + TeamColor.RESET); */
        
        Map<String, Object> pagingMap = edocService.getApprPagingIdx(empCode,currentPage,0);
        
        model.addAttribute("pg", pagingMap);
        model.addAttribute("toDoList", list);
        
        return "edoc/edoc-approval-list/toDo";
    }
    
    /*
     * @author : 조인환
     * @since : 2024. 07. 23.
     * Description : 결재하기 -> 결재 진행 문서 조회
     */
    @GetMapping("/approval/upComing")
    public String getUpComing(
            HttpSession session, Model model,
            @RequestParam(name = "currentPage", defaultValue = "1") int currentPage,
            @RequestParam(name = "rowPerPage", defaultValue = "10") int rowPerPage) {
        
        String empCode = getSessionEmpCode.getEmpCode(session);
        
        List<Map<String, String>> list = edocService.selectUpComing(currentPage, rowPerPage, empCode);
        Map<String, Object> pagingMap = edocService.getApprPagingIdx(empCode,currentPage,1);
        
        model.addAttribute("pg", pagingMap);
        model.addAttribute("list", list);
        
        return "edoc/edoc-approval-list/upComing";
    }
    
    /*
     * @author : 조인환
     * @since : 2024. 07. 23.
     * Description : 결재하기 -> 결재 내역 조회
     */
    @GetMapping("/approval/apprHistory")
    public String getApprHistory(
            HttpSession session, Model model,
            @RequestParam(name = "currentPage", defaultValue = "1") int currentPage,
            @RequestParam(name = "rowPerPage", defaultValue = "10") int rowPerPage) {
        
        String empCode = getSessionEmpCode.getEmpCode(session);
        
        List<Map<String, String>> list = edocService.selectApprHistory(currentPage, rowPerPage, empCode);
        Map<String, Object> pagingMap = edocService.getApprPagingIdx(empCode,currentPage,2);
                
        model.addAttribute("pg", pagingMap);
        model.addAttribute("list", list);
        
        return "edoc/edoc-approval-list/apprHistory";
    }
    
    /*
     * @author : 조인환
     * @since : 2024. 07. 24.
     * Description : 전자결재 문서 상세보기
     */
    @GetMapping("/edocDetail/{edocType}/{edocNum}")
    public String getEdocDetail(
            Model model, HttpSession session,
            @PathVariable(name = "edocType") Integer edocType,
            @PathVariable(name = "edocNum") Integer edocNum) {
        
        String empCode = getSessionEmpCode.getEmpCode(session);
        
        Map<String, Object> edocDetail = edocService.selectEdocDetail(edocNum,empCode);
        log.debug(TeamColor.BLUE_BG + "edocDetail: " + edocDetail + TeamColor.RESET);
        
        Map<String, Object>formDetail = new HashMap<>();
        if(edocType == 0) {
            formDetail = edocService.selectDraftDetail(edocNum);
        }else if(edocType == 1) {
            formDetail = edocService.selectVactionDetail(edocNum);
        }else if(edocType == 2) {
            formDetail = edocService.selectProjectDetail(edocNum);
        }else if(edocType == 3) {
            formDetail = edocService.selectEventDetail(edocNum);
        }else if(edocType == 4) {
            formDetail = edocService.selectReportDetail(edocNum);
        }
        
        if(edocDetail == null || formDetail == null ) {
            return "edoc/edoc-error";
        }
        
        model.addAttribute("formDetail", formDetail);
        model.addAttribute("edocDetail", edocDetail);
        
        return "edoc/edocDetail";
    }
    
    
    /*
     * @author : 조인환
     * @since : 2024. 07. 18.
     * Description : 개인문서함 -> 대기 문서함 조회
     */
    @GetMapping("/approval/wait")
    public String getDraft(
            HttpSession session, Model model,
            @RequestParam(name = "currentPage", defaultValue = "1") int currentPage,
            @RequestParam(name = "rowPerPage", defaultValue = "10") int rowPerPage) {
        
        String empCode = getSessionEmpCode.getEmpCode(session);
        
        int request = 0;
        
        List<EdocVO> list = edocService.selectMyEdocSubmitList(empCode, request, currentPage, rowPerPage);
        Map<String, Object> pagingMap = edocService.getPersonalEdocPagingIdx(empCode, currentPage, request, rowPerPage);
        
        model.addAttribute("pg", pagingMap);
        model.addAttribute("list", list);
        
        return "edoc/edoc-personal-list/wait";
    }
    
    /*
     * @author : 조인환
     * @since : 2024. 07. 18.
     * Description : 개인문서함 -> 승인 문서함 조회
     */
    @GetMapping("/approval/approve")
    public String getApprove(HttpSession session, Model model,
            @RequestParam(name = "currentPage", defaultValue = "1") int currentPage,
            @RequestParam(name = "rowPerPage", defaultValue = "10") int rowPerPage) {
        
        String empCode = getSessionEmpCode.getEmpCode(session);
        
        int request = 1;
        
        List<EdocVO> list = edocService.selectMyEdocSubmitList(empCode, request, currentPage, rowPerPage);
        Map<String, Object> pagingMap = edocService.getPersonalEdocPagingIdx(empCode, currentPage, request, rowPerPage);
        
        model.addAttribute("pg", pagingMap);
        model.addAttribute("list", list);
        
        return "edoc/edoc-personal-list/approve";
    }
    
    /*
     * @author : 조인환
     * @since : 2024. 07. 18.
     * Description : 개인문서함 -> 반려 문서함 조회
     */
    @GetMapping("/approval/reject")
    public String getReject(
            HttpSession session, Model model,
            @RequestParam(name = "currentPage", defaultValue = "1") int currentPage,
            @RequestParam(name = "rowPerPage", defaultValue = "10") int rowPerPage) {
        
        String empCode = getSessionEmpCode.getEmpCode(session);
        
        int request = 2;
        
        List<EdocVO> list = edocService.selectMyEdocSubmitList(empCode, request, currentPage, rowPerPage);
        Map<String, Object> pagingMap = edocService.getPersonalEdocPagingIdx(empCode, currentPage, request, rowPerPage);
        
        model.addAttribute("pg", pagingMap);
        model.addAttribute("list", list);
        
        return "edoc/edoc-personal-list/reject";
    }
}
