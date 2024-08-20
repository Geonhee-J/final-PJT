package com.ga.gaent.controller;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import com.ga.gaent.dto.EmpRequestDTO;
import com.ga.gaent.dto.FileReqDTO;
import com.ga.gaent.service.HRService;
import com.ga.gaent.service.InquiryService;
import com.ga.gaent.util.FileUploadSetting;
import com.ga.gaent.util.TeamColor;
import com.ga.gaent.vo.EmpVO;
import com.ga.gaent.vo.TeamVO;
import jakarta.servlet.http.HttpSession;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/hr")
public class HRController {

    @Autowired private HRService hrService;
    
    @Autowired private InquiryService inquiryService;
    
    @Autowired private FileUploadSetting fileUploadSetting;
    
    // 세션에서 로그인한사람의 empCode추출
    private String getEmpCode(HttpSession session) {
        Map<String, Object> loginInfo = (Map<String, Object>) (session.getAttribute("loginInfo"));
        return (String) loginInfo.get("empCode");
    }
    
    @GetMapping("/notManager")
    public String notManager(RedirectAttributes rattr) {
        rattr.addFlashAttribute("message", "접속 실패 메시지.");
        rattr.addFlashAttribute("checkManagerMessage", "해당 유저에는 접속 권한이 없습니다.");
        return "redirect:/home";
    }

    /*
     * @author : 김형호
     * @since : 2024. 08. 02.
     * Description : 인사관리 홈
     */
    @GetMapping("")
    public String hr(Model model,
            @RequestParam(name="currentPage", defaultValue = "1") int currentPage,
            @RequestParam(name="rowPerPage", defaultValue = "10") int rowPerPage,
            @RequestParam(name="searchEmp", defaultValue = "") String searchEmp) {
        
        List<EmpVO> empList = inquiryService.selectEmpList(currentPage, rowPerPage, searchEmp);
        
        int lastPage = inquiryService.selectEmpCount(searchEmp) / rowPerPage;
        if(inquiryService.selectEmpCount(searchEmp) % rowPerPage != 0) {
            lastPage++;
        }
        System.out.println("lastPage : " + lastPage);
        System.out.println("currentPage : " + currentPage);
        
        model.addAttribute("empList", empList);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("rowPerPage", rowPerPage);
        model.addAttribute("lastPage", lastPage);
        
        return "hr/hr";
    }
    
    /*
     * @author : 김형호
     * @since : 2024. 07. 15.
     * Description : 조직도 정보 조회
     */
    @GetMapping("/tree")
    public @ResponseBody List<Map<String, Object>> orgChart(){
        return hrService.selectTreeInfo();
    }
    
    /*
     * @author : 정건희
     * @since : 2024. 07. 19.
     * Description : 직원 리스트 조회(페이징 기능 적용)
     */
    @GetMapping("/empList")
    public String getEmpList(
            @RequestParam(name="currentPage", defaultValue = "1") int currentPage,
            @RequestParam(name="rowPerPage", defaultValue = "10") int rowPerPage,
            Model model, HttpSession session) {
        
        String empCode = getEmpCode(session);
        
        List<Map<String, Object>> empList = hrService.selectEmpList(empCode, currentPage, rowPerPage);
        
        int lastPage = hrService.selectTeamCount() / rowPerPage;
        
        if(lastPage % rowPerPage != 0) {
            lastPage++;
        }
        
        model.addAttribute("empList", empList);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("rowPerPage", rowPerPage);
        model.addAttribute("lastPage", lastPage);
        
        return "hr/emp/empList";
    }
    
    /*
     * @author : 정건희
     * @since : 2024. 07. 19.
     * Description : 직원 상세 조회
     */
    @GetMapping("/empDetail/{empCode}")
    public String getEmpDetail(@PathVariable(name = "empCode") String empCode, Model model) {
        
        // log.debug(TeamColor.PURPLE_BG + "get-empCode: " + empCode + TeamColor.RESET);
        
        EmpVO empDetail = hrService.selectEmpDetail(empCode, model);
        model.addAttribute("empDetail", empDetail);
        
        return "hr/emp/empDetail";
    }
    
    /*
     * @author : 정건희
     * @since : 2024. 07. 19.
     * Description : 직원 등록 폼
     */
    @GetMapping("/addEmp")
    public String addEmpForm() {
        return "hr/emp/addEmp";
    }
    
    /*
     * @author : 정건희
     * @since : 2024. 07. 23.
     * Description : 직원 등록 -> 사원코드 중복 검사
     */
    @GetMapping("/checkEmpCode")
    @ResponseBody
    public String checkEmpCode(@RequestParam(name = "empCode") String empCode) {
        log.debug(TeamColor.PURPLE_BG + "empCode: " + empCode + TeamColor.RESET);
        
        String checkEmpCode = hrService.checkEmpCode(empCode);
        log.debug(TeamColor.PURPLE_BG + "checkEmpCode: " + checkEmpCode + TeamColor.RESET);
        
        if(empCode.equals(checkEmpCode)) {
            return "이미 존재하는 사원코드 입니다.";
        }
        return "사용가능한 사원코드 입니다.";
    }
    
