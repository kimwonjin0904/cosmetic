ALTER SESSION SET "_ORACLE_SCRIPT" = true;
CREATE USER jdbc IDENTIFIED BY jdbc;
GRANT CONNECT, RESOURCE TO jdbc;
GRANT UNLIMITED TABLESPACE TO jdbc;


--회원정보--
CREATE TABLE MEMBERS (
    mem_id       VARCHAR2(50)    PRIMARY KEY,  -- 회원 ID (기본 키)
    mem_pw       VARCHAR2(1000)  NOT NULL,     -- 회원 비밀번호
    mem_nm       VARCHAR2(100),                -- 회원 이름
    mem_addr     VARCHAR2(1000),               -- 회원 주소
    profile_img  VARCHAR2(1000),               -- 프로필 이미지 URL 또는 경로
    use_yn       VARCHAR2(1)    DEFAULT 'Y',   -- 사용 여부 (Y 또는 N)
    update_dt    DATE           DEFAULT SYSDATE, -- 정보 수정일
    create_dt    DATE           DEFAULT SYSDATE  -- 정보 생성일
                                                 --생년월일 
);

COMMENT ON COLUMN members.mem_id IS '회원 ID (기본 키)';
COMMENT ON COLUMN members.mem_pw IS '회원 비밀번호';
COMMENT ON COLUMN members.mem_nm IS '회원 이름';
COMMENT ON COLUMN members.mem_addr IS '회원 주소';
COMMENT ON COLUMN members.profile_img IS '프로필 이미지 URL 또는 경로';
COMMENT ON COLUMN members.use_yn IS '사용 여부 (Y 또는 N)';
COMMENT ON COLUMN members.update_dt IS '정보 수정일';
COMMENT ON COLUMN members.create_dt IS '정보 생성일';

--아이디 몇개 있는지 검색--


INSERT INTO members (mem_id,mem_pw, mem_nm)
VALUES('a001','1234','닉');
commit;


--해당아디비번찾는쿼리--
SELECT   mem_id
        ,mem_pw
        ,mem_nm
FROM members
WHERE use_yn = 'Y'
AND mem_id = 'nick'
AND mem_pw='1234';

-----member.xml
SELECT   mem_id
        ,mem_pw
        ,mem_nm
        ,profile_img
FROM members
WHERE use_yn = 'Y'
AND mem_id = 'nick'
AND mem_pw='1234';


------boards ------------
CREATE TABLE boards (
    board_no       NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    board_title    VARCHAR2(1000),                                  
    mem_id         VARCHAR2(100) NOT NULL,                            
    board_content  VARCHAR2(2000),                                   
    create_dt      DATE DEFAULT SYSDATE,                             
    update_dt      DATE DEFAULT SYSDATE,                             
    use_yn         VARCHAR2(1) DEFAULT 'Y',                          
    CONSTRAINT fk_boards_members FOREIGN KEY (mem_id) REFERENCES members(mem_id)
);



select *
from free_board;



--------
UPDATE boards 
SET board_category = '자유게시판'
WHERE board_category IS NULL;

-----------
UPDATE boards SET board_category = '기본카테고리' WHERE board_category IS NULL;
COMMIT;

--------------
ALTER TABLE boards ADD board_category VARCHAR2(50);
---
commit;
--------board검색------------------
SELECT a.board_no,
       a.board_title,
       b.mem_id,
       b.mem_nm,
       a.board_category,
       TO_CHAR(a.update_dt,'YYYY/MM/DD HH24:MI:SS') as update_dt
FROM boards a
JOIN members b ON a.mem_id = b.mem_id
WHERE a.use_yn = 'Y'
    -- 검색어 필터링
    AND (
        ('T' = :searchType AND a.board_title LIKE '%' || :searchWord || '%') OR
        ('W' = :searchType AND b.mem_nm LIKE '%' || :searchWord || '%') OR
        ('C' = :searchType AND a.board_content LIKE '%' || :searchWord || '%') OR
        (:searchType IS NULL OR :searchType = '')
    )
    -- 카테고리 필터링
    AND (a.board_category = :searchCategory OR :searchCategory IS NULL OR :searchCategory = '')
ORDER BY a.update_dt DESC;



--자유게시판 카테고리 설정(여드름 모낭염 피부좋은날추가)--
SELECT * FROM comm_code
where comm_parent = 'BC00';

INSERT INTO comm_code (comm_cd, comm_parent, comm_nm) 
VALUES ('BC05', 'BC00', '여드름');

INSERT INTO comm_code (comm_cd, comm_parent, comm_nm) 
VALUES ('BC06', 'BC00', '모나염');

INSERT INTO comm_code (comm_cd, comm_parent, comm_nm) 
VALUES ('BC07', 'BC00', '피부좋은날');

---------




