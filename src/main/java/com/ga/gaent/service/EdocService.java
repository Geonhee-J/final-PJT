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
import com.ga.gaent.util.Paging;
import com.ga.gaent.util.RowPerPaging;
import com.ga.gaent.util.TeamColor;
import com.ga.gaent.vo.EdocFormTypeVO;
import com.ga.gaent.vo.EdocVO;
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
     * @since : 2024. 07. 17.
     * Description : 결재대기문서 리스트 호출(전자결재 홈)
     */
    public List<Map<String, String>> selectToDoInHome(String empCode) {
        
        Map<String, Object> toDoMap = new HashMap<>();
        
        toDoMap.put("empCode", empCode);
        toDoMap.put("startRow", 0);
        toDoMap.put("rowPerPage", 4);
        toDoMap.put("request", 0);
        
        return edocMapper.selectApprList(toDoMap);
    }
    
    /*
     * @author : 정건희
     * @since : 2024. 07. 26.
     * Description : 대기문서함 리스트 호출(전자결재 홈)
     */
    public List<EdocVO> selectDraftInHome(int currentPage, int rowPerPage, String empCode) {
        
        Map<String, Object> draftMap = new HashMap<>();
        
        draftMap.put("empCode", empCode);
        draftMap.put("startRow", (currentPage - 1) * rowPerPage);
        draftMap.put("rowPerPage", rowPerPage);
        draftMap.put("request", 0);
        
        List<EdocVO> list = edocMapper.selectMyEdocSubmitList(draftMap);
        
        return list;
    }
    
    /*
     * @author : 조인환
     * @since : 2024. 07. 24.
     * Description : 개인 문서함 -> 결재 올린 문서에 대한 페이징
     */
    public Map<String, Object> getDraftPagingInHome(int currentPage, int rowPerPage, String empCode, int request) {
        
        Map<String, Object> cntMap = new HashMap<>();
        
        cntMap.put("empCode", empCode);
        cntMap.put("request", request);
        
        int totalRow = edocMapper.edocSubmitListCnt(cntMap);
        
        RowPerPaging rowPerPaging = new RowPerPaging();
        
        Map<String, Object> pagingMap = rowPerPaging.Paging(currentPage, rowPerPage, totalRow);
        
        return pagingMap;
    }
    
    /*
     * @author : 정건희
     * @since : 2024. 07. 16.
     * Description : 결재하기 -> 결재 대기 문서 조회
     */
    public List<Map<String, String>> selectToDo(int currentPage, int rowPerPage, String empCode) {
        
        Map<String, Object> map = new HashMap<>();
        
        map.put("empCode", empCode);
        map.put("startRow", (currentPage - 1) * rowPerPage);
        map.put("request", 0);
        
        return edocMapper.selectApprList(map);
    }
    
    /*
     * @author : 조인환
     * @since : 2024. 07. 23.
     * Description : 결재하기 -> 결재 진행 문서 조회
     */
    public List<Map<String, String>> selectUpComing(int currentPage, int rowPerPage, String empCode) {
        
        Map<String, Object> map = new HashMap<>();
        
        map.put("empCode", empCode);
        map.put("startRow", (currentPage - 1) * rowPerPage);
        map.put("request", 1);
        
        return edocMapper.selectApprList(map);
    }
    
    
    /*
     * @author : 조인환
     * @since : 2024. 07. 23.
     * Description : 결재하기 -> 결재 내역 조회
     */
    public List<Map<String, String>> selectApprHistory(int currentPage, int rowPerPage, String empCode) {
        
        Map<String, Object> map = new HashMap<>();
        
        map.put("empCode", empCode);
        map.put("startRow", (currentPage - 1) * rowPerPage);
        map.put("request", 2);
        
        return edocMapper.selectApprList(map);
    }
    
    
    /*
     * @author : 조인환
     * @since : 2024. 07. 23.
     * Description : 결재하기 -> 결재 문서에 대한 페이징
     */
    public Map<String, Object> getApprPagingIdx(String empCode, int currentPage, int request){
        
        Map<String, Object> m = new HashMap<>();
        m.put("empCode", empCode);
        m.put("request", request);
        
        int totalRow = edocMapper.apprListCnt(m);
        
        Paging v = new Paging();
        Map<String, Object> pagingMap = v.Paging(currentPage, totalRow);

        return pagingMap;
    }

    /*
     * @author : 조인환
     * @since : 2024. 07. 24.
     * Description : 개인 문서함 -> 대기, 승인, 반려 이력 조회
     */ 
    public List<EdocVO>selectMyEdocSubmitList(String empCode, int request){
        
        Map<String,Object>map = new HashMap<>();
        
        map.put("empCode", empCode);
        map.put("request", request);
        
        List<EdocVO>list = edocMapper.selectMyEdocSubmitList(map);
        
        return list;
    };
    
    /*
     * @author : 조인환
     * @since : 2024. 07. 24.
     * Description : 개인 문서함 -> 결재 올린 문서에 대한 페이징
     */
    public Map<String, Object> getPersonalEdocPagingIdx(String empCode, int currentPage, int request) {
        
        Map<String, Object> m = new HashMap<>();
        
        m.put("empCode", empCode);
        m.put("request", request);
        
        int totalRow = edocMapper.edocSubmitListCnt(m);
        
        Paging v = new Paging();
        
        Map<String, Object> pagingMap = v.Paging(currentPage, 0);
        
        return pagingMap;
    }
    
    /*
     * @author : 조인환
     * @since : 2024. 07. 24.
     * Description : 전자결재 문서(공통부분) 상세보기
     */
    public Map<String, Object> selectEdocDetail(int edocNum,String empCode) {
        
        Map<String,Object>map = new HashMap<>();
        
        map.put("empCode", empCode);
        map.put("edocNum", edocNum);
        
        Map<String,Object>resultMap = edocMapper.selectEdocDetail(map);

        if(resultMap != null) {
            resultMap.put("approverName1",  edocMapper.findKorName((String)resultMap.get("approver1")));
            resultMap.put("approverName2",  edocMapper.findKorName((String)resultMap.get("approver2")));
        }
        
        return resultMap;
    }
    
    /*
     * @author : 조인환
     * @since : 2024. 07. 24.
     * Description : 각 전자문서 종류별 세부사항 조회
     */
    public Map<String,Object>selectDraftDetail(int edocNum){
        // 기안서
        return edocMapper.selectDraftDetail(edocNum);
    }
    
    public Map<String,Object>selectVactionDetail(int edocNum){
        // 휴가신청서
        return edocMapper.selectVactionDetail(edocNum);
    }
    
    public Map<String, Object> selectProjectDetail(int edocNum) {
        // 지출결의서
        return edocMapper.selectProjectDetail(edocNum);
    }
    
    public Map<String, Object> selectEventDetail(int edocNum) {
        // 경조사 지출결의서
        return edocMapper.selectEventDetail(edocNum);
    }
    
    public Map<String, Object> selectReportDetail(int edocNum) {
        // 보고서(경위서)
        return edocMapper.selectReportDetail(edocNum);
    }
    
    /*
     * @author : 정건희
     * @since : 2024. 07. 28.
     * Description : 결재대기문서 갯수 확인
     */ 
    public int waitEdocCnt(String empCode, int request) {
        
        Map<String, Object> paramMap = new HashMap<>();
        
        paramMap.put("empCode", empCode);
        paramMap.put("request", request);
        
        return edocMapper.waitEdocCnt(paramMap);
    }
}
