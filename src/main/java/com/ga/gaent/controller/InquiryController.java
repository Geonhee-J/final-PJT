package com.ga.gaent.controller;

import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.ga.gaent.service.InquiryService;
import com.ga.gaent.vo.EmpVO;
import com.ga.gaent.vo.TeamVO;

@Controller
@RequestMapping("/inquiry")
public class InquiryController {
    
    @Autowired
    InquiryService inquiryService;
    
    // 직원 조회 메인 화면
    @GetMapping("/main")
    public String main() {  
        return "inquiry/main";
    }
    
    // 피라미드 조직도 정보 조회
    @GetMapping("/getGroupInfo")
    public @ResponseBody List<Map<String, Object>> getGroupInfo(){
        
        return inquiryService.selectGroupInfo();
    }

    // 직원 조회
    // 페이징 기능 적용
    @GetMapping("/empList")
    public String empList(Model model,
            @RequestParam(name="currentPage", defaultValue = "1") int currentPage,
            @RequestParam(name="rowPerPage", defaultValue = "10") int rowPerPage) {
        
        List<EmpVO> empList = inquiryService.selectEmpList(currentPage, rowPerPage);
        
        int lastPage = inquiryService.selectEmpCount() / rowPerPage;
        if(lastPage % rowPerPage != 0) {
            lastPage++;
        }
        
        model.addAttribute("empList", empList);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("rowPerPage", rowPerPage);
        model.addAttribute("lastPage", lastPage);
        
        return "inquiry/empList";
    }
    
    // 그룹 조회
    // 페이징 기능 적용
    @GetMapping("/teamList")
    public String teamList(Model model,
            @RequestParam(name="currentPage", defaultValue = "1") int currentPage,
            @RequestParam(name="rowPerPage", defaultValue = "10") int rowPerPage) {
        
        List<TeamVO> teamList = inquiryService.selectTeamList(currentPage, rowPerPage);
        
        int lastPage = inquiryService.selectTeamCount() / rowPerPage;
        if(lastPage % rowPerPage != 0) {
            lastPage++;
        }
        
        model.addAttribute("teamList", teamList);
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("rowPerPage", rowPerPage);
        model.addAttribute("lastPage", lastPage);
        
        return "inquiry/teamList";
    }
    
    /*
     * @author : 김형호
     * @since : 2024. 07. 27.
     * Description : 직원 상세 조회
     */
    @GetMapping("/empDetail/{empCode}")
    public String getEmpDetail(@PathVariable(name = "empCode") String empCode, Model model) {
        
        EmpVO empDetail = inquiryService.selectEmpDetail(empCode, model);
        model.addAttribute("empDetail", empDetail);
        
        return "inquiry/empDetail";
    }
}