--카테고리추가
CREATE TABLE free_board (
    bo_no         NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
    bo_title      VARCHAR2(250) NOT NULL, 
    bo_category   VARCHAR2(4),
    bo_writer     VARCHAR2(100) NOT NULL, 
    bo_pass       VARCHAR2(60) NOT NULL, 
    bo_content    CLOB, 
    bo_ip         VARCHAR2(30), 
    bo_hit        NUMBER DEFAULT 0, 
    bo_reg_date   DATE DEFAULT SYSDATE, 
    bo_mod_date   DATE DEFAULT SYSDATE, 
    bo_del_yn     CHAR(1) DEFAULT 'N'
);



--replys 테이블의 스키마 정보--
CREATE TABLE replys (
    reply_no       NUMBER(10),              PRIMARY KEY (board_no, reply_no),                         
    board_no       NUMBER(10) NOT NULL,                          
    mem_id         VARCHAR2(100) NOT NULL,                      
    reply_content  VARCHAR2(1000),                              
    reply_date     DATE DEFAULT SYSDATE,                        
    del_yn         VARCHAR2(1) DEFAULT 'N',                                              
    CONSTRAINT fk_replys_boards FOREIGN KEY (board_no) REFERENCES boards(board_no) ON DELETE CASCADE,
    CONSTRAINT fk_replys_members FOREIGN KEY (mem_id) REFERENCES members(mem_id) ON DELETE CASCADE
);

--내가만든거 삭제 2개
DROP TABLE replys CASCADE CONSTRAINTS PURGE;
DROP TABLE boards CASCADE CONSTRAINTS PURGE;






----선생님꺼------
 -- 사용자 게시판 
CREATE TABLE boards (
    board_no NUMBER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1 NOCACHE), -- 1씩 증가 (NOCACHE 설정)
    board_title VARCHAR2(1000),
    mem_id VARCHAR2(100) NOT NULL,
    board_content VARCHAR2(2000),
    create_dt DATE DEFAULT SYSDATE,
    update_dt DATE DEFAULT SYSDATE,
    use_yn VARCHAR2(1) DEFAULT 'Y',
    PRIMARY KEY (board_no), -- PRIMARY KEY 지정
    CONSTRAINT fk_member FOREIGN KEY(mem_id) REFERENCES members(mem_id) -- FOREIGN KEY 직접 적용
);


-- 댓글 테이블
CREATE TABLE replys (
    reply_no NUMBER, -- 자동 증가 없음, 직접 값 입력 필요
    board_no NUMBER(10),
    mem_id VARCHAR2(100),
    reply_content VARCHAR2(1000),
    reply_date DATE DEFAULT SYSDATE,
    del_yn VARCHAR2(1) DEFAULT 'N',
    PRIMARY KEY (board_no, reply_no),
    CONSTRAINT fk_mem_id FOREIGN KEY (mem_id) REFERENCES members(mem_id) ON DELETE CASCADE, -- 회원 삭제 시 관련 댓글도 삭제
    CONSTRAINT fk_board_no FOREIGN KEY (board_no) REFERENCES boards(board_no) ON DELETE CASCADE -- 게시글 삭제 시 관련 댓글도 삭제
);
commit;
---
select *
from boards;


--테스트--
INSERT INTO boards (board_title, mem_id, board_content)
VALUES  ('test2','nick','내용입니다.');




--?--
SELECT a.board_no
     , a.board_title
     , b.mem_id
     , b.mem_nm
     , TO_CHAR(a.update_dt,'YYYY/MM/DD HH24:MI:SS') as update_dt
FROM boards a
    ,members b
WHERE a.mem_id = b.mem_id
AND   a.use_yn = 'Y'
ORDER BY a.update_dt DESC;


----상세조회
SELECT a.board_no
     , a.board_title
     , a.board_content
     , b.mem_id
     , b.mem_nm
     , TO_CHAR(a.update_dt,'YYYY/MM/DD HH24:MI:SS') as update_dt
FROM boards a
    ,members b
WHERE a.mem_id = b.mem_id
AND   a.use_yn = 'Y'
AND   a.board_no = '4';




select * from boards;


--updateboard수정(게시판)--
UPDATE boards
SET board_title = 'test'
,board_content='내용입니다.수정'
,update_dt = SYSDATE
WHERE board_no='1'
AND mem_id ='nick';


--댓글 저장
INSERT INTO replys (board_no,reply_no, mem_id, reply_content)
VALUES('1','12345','nick','댓글 테스트');
INSERT INTO replys (board_no,reply_no, mem_id, reply_content)
VALUES('62','123456','a001','댓글 테스트22');
INSERT INTO replys (board_no,reply_no, mem_id, reply_content)
VALUES('62','12345','judy','댓글 테스트');

