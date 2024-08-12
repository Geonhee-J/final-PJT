package com.ga.gaent.service;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import com.ga.gaent.dto.EdocFormTypeDTO;
import com.ga.gaent.dto.EdocRequestDTO;
import com.ga.gaent.dto.FileReqDTO;
import com.ga.gaent.mapper.EdocProcessMapper;
import com.ga.gaent.mapper.FileMapper;
import com.ga.gaent.util.FileExtension;
import com.ga.gaent.util.FileUploadSetting;
import com.ga.gaent.util.TeamColor;
import com.ga.gaent.vo.FileVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Transactional
@Service
public class EdocProcessService {
    
    @Autowired EdocProcessMapper edocProcessMapper;
    
    @Autowired FileUploadSetting fileUploadSetting;
    
    @Autowired FileExtension fileExtension;
    
    @Autowired FileMapper fileMapper;
    
    /*
     * @author : 정건희, 조인환
     * @since : 2024. 07. 15.
     * Description : 전자결재(전자결재 문서, 문서양식, 결재선) 데이터 입력
     */
    public int insertEdoc(
            EdocRequestDTO edocRequestDTO,
            EdocFormTypeDTO edocFormTypeDTO,
            FileReqDTO fileReqDTO
            ) {
        
        // 공통으로 들어가는 전자결재 문서
        int edocResult = -1;
        
        // 결재선
        int approvalResult = -1;
        
        // 세부 폼 입력
        int insertEdocForm = -1;
        
        int fileInsertResult = -1;
        
        // 실제 파일 static에 업로드
        int realFileInsert = -1;
        
        // 파일이름 초기화
        String newFileName = null;
        
        MultipartFile mf = fileReqDTO.getGaFile();
        if (!fileReqDTO.getGaFile().isEmpty()) {
            log.debug(TeamColor.RED + "파일이 있습니다!" + TeamColor.RESET);
            String originalFilename = mf.getOriginalFilename();
            String fileType = mf.getContentType().toLowerCase();
            long fileSize = mf.getSize();
            String prefix = UUID.randomUUID().toString().replace("-", "");
            String suffix = fileExtension.getFileExtension(originalFilename);
            newFileName = prefix + suffix;
            
            FileVO gaFile = new FileVO();
            gaFile.setOriginalName(originalFilename);
            gaFile.setFileType(fileType);
            gaFile.setFileSize(fileSize);
            gaFile.setFileName(newFileName); 
            
            edocRequestDTO.setFileName(newFileName);
            
            // edocFile테이블에 Insert
            fileInsertResult = fileMapper.insertEdocFile(gaFile);
            // file 폴더에 업로드
            realFileInsert =fileUploadSetting.insertFile(newFileName, fileReqDTO, "edocfile");
            if (fileInsertResult != 1 || realFileInsert != 1) {
                return -1;
                // throw new RuntimeException("데이터베이스 입력을 실패하였습니다.");
            }
         }
        
        // 공통으로 들어가는 전자결재 문서
        edocResult = edocProcessMapper.insertEdoc(edocRequestDTO);
        
        Integer edocNum = edocRequestDTO.getEdocNum();
        edocRequestDTO.setEdocNum(edocNum);
        edocFormTypeDTO.setEdocNum(edocNum);
        
        String[] approvers = edocRequestDTO.getApprover();
        String[] apprOrders = edocRequestDTO.getApprOrder();
        
        Map<String, Object> edocMap = new HashMap<>();
        
        for(int i = 0; i < approvers.length; i++) {
            if(approvers[i] != null && !approvers[i].equals("")) {
                edocMap.put("edocNum", edocNum);
                edocMap.put("approver", approvers[i]);
                edocMap.put("apprOrder", apprOrders[i]);
                log.debug(TeamColor.YELLOW + "1차 결재:" + edocMap + TeamColor.RESET);
                
                // 공통으로 들어가는 결재선
                approvalResult = edocProcessMapper.insertApprover(edocMap);
            } else {
                edocMap.put("edocNum", edocNum);
                edocMap.put("approver", approvers[i]);
                edocMap.put("apprOrder", apprOrders[i]);
                log.debug(TeamColor.YELLOW + "1,2차 결재:" + edocMap + TeamColor.RESET);
                
                // 공통으로 들어가는 결재선
                approvalResult = edocProcessMapper.insertApprover(edocMap);
            }
        }
        
        String edocType = edocFormTypeDTO.getEdocType();
        
        if(edocType.equals("0")){
            insertEdocForm = edocProcessMapper.insertEdocDraft(edocFormTypeDTO);
        }else if(edocType.equals("1")){
            insertEdocForm = edocProcessMapper.insertEdocVacation(edocFormTypeDTO);
        }else if(edocType.equals("2")){
            insertEdocForm = edocProcessMapper.insertEdocProject(edocFormTypeDTO);
        }else if(edocType.equals("3")){
            insertEdocForm = edocProcessMapper.insertEdocEvent(edocFormTypeDTO);
        }else if(edocType.equals("4")){
            insertEdocForm = edocProcessMapper.insertEdocReport(edocFormTypeDTO);
        }
        
        if(edocResult != 1 || insertEdocForm != 1) {
            throw new RuntimeException("전자결재 입력을 실패했습니다.");
        }
        
        return 1;
    }
    
    /*
     * @author : 조인환
     * @since : 2024. 07. 19.
     * Description : 결재 상태 승인,반려 처리
     */ 
    public int updateEdocProcess(String empCode,String edocNum,String apprReason, int request) {
        
        String requestEnum =  String.valueOf(request);
        
        Map<String,Object>map = new HashMap<>();
        map.put("empCode", empCode);
        map.put("edocNum", edocNum);
        map.put("apprReason", apprReason);
        map.put("request", requestEnum);
        
        if(request < 0) {
            map.put("apprStatus", "-1" );
        }else if(request > 0){
            map.put("apprStatus", "1" );
        }
        
        // 남아있는 결재자 수를 확인
        int checkApprovalCnt = edocProcessMapper.checkApprovalCnt(edocNum);
        
        if(checkApprovalCnt == 1) {   // 최종결재자라면
           map.put("last", -1 );
        }

        int resultEdocUpdate = edocProcessMapper.updateEdocStatus(map);
        
        int resultApprovalUpdate = edocProcessMapper.updateEdocApprovalStatus(map); // 결재선테이블
        
        // 변경이 되지 않았으면
        if(resultEdocUpdate != 1 || resultApprovalUpdate != 1) {
            return -1;
        }
        
        return 1;
    }
    
    
    
}
