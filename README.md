# GAEnt. 그룹웨어 시스템
## :computer: 개요
기간: 2024-06-27 ~ 2024-08-02 (약 6주)<br>
인원: 3명<br>
개요: 보편적으로 사용 가능한 범용적인 그룹웨어를 목표로 작업을 했습니다.<br>
역할: 프로젝트 팀장(프로젝트 일정 관리, 기획/설계 문서 작성, 컨벤션 설정 및 관리, 디자인 등)<br>
주요 기능: 홈(메인), 쪽지함, 캘린더, 근태관리, 조직도, 직원조회, 전자결재, 소통공간(게시판), 사내구매, 인사관리<br>
배포: http://52.78.123.74/gaent/login<br>
<br>
<br>

## :toolbox: 개발 환경
|구분|사용|
|---|---|
|언어|Java17, JavaScript, HTML/CSS|
|프레임워크|Spring Framework, MyBatis, Lombok|
|라이브러리|JSTL, jQuery, BootStrap5, Chart.js|
|API|FullCalendar, jsTree, Naver News API, Toss API, DAUM Postcode API|
|데이터베이스|MariaDB|
|서버|Apache Tomcat10|
|도구|STS4, Heidi SQL, Sequel Ace, Github Desktop, Notion, Figma|
|운영체제|Mac, Windows|
<br>
<br>

## :world_map: ERD
<img width="1680" alt="ERD" src="https://github.com/user-attachments/assets/fae141f4-3fbd-4cfb-a6b1-7d9db95d615b">
<br>
<br>

## :mag: 담당 기능
### 로그인, 홈(메인), 직원조회, 전자결재, 소통공간(게시판), 인사관리(직원), 마이페이지
<br>
<br>

## :camera: 구현 기능 소개
<img width="1680" alt="로그인" src="https://github.com/user-attachments/assets/529ce20c-9b3a-42ef-9d46-2187a691ffda"><br>
### 로그인: 
- 로그인, 아이디 찾기, 비밀번호 찾기(성공시 비밀번호 재설정으로 이동) 기능 구현<br>
<br>

<img width="1680" alt="메인페이지" src="https://github.com/user-attachments/assets/e050592f-5dfb-4380-8cd3-0b5f87e5a545"><br>
### 메인페이지: 
- 공통으로 사용하는 헤더, 사이드바 및 페이지 레이아웃 구성<br>
- 쪽지함, 공지사항 페이징을 비동기 통신으로 페이지 이동 없이 조회 가능<br>
<br>

<img width="1680" alt="직원조회" src="https://github.com/user-attachments/assets/f3b92260-e2af-4685-9a71-1634bbcaa5fb"><br>
### 직원조회:
- 직원 전체 리스트, 상세정보 출력과 이름으로 검색 기능 구현
<br>

<img width="1680" alt="전자결재, 새결재진행" src="https://github.com/user-attachments/assets/99294726-f34e-4bd4-839b-5a64785076a8"><br>
### 전자결재: 
- 전자결재 문서 작성 구조 설계<br>
- 드롭박스 선택시 비동기 통신으로 페이지 이동 없이 문서 양식 출력<br>
- 결재선 추가 기능 구현<br>
<br>

<img width="1680" alt="소통공간, 게시글작성" src="https://github.com/user-attachments/assets/14b6b115-0e3a-4d2c-aab2-3ef15ce72e6a"><br>
### 소통공간: 
- 게시글 작성은 별도의 페이지 이동 없이 모달 구현<br>
- 권한에 따라 공지사항, 자유게시판 카테고리 선택 가능<br>
<br>

<img width="1680" alt="인사관리, 직원등록" src="https://github.com/user-attachments/assets/829392cb-f505-4b79-8910-79ea130bb325"><br>
### 인사관리: 
- 직원 등록시 아이디 중복 검사 기능, 주소 입력시 우편번호 검색 기능 추가<br>
<br>

<img width="1680" alt="마이페이지" src="https://github.com/user-attachments/assets/b0ca713c-5c39-48ad-bea7-5f45c9e59eb4"><br>
### 마이페이지: 
- 프로필 이미지, 아아디, 비밀번호 등 개인정보 변경 가능<br>
<br>
<br>