--댓글 1건 조회
    SELECT a.reply_no
        ,a.board_no
        ,b.mem_id
        ,b.mem_nm
        ,a.reply_content
        ,TO_CHAR(a.reply_date,'MM/DD HH24:MI') as reply_date
    FROM replys a, members b
    WHERE a.mem_id = b.mem_id
    AND a.del_yn = 'N'
    AND a.reply_no = '12345';
--댓글 여러건 조회
SELECT a.reply_no
    ,a.board_no
    ,b.mem_id
    ,b.mem_nm
    ,a.reply_content
    ,TO_CHAR(a.reply_date,'MM/DD HH24:MI') as reply_date
FROM replys a, members b
WHERE a.mem_id = b.mem_id
AND a.del_yn = 'N'
AND a.board_no = '1'
ORDER BY reply_date DESC;


--삭제--
UPDATE replys
SET del_yn = 'Y'
WHERE reply_no = '250321141600846';

select * from replys;

select *
from replys
where board_no = 3

select *
from members;

commit;

select *
from free_board;
-----------------------------------
SELECT *
FROM(
SELECT rownum as rnum
    ,a.*
FROM (SELECT a.bo_no
            ,a.bo_title
            ,a.bo_category
            ,b.comm_nm as bo_category_nm
            ,a.bo_writer
            ,a.bo_pass
            ,a.bo_content
            ,a.bo_ip
            ,a.bo_hit
            ,a.bo_del_yn
            ,TO_CHAR(a.bo_reg_date,'YYYY-MM-DD') as bo_reg_date
            ,TO_CHAR(a.bo_mod_date,'YYYY-MM-DD') as bo_mod_date
      FROM free_board a
           ,comm_code b
        WHERE a.bo_category = b.comm_cd
        AND   a.bo_title  LIKE '%%'
        ORDER BY bo_no DESC
        ) a
    )b
WHERE rnum BETWEEN 11 AND 20;

commit;
----
desc free_board;
INSERT INTO free_board(bo_title, bo_category, bo_writer, bo_pass, bo_content)
VALUES()





--이미지저장 확인
select * 
from free_board;

--------------------------
select bo_no
,bo_title
,bo_category
,b.comm_nm as bo_category_nm
,bo_writer
,bo_content
,bo_hit
,bo_mod_date
from free_board a
   , comm_code b
    where a.bo_category = b.comm_cd
    and a.bo_no = 24
    and a.bo_del_yn = 'N' ;

--조회수
UPDATE free_board
 SET   bo_hit = bo_hit + 1
WHERE  bo_no = 24;
--화면출력을위한 쿼리






/* 채팅 
rooms  테이블의 스키마 정보를 정리한 테이블입니다.				
컬럼명	데이터 타입	기본값	제약 조건	설명
room_no	NUMBER	없음	PRIMARY KEY	방 번호 (기본 키)
room_name	VARCHAR2(1000)	없음		방 이름
mem_id	VARCHAR2(50)	없음	FOREIGN KEY (members 테이블의 mem_id 참조)	방 생성자 ID
reg_date	DATE	SYSDATE	없음	방 생성 날짜
del_yn	VARCHAR2(1)	N'	없음	삭제 여부 (기본값 'N')
*/				
CREATE TABLE rooms (
    room_no     NUMBER PRIMARY KEY,                      -- 방 번호 (기본 키)
    room_name   VARCHAR2(1000),                          -- 방 이름
    mem_id      VARCHAR2(50),                            -- 방 생성자 ID
    reg_date    DATE DEFAULT SYSDATE,                    -- 방 생성 날짜 (기본값 SYSDATE)
    del_yn      VARCHAR2(1) DEFAULT 'N',                 -- 삭제 여부 (기본값 'N')
    CONSTRAINT fk_rooms_mem_id FOREIGN KEY (mem_id) REFERENCES members(mem_id)  -- 외래 키 제약 조건 (고유 이름)
    --            room_fk
);
CREATE SEQUENCE room_seq
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;


select *
from rooms;

/* 채팅
chatlog 테이블의 스키마 정보를 정리한 테이블입니다.				
컬럼명	데이터 타입	기본값	제약 조건	설명
chat_no	NUMBER	없음	PRIMARY KEY	채팅 메시지 번호 (기본 키)
 room_no	NUMBER	없음	FOREIGN KEY (rooms 테이블의 room_no 참조)	채팅이 속한 방 번호
 mem_id	VARCHAR2(50)	없음	FOREIGN KEY (members 테이블의 mem_id 참조)	채팅을 보낸 회원 ID
chat_msg	VARCHAR2(4000)	없음		채팅 메시지 내용
send_date	DATE	SYSDATE		채팅 전송 시간 (기본값: 현재 시각)*/
CREATE TABLE chatlog (
    chat_no     NUMBER PRIMARY KEY,                     -- 채팅 메시지 번호 (기본 키)
    room_no     NUMBER,                                 -- 채팅이 속한 방 번호
    mem_id      VARCHAR2(50),                            -- 채팅을 보낸 회원 ID
    chat_msg    VARCHAR2(4000),                          -- 채팅 메시지 내용
    send_date   DATE DEFAULT SYSDATE,                    -- 채팅 전송 시간 (기본값 SYSDATE)
    CONSTRAINT fk_chatlog_room_no FOREIGN KEY (room_no) REFERENCES rooms(room_no),  -- 외래 키 (rooms 테이블의 room_no 참조)
    CONSTRAINT fk_chatlog_mem_id FOREIGN KEY (mem_id) REFERENCES members(mem_id)  -- 외래 키 (members 테이블의 mem_id 참조)
                    --chat_mem_fk
                    --chat_room_fk
);

