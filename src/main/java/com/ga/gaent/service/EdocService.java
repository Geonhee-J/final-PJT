package com.ga.gaent.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.ga.gaent.dto.EdocFormTypeDTO;
import com.ga.gaent.dto.EdocRequestDTO;
import com.ga.gaent.mapper.EdocMapper;
import com.ga.gaent.util.TeamColor;
import com.ga.gaent.vo.EdocFormTypeVO;
import com.ga.gaent.vo.EmpVO;
import ch.qos.logback.core.pattern.color.MagentaCompositeConverter;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Transactional
@Service
public class EdocService {

    @Autowired EdocMapper edocMapper;
    
    /*
     * @author : 정건희
     * @since : 2024. 07. 14.
     * Description : 전자결재 양식 호출
     */
    public List<EdocFormTypeVO> selectEdocType() {
        return edocMapper.selectEdocType();
    }
    
    /*
     * @author : 정건희
     * @since : 2024. 07. 15.
     * Description : 결재선 리스트 호출
     */
    public List<EmpVO> selectApprover() {
        return edocMapper.selectApprover();
    }
    
    /*
     * @author : 정건희, 조인환
     * @since : 2024. 07. 15.
     * Description : 전자결재(전자결재 문서, 문서양식, 결재선) 데이터 입력
     */
    public int insertEdoc(
            EdocRequestDTO edocRequestDTO,
            EdocFormTypeDTO edocFormTypeDTO) {
        
        // 공통으로 들어가는 전자결재 문서
        int edocResult = edocMapper.insertEdoc(edocRequestDTO);
        
        Integer edocNum = edocRequestDTO.getEdocNum();
        edocRequestDTO.setEdocNum(edocNum);
        edocFormTypeDTO.setEdocNum(edocNum);
        
        
        String[] approvers = edocRequestDTO.getApprover();
        String[] apprOrders = edocRequestDTO.getApprOrder();
        
        int approvalResult = -1;
        
        for(int i = 0; i < approvers.length; i++) {
            Map<String, Object> edocMap = new HashMap<>();
            edocMap.put("edocNum", edocNum);
            edocMap.put("approver", approvers[i]);
            edocMap.put("apprOrder", apprOrders[i]);
            // 공통으로 들어가는 결재선
            approvalResult = edocMapper.insertApprover(edocMap);
        }
        
        String edocType = edocFormTypeDTO.getEdocType();
        
        int insertEdocForm = -1;
        if(edocType.equals("0")){
            System.out.println("기안서 제출");
            insertEdocForm = edocMapper.insertEdocDraft(edocFormTypeDTO);
        }else if(edocType.equals("1")){
            System.out.println("휴가신청서 제출");
            insertEdocForm = edocMapper.insertEdocVacation(edocFormTypeDTO);
        }else if(edocType.equals("2")){
            System.out.println("지출결의서 제출");
            insertEdocForm = edocMapper.insertEdocProject(edocFormTypeDTO);
        }else if(edocType.equals("3")){
            System.out.println("경조사지출결의서 제출");
            insertEdocForm = edocMapper.insertEdocEvent(edocFormTypeDTO);
        }else if(edocType.equals("4")){
            System.out.println("차량이용신청서 제출");
            insertEdocForm = edocMapper.insertEdocCar(edocFormTypeDTO);
        }else if(edocType.equals("5")){
            System.out.println("보고서 제출");
            insertEdocForm = edocMapper.insertEdocReport(edocFormTypeDTO);
        }
        
        
        if(edocResult != 1 || insertEdocForm != 1) {
            throw new RuntimeException("전자결재 입력을 실패했습니다.");
        }
        
        return 1;
    }
    
    /*
     * @author : 정건희
     * @since : 2024. 07. 15.
     * Description : 전자결재 첨부파일 데이터 입력
     */
    public int insertEdocFile(EdocRequestDTO edocRequestDTO) {
        
        String originalFileName = edocRequestDTO.getFileName().getOriginalFilename();
        String fileName = (UUID.randomUUID().toString()).replace("-", "");
        String fileType = edocRequestDTO.getFileName().getContentType();
        /* String file = fileName + fileType; */
        double fileSize = edocRequestDTO.getFileName().getSize();
        
        Map<String, Object> insertFile = new HashMap<>();
        
        insertFile.put("originalFileName", originalFileName);
        insertFile.put("fileName", fileName);
        insertFile.put("fileType", fileType);
        insertFile.put("fileSize", fileSize);
        
        return edocMapper.insertEdocFile(insertFile);
    }
    
    /*
     * @author : 정건희
     * @since : 2024. 07. 17.
     * Description : 결재대기문서 리스트 호출(전자결재 홈)
     */
    public List<Map<String, String>> selectToDo(String empCode) {
        
        Map<String, Object> toDoMap = new HashMap<>();
        
        toDoMap.put("empCode", empCode);
        
        return edocMapper.selectToDo(toDoMap);
    }
    
    /*
     * @author : 정건희
     * @since : 2024. 07. 16.
     * Description : 결재대기문서 리스트 호출
     */
    public List<Map<String, String>> selectToDo(int currentPage, int rowPerPage, String empCode) {
        
        Map<String, Object> toDoMap = new HashMap<>();
        
        toDoMap.put("empCode", empCode);
        toDoMap.put("startRow", (currentPage - 1) * rowPerPage);
        
        return edocMapper.selectToDo(toDoMap);
    }
    
    /*
     * @author : 정건희
     * @since : 2024. 07. 16.
     * Description : 전자결재 문서 상세보기
     */
    public Map<String, Object> selectEdocDetail(int edocNum) {
        return edocMapper.selectEdocDetail(edocNum);
    }
    
    //  결재,반려처리
    public int updateEdocProcess(int empCode,String edocNum,String edocReason, int request) {
        
        String requestEnum =  String.valueOf(request);
        Map<String,Object>map = new HashMap<>();
        map.put("empCode", empCode);
        map.put("edocNum", edocNum);
        map.put("edocReason", edocReason);
        map.put("request", requestEnum);
        
        if(request < 0) {
            map.put("apprStatus", "-1" );
        }else if(request > 0){
            map.put("apprStatus", "1" );
        }
        
        int s1 = edocMapper.updateEdocApprovalStatus(map); // 결재선테이블
        log.debug(TeamColor.YELLOW + "결재선" + s1 + TeamColor.RESET);
        
        int s2 = edocMapper.updateEdocStatus(map); // 전자문서공통테이블
        log.debug(TeamColor.YELLOW + "공통" + s2 + TeamColor.RESET);
        return 1;
    }
}
