package com.ga.gaent.controller;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.ga.gaent.dto.FileReqDTO;
import com.ga.gaent.dto.MsgDTO;
import com.ga.gaent.service.MsgService;
import com.ga.gaent.util.FileUploadSetting;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/msg")
public class MsgController {
    final String YELLOW = "\u001B[33m\n";
    final String RED = "\u001B[31m\n";
    final String RESET = "\u001B[0m\n";

    @Autowired MsgService msgService;
    
    @Autowired FileUploadSetting fileUploadSetting;
    
    // 세션에서 로그인한사람의 empCode추출
    private String getEmpCode(HttpSession session) {
        Map<String, Object> loginInfo = (Map<String, Object>) (session.getAttribute("loginInfo"));
        return (String) loginInfo.get("empCode");
    }

    // 리스트출력
    @GetMapping("/{request}")
    String selectMsgList(
            HttpSession session, Model model,
            @PathVariable(name = "request", required = false) Integer request, 
            @RequestParam(name = "currentPage", defaultValue = "1") int currentPage,
            @RequestParam(name = "searchMsg", defaultValue = "") String searchMsg) {
        
        // 세션에서 로그인한사람의 empCode추출
        /*
         * Map<String, Object> loginInfo = (Map<String, Object>) (session.getAttribute("loginInfo")); String
         * empCode = (String) loginInfo.get("empCode");
         */
        
        String empCode = getEmpCode(session);
        
        // 리스트가져오기
        List<MsgDTO> list = msgService.getMsgList(empCode, request, currentPage, searchMsg);
        // 페이징에 필요한 요소 가져오기
        Map<String, Object> pagingMap = msgService.getPagingIdx(empCode, request, currentPage, searchMsg);


        model.addAttribute("list", list);
        model.addAttribute("pg", pagingMap);

        if (request == 1) { // 받은쪽지함
            return "/msg/msgReceiveList";
        } else if (request == 2) { // 보낸쪽지함
            return "/msg/msgSendList";
        } else if (request == 3) { // 내게쓴쪽지함
            return "/msg/msgSelf";
        } else if (request == 4) { // 휴지통
            return "/msg/msgBin";
        } else { // 전체
            return "/msg/msgList";
        }
    }

    // 발송
    @PostMapping("/sendMessage")
    @ResponseBody
    public int sendMsg(MsgDTO m, FileReqDTO fileReqDTO) {
        
        log.debug(RED + "확인 : " + m.getMsgTitle() + RESET);
        log.debug(YELLOW + "원본이름 :" + fileReqDTO.getGaFile() + RESET);

        // 파일을 업로드 했을 시에만 동작
        if (!fileReqDTO.getGaFile().isEmpty()) {
            // 파일 확장자 확인
            fileReqDTO.validateFileType();
        }

        int result = -1;

        // 쪽지전송
        String newFileName = msgService.sendMsg(m, fileReqDTO);

        // 업로드 파일이 없을시에만 동작
        if (!newFileName.equals("empty")) {
            // 'static/upload/원하는위치' 에저장
            result = fileUploadSetting.insertFile(newFileName, fileReqDTO, "msgfile");
        }

        return result;
    }

    // 삭제,복원
    @PostMapping("/modifyMsgStatus")
    @ResponseBody
    public int modifyMsgStatus(
            @RequestParam(name = "empCode") String empCode, 
            @RequestParam(name = "request") String request, 
            @RequestParam(name = "msgNums", required = false) String[] msgNums) {
        
        // 배열의 내용을 보기 위해 Arrays.toString()을 사용
        log.debug(YELLOW + "(컨)번호: " + Arrays.toString(msgNums) + " request: " + request + RESET);
        log.debug(YELLOW + "개수 " + msgNums.length + RESET);

        int result = 0;
        Map<String, Object> deleteMsgMap = new HashMap<>();
        for (String no : msgNums) {
            deleteMsgMap.put("empCode", empCode);
            deleteMsgMap.put("request", request);
            deleteMsgMap.put("msgNum", no); // 여기서 msgNum을 각각의 no로 수정합니다.
            result = result + msgService.modifyMsgState(deleteMsgMap);
        }

        log.debug(RED + "result: " + result + RESET);
        if (msgNums.length == result) {
            return 1;
        } else {
            return 0;
        }

    }

    // 메시지 상세
    @GetMapping("/msgDetail/{msgNum}")
    public String msgDetail(
            HttpSession session, Model model, 
            @PathVariable(name = "msgNum", required = false) String msgNum) {
        
        String empCode = getEmpCode(session);

        MsgDTO msgDetail = msgService.msgDetail(msgNum, empCode);
 
        model.addAttribute("m", msgDetail);
        return "/msg/msgDetail";
    }

    // 안읽은 쪽지 수
    @GetMapping("/msgNotReadCnt")
    @ResponseBody
    public int msgNotReadCnt(@RequestParam String empCode) {
        return msgService.msgNotReadCnt(empCode);
    }


    // 삭제,복원
    @PostMapping("/readMsg")
    @ResponseBody
    public int readMsg(
            @RequestParam(name = "empCode") String empCode, 
            @RequestParam(name = "msgNums", required = false) String[] msgNums) {
        
        // 배열의 내용을 보기 위해 Arrays.toString()을 사용합니다.
        log.debug(YELLOW + "(컨)번호: " + Arrays.toString(msgNums) + RESET);
        log.debug(YELLOW + "개수 " + msgNums.length + RESET);

        int result = 0;
        for (String no : msgNums) {
            result = result + msgService.readMsg(empCode, no);
        }

        log.debug(RED + "result: " + result + RESET);

        return result;
    }
}