CREATE SEQUENCE chat_seq
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;

--방생성
INSERT INTO rooms(room_no, room_name, mem_id)
VALUES(room_seq.NEXTVAL, '방 테스트','nick');
--방 리스트(room.vo)
SELECT a.room_no
    ,a.room_name
    ,b.mem_id
    ,b.mem_nm
    ,a.reg_date
FROM rooms a, members b
WHERE a.mem_id = b.mem_id
AND a.del_yn = 'N'
ORDER BY a.reg_date DESC;
--채팅내용 저장
INSERT INTO chatlog(chat_no, room_no ,mem_id, chat_msg)
VALUES(chat_seq.NEXTVAL, '1','cyj','안녕^^');          --있는아이디로
--채팅 내용(chatVO)
SELECT a.chat_no
    ,b.mem_id
    ,b.mem_nm
    ,a.room_no
    ,a.chat_msg
    ,NVL(b.profile_img,'/assets/img/non.png') as profile_img
    ,TO_CHAR(a.send_date,'RR/MM/DD HH24:MI') as send_date
FROM chatlog a, members b
WHERE a.mem_id = b.mem_id
AND a.room_no = '1'
ORDER BY chat_no;




select *
from chatlog;
commit;

--------------덤프파일디렉토리 생성(dba 권한 필요 system계정) 및 권한 부여--------
CREATE OR REPLACE DIRECTORY dump_sql AS 'c:/dev/sql';
GRANT READ, WRITE ON DIRECTORY dump_sql TO jdbc;

--import 명령어(cmd실행)--
--impdp jdbc/jdbc DIRECTORY= dump_sql DUMPFILE=JDBC_MOVIE.DMP
--export 명령(계정 전체)
--expdp system/oracle@xe schemas=jdbc DIRECTORY=dump_sql dump DUMPFILE=spring_jdbc.dmp(덤프파일 원하는 명)
expdp system/oracle@xe schemas=jdbc DIRECTORY=dump_sql DUMPFILE=spring_jdbc.dmp 

--export 특정 테이블
expdp jdbc/jdbc DIRECTORY=dump_sql DUMPFILE=jdbc_dir.dmp TABLES=movie_box_office


-----------spring chart.jsp-----------------
select DISTINCT movie_nm, open_dt
from movie_box_office
ORDER BY open_dt desc,movie_nm;


select movie_nm
from movie_box_office
group by movie_nm
order by max(open_dt) desc, movie_nm;


select to_char(target_dt,'YYYY-MM-DD') as target_dt
,sales_acc
,audi_acc
from movie_box_office
where movie_nm = '승부'
order by target_dt;

-----------------일정 테이블 달력---------------------------
CREATE TABLE CALENDAR (
    cal_no NUMBER
    ,cal_title VARCHAR2(100)
    ,cal_start VARCHAR2(50)
    ,cal_end   VARCHAR2(50)
    ,cal_bg_color VARCHAR2(50)
    ,cal_text_color VARCHAR2(50)
    ,mem_id VARCHAR2(50)
    ,user_yn VARCHAR2(1) DEFAULT 'Y'
    ,constraint fk_mem_cal FOREIGN KEY(mem_id) REFERENCES members(mem_id)
);

CREATE SEQUENCE calendar_seq
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;


INSERT INTO calendar (cal_no, cal_title, cal_start, cal_bg_color, mem_id)
VALUES (calendar_seq.nextval, 'test1', '2025-04-02', 'blue', 'nick');

INSERT INTO calendar (cal_no, cal_title, cal_start, cal_bg_color, mem_id)
VALUES (calendar_seq.nextval, 'test2', '2025-04-03', 'yellow', 'nick');

SELECT a.cal_no
      ,a.cal_title
      ,a.cal_start
      ,a.cal_end
      ,a.cal_bg_color
FROM calendar a, members b
WHERE a.mem_id = b.mem_id
AND a.mem_id = 'nick'
AND a.user_yn = 'Y';  -- 오타 수정




--------------- 자유게시판-----------------------------
select *
from free_board;











