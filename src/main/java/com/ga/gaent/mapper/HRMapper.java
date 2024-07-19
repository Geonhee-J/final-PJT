package com.ga.gaent.mapper;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import com.ga.gaent.vo.EmpVO;
import com.ga.gaent.vo.TeamVO;

@Mapper
public interface HRMapper {
    
    /*
     * @author : 김형호
     * @since : 2024. 07. 00.
     * Description : 조직도 정보
     */
    public List<Map<String, Object>> selectTreeInfo();
    
    /*
     * @author : 정건희
     * @since : 2024. 07. 19.
     * Description : 직원 리스트 조회
     */
    public List<Map<String, Object>> selectEmpList(Map<String, Object> hrMap);
    
    /*
     * @author : 정건희
     * @since : 2024. 07. 19.
     * Description : 직원 상세 조회
     */
    public int selectEmpDetail(String empCode);
    
    /*
     * @author : 정건희
     * @since : 2024. 07. 19.
     * Description : 직원 등록
     */
    public int insertEmp();
    
    /*
     * @author : 정건희
     * @since : 2024. 07. 19.
     * Description : 직원 수정
     */
    public int updateEmp();
    
    /*
     * @author : 정건희
     * @since : 2024. 07. 19.
     * Description : 직원 삭제
     */
    public int deleteEmp();
    
    /*
     * @author : 김형호
     * @since : 2024. 07. 00.
     * Description : 부서 등록
     */
    public int insertTeam(TeamVO team);
    
    /*
     * @author : 김형호
     * @since : 2024. 07. 00.
     * Description : 부서 수정
     */
    public int updateTeam(TeamVO team);
    
    /*
     * @author : 김형호
     * @since : 2024. 07. 00.
     * Description : 부서 삭제
     */
    public int deleteTeam(int teamCode);
    
    /*
     * @author : 김형호
     * @since : 2024. 07. 00.
     * Description : 부서 리스트 조회
     */
    public List<TeamVO> selectTeamList(Map<String, Integer> map);
    
    /*
     * @author : 김형호
     * @since : 2024. 07. 00.
     * Description : 부서 리스트 카운트
     */
    public int selectTeamCount();
    
    /*
     * @author : 김형호
     * @since : 2024. 07. 00.
     * Description : 부서 등록 부서코드 유효성 체크
     */
    public int checkTeamCode(String teamCode);
}
