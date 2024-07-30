package com.ga.gaent.service;

import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;
import com.ga.gaent.mapper.CalendarMapper;
import com.ga.gaent.vo.CalendarVO;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class CalendarService {
    
    private final String yellow = "\u001B[33m";

    @Autowired
    CalendarMapper calendarMapper;
    
    // 일정등록
    public int insertEvent(CalendarVO calendar) {
        
        int addEvent = calendarMapper.insertEvent(calendar);
        
        if(addEvent == 1) {
            log.debug(yellow + "일정 등록 성공" + yellow);
        }else{
            log.debug(yellow + "일정 등록 실패" + yellow);
        }
        return addEvent;
    }
    
    // 전체 일정조회
    public List<Map<String, Object>> selectAllEvents(Map<String, Object> map) {

        List<Map<String, Object>> allEvents = calendarMapper.selectAllEvents(map);
        log.debug(yellow + "allEvents : " + allEvents + yellow);
        
        return allEvents;
    }
    
    // 개인 일정조회
    public List<Map<String, Object>> selectPersonalEvents(String empCode) {

        List<Map<String, Object>> personalEvents = calendarMapper.selectPersonalEvents(empCode);
        log.debug(yellow + "personalEvents : " + personalEvents + yellow);
        
        return personalEvents;
    }
    
    // 팀 일정조회
    public List<Map<String, Object>> selectTeamEvents(String teamCode) {

        List<Map<String, Object>> teamEvents = calendarMapper.selectTeamEvents(teamCode);
        log.debug(yellow + "teamEvents : " + teamEvents + yellow);
        
        return teamEvents;
    }
    
    // 전사 일정조회
    public List<Map<String, Object>> selectCompanyEvents() {

        List<Map<String, Object>> companyEvents = calendarMapper.selectCompanyEvents();
        log.debug(yellow + "companyEvents : " + companyEvents + yellow);
        
        return companyEvents;
    }
    
    // 전사 일정조회
    public List<Map<String, Object>> selectArtistEvents() {

        List<Map<String, Object>> artistEvents = calendarMapper.selectArtistEvents();
        log.debug(yellow + "artistEvents : " + artistEvents + yellow);
        
        return artistEvents;
    }
    
    // 일정상세
    public List<String> selectEventOne(int calNum){
        
        List<String> eventOne = calendarMapper.selectEventOne(calNum);
        
        return eventOne;
    }
    
    // 일정삭제
    public int deleteEvent(int calNum) {
        
        int deleteEvent = calendarMapper.deleteEvent(calNum);
        if(deleteEvent == 1) {
            log.debug("일정 삭제 성공");
        }else {
            log.debug("일정 삭제 실패");
        }
        return deleteEvent;
    }
    
    // 일정수정
    public int updateEvent(CalendarVO calendar) {
        
        int updateEvent = calendarMapper.updateEvent(calendar);
        if(updateEvent == 1) {
            log.debug("일정 수정 성공");
        }else {
            log.debug("일정 수정 실패");
        }
        return updateEvent;
    }
    
    // 일정타입 조회
    public List<Map<String, Object>> selectEventType(){
        
        List<Map<String, Object>> eventType = calendarMapper.selectEventType();
        log.debug(yellow + "eventType : " + eventType + yellow);
        
        return eventType;
    }
    
    // 일정분류 조회
    public List<Map<String, Object>> selectEventTarget(){
        
        List<Map<String, Object>> eventTarget = calendarMapper.selectEventTarget();
        log.debug(yellow + "eventTarget : " + eventTarget + yellow);
        
        return eventTarget;
    }
}