    /*
     * @author : 정건희
     * @since : 2024. 07. 23.
     * Description : 직원 등록 -> 이메일(ID) 중복 검사
     */
    @GetMapping("/checkEmpId")
    @ResponseBody
    public String checkEmpId(@RequestParam(name = "empId") String empId) {
        log.debug(TeamColor.PURPLE_BG + "empId: " + empId + TeamColor.RESET);
        
        String checkEmpId = hrService.checkEmpId(empId);
        log.debug(TeamColor.PURPLE_BG + "checkEmpId: " + checkEmpId + TeamColor.RESET);
        
        if(empId.equals(checkEmpId)) {
            return "이미 존재하는 아이디 입니다.";
        }
        return "사용가능한 아이디 입니다.";
    }
    
    /*
     * @author : 정건희
     * @since : 2024. 07. 22.
     * Description : 직원 등록 액션
     */
    @PostMapping("/addEmp")
    @ResponseBody
    public void addEmpForm(EmpRequestDTO empRequestDTO, FileReqDTO fileReqDTO) {
        
        // log.debug(TeamColor.PURPLE_BG + "empRequestDTO: " + empRequestDTO + TeamColor.RESET);
        // log.debug(TeamColor.BLUE_BG + "fileReqDTO: " + fileReqDTO + TeamColor.RESET);
        
        if (!fileReqDTO.getGaFile().isEmpty()) {
            fileReqDTO.validateFileType();
        }
        
        int result = 0;
        
        String newFileName = hrService.insertEmp(empRequestDTO, fileReqDTO);
        
        if(!newFileName.equals("empty")) {
            result = fileUploadSetting.insertFile(newFileName, fileReqDTO, "profile");
        }
        
        if(result != 1) {
            throw new RuntimeException("직원 등록에 실패했습니다.");
        }
    }
    
    /*
     * @author : 정건희
     * @since : 2024. 07. 19.
     * Description : 직원 정보 수정 폼
     */
    @GetMapping("/modifyEmp/{empCode}")
    public String modifyEmp(@PathVariable(name = "empCode") String empCode, Model model) {
        
        // log.debug(TeamColor.PURPLE_BG + "modify-empCode: " + empCode + TeamColor.RESET);
        
        EmpVO empDetail = hrService.selectEmpDetail(empCode, model);
        model.addAttribute("empDetail", empDetail);
        
        return "/hr/emp/modifyEmp";
    }
    
    /*
     * @author : 정건희
     * @since : 2024. 07. 22.
     * Description : 직원 수정 액션
     */
    @PostMapping("/modifyEmp")
    @ResponseBody
    public void modifyEmpForm(EmpRequestDTO empRequestDTO, FileReqDTO fileReqDTO) {
        
        // log.debug(TeamColor.PURPLE_BG + "empRequestDTO: " + empRequestDTO + TeamColor.RESET);
        // log.debug(TeamColor.BLUE_BG + "fileReqDTO: " + fileReqDTO + TeamColor.RESET);
        
        if (!fileReqDTO.getGaFile().isEmpty()) {
            fileReqDTO.validateFileType();
        }
        
        int result = 0;
        
        String newFileName = hrService.updateEmp(empRequestDTO, fileReqDTO);
        
        if(!newFileName.equals("empty")) {
            result = fileUploadSetting.insertFile(newFileName, fileReqDTO, "profile");
        }
        
        if(result != 1) {
            throw new RuntimeException("직원 수정에 실패했습니다.");
        }
    }
    
    /*
     * @author : 정건희
     * @since : 2024. 07. 22.
     * Description : 직원 삭제
     */
    @GetMapping("/removeEmp")
    public String removeEmp(
            @RequestParam(name = "empCode") String empCode,
            @RequestParam(name = "profile") String profile) {
        
        int removeEmp = hrService.deleteEmp(empCode, profile);
        
        if(removeEmp == 1) {
            return "redirect:/hr/empList";
        }else {
            return "redirect:/hr/empList";
        }
    }
    
    /*
     * @author : 김형호
     * @since : 2024. 07. 15.
     * Description : 부서 등록 폼
     */
    @GetMapping("/addTeam")
    public String addTeamForm() {
        return "hr/team/addTeam";
    }
    
    /*
     * @author : 김형호
     * @since : 2024. 07. 15.
     * Description : 부서 등록 액션
     */
    @PostMapping("/addTeam")
    public String addTeamAction(TeamVO team) {
        
        int addTeam = hrService.insertTeam(team);
        
        if(addTeam == 1) {
            return "redirect:/hr/teamList";
        }else {
            return "redirect:/hr/addTeam";
        }
    }
    
    /*
     * @author : 김형호
     * @since : 2024. 07. 16.
     * Description : 부서 수정
     */
    @PostMapping("/modifyTeam")
    public String modifyTeam(TeamVO team) {
        
        int modifyTeam = hrService.updateTeam(team);
        
        if(modifyTeam == 1) {
            return "redirect:/hr/deptDetail?teamCode=" + team.getTeamCode();
        }else {
            return "redirect:/hr/deptDetail?teamCode=" + team.getTeamCode();
        }
    }
    
    /*
     * @author : 김형호
     * @since : 2024. 07. 16.
     * Description : 부서 삭제
     */
    @GetMapping("/removeTeam")
    public String removeTeam(int teamCode, RedirectAttributes rattr) {
        
        int removeTeam = hrService.deleteTeam(teamCode);
        
        if(removeTeam == 1) {
            rattr.addFlashAttribute("message", "부서정보를 삭제하였습니다.");
            return "redirect:/hr";
        }else {
            rattr.addFlashAttribute("message", "부서원이 존재하여 정보 삭제에 실패했습니다.");
            return "redirect:/hr/deptDetail?teamCode=" + teamCode;
        }
    }
    
    /*
     * @author : 김형호
     * @since : 2024. 07. 16.
     * Description : 부서 리스트 조회(페이징 기능 적용)
     */
    @GetMapping("/teamList")
    public String getTeamList(
            Model model,
            @RequestParam(name="currentPage", defaultValue = "1") int currentPage,
            @RequestParam(name="rowPerPage", defaultValue = "10") int rowPerPage) {
        
        List<TeamVO> teamList = hrService.selectTeamList(currentPage, rowPerPage);
        
        int lastPage = hrService.selectTeamCount() / rowPerPage;
        
        if(lastPage % rowPerPage != 0) {
            lastPage++;
        }
        
        model.addAttribute("teamList", teamList);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("rowPerPage", rowPerPage);
        model.addAttribute("lastPage", lastPage);
        
        return "hr/team/teamList";
    }
    
    /*
     * @author : 김형호
     * @since : 2024. 07. 16.
     * Description : 부서 등록 부서코드 유효성 검사
     */
    @ResponseBody
    @GetMapping("/checkTeamCode")
    public int checkTeamCode(@RequestParam(value="teamCode") String teamCode) {
        return hrService.checkTeamCode(teamCode);
    }
    
    /*
     * @author : 김형호
     * @since : 2024. 07. 24.
     * Description : 조직도 활용 부서 정보 조회
     */
    @GetMapping("/deptDetail")
    public String deptDetail(
            @RequestParam(name="currentPage", defaultValue = "1") int currentPage,
            @RequestParam(name="rowPerPage", defaultValue = "5") int rowPerPage,
            Model model, String teamCode) {
        
        // 부서상세
        List<Map<String, Object>> deptDetail = hrService.selectDeptDetail(teamCode);
        // 부서총원
        int deptTotal = hrService.selectDeptTotal(teamCode);
        // 관련부서
        List<Map<String, Object>> deptTeam = hrService.selectDeptTeam(teamCode);
        // 팀상세
        List<Map<String, Object>> teamDetail = hrService.selectTeamDetail(teamCode);
        // 팀 멤버 정보 조회
        List<Map<String, Object>> memberDetail = hrService.selectMemberDetail(teamCode, currentPage, rowPerPage);
        
        int memberCount = hrService.selectMemberCount(teamCode);
        
        int lastPage = memberCount / rowPerPage;
        if(memberCount % rowPerPage != 0) {
            lastPage++;
        }
        System.out.println("memberCount : " + memberCount);
        System.out.println("rowPerPage : " + rowPerPage);
        System.out.println("lastPage : " + lastPage);
                
        model.addAttribute("deptDetail", deptDetail);
        model.addAttribute("deptTeam", deptTeam);
        model.addAttribute("deptTotal", deptTotal);
        model.addAttribute("teamDetail", teamDetail);
        model.addAttribute("memberDetail", memberDetail);
        model.addAttribute("teamCode", teamCode);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("rowPerPage", rowPerPage);
        model.addAttribute("lastPage", lastPage);
        
        return "hr/team/deptDetail";
    }
    
    /*
     * @author : 정건희
     * @since : 2024. 07. 31.
     * Description : 조직도 활용 팀 정보 조회
     */
    @GetMapping("/teamDetail")
    public String teamDetail(
            @RequestParam(name="currentPage", defaultValue = "1") int currentPage,
            @RequestParam(name="rowPerPage", defaultValue = "5") int rowPerPage,
            Model model, String teamCode) {
        
        // 팀상세
        List<Map<String, Object>> teamDetail = hrService.selectTeamDetail(teamCode);
        
        // 팀 멤버 정보 조회
        List<Map<String, Object>> memberDetail = hrService.selectMemberDetail(teamCode, currentPage, rowPerPage);
        
        int memberCount = hrService.selectMemberCount(teamCode);
        
        int lastPage = memberCount / rowPerPage;
        if(memberCount % rowPerPage != 0) {
            lastPage++;
        }
        
        model.addAttribute("teamDetail", teamDetail);
        model.addAttribute("memberDetail", memberDetail);
        model.addAttribute("teamCode", teamCode);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("rowPerPage", rowPerPage);
        model.addAttribute("lastPage", lastPage);
        
        return "hr/team/teamDetail";
    }
}
