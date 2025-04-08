ALTER SESSION SET "_ORACLE_SCRIPT" = true;
CREATE USER kwj IDENTIFIED BY kwj;
GRANT CONNECT, RESOURCE TO kwj;
GRANT UNLIMITED TABLESPACE TO kwj;

commit;


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
    
select *
from members;

-----member.xml---
SELECT   mem_id
        ,mem_pw
        ,mem_nm
        ,profile_img
FROM members
WHERE use_yn = 'Y'
AND mem_id = 'nick'
AND mem_pw='1234';

--============================================================================
                                 -----boards (회원게시판)------------
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


ALTER TABLE boards ADD use_yn CHAR(1) DEFAULT 'Y';



--==========================================
--자유게시판 카테고리 설정(여드름 모낭염 피부좋은날추가)--
--=======================================
SELECT * FROM comm_code
where comm_parent = 'BC00';

SELECT * FROM comm_code
where comm_nm = '여드름';


select *
from free_board;
where bo_category = 'BC06';


INSERT INTO comm_code (comm_cd, comm_parent, comm_nm) 
VALUES ('BC05', 'BC00', '여드름');

INSERT INTO comm_code (comm_cd, comm_parent, comm_nm) 
VALUES ('BC06', 'BC00', '모나염');
commit;

UPDATE comm_code
SET comm_nm = '모낭염'
WHERE comm_nm = '모나염' AND comm_cd = 'BC06';

INSERT INTO comm_code (comm_cd, comm_parent, comm_nm) 
VALUES ('BC07', 'BC00', '피부좋은날');

--=============================================
--자유게시판(피부기록)-
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

--자유게시판 수정--
--free.xml (수정)쿼리
UPDATE free_board
SET bo_title = 's',
    bo_category = 'BC06',
    bo_writer = 's',
    bo_content = 'ㄴ',
    bo_mod_date = SYSDATE
WHERE bo_no = 23;
commit;

select *
from free_board;

ALTER TABLE free_board MODIFY bo_pass VARCHAR2(255) NULL;

commit;
select *
from boards;
---
UPDATE boards
SET board_title = 'test'
,board_content='내용입니다.수정'
,update_dt = SYSDATE
WHERE board_no='1'
AND mem_id ='nick';

UPDATE free_board
SET bo_title = :boTitle,
    bo_category = :boCategory,
    bo_writer = :boWriter,
    bo_pass = :boPass,
    bo_content = :boContent,
    bo_mod_date = SYSDATE
WHERE bo_no = :boNo


--===========작성리뷰================
CREATE TABLE review (
    review_no NUMBER PRIMARY KEY,         -- 리뷰 번호
    member_id VARCHAR2(50) NOT NULL,      -- 회원 ID
    product_name VARCHAR2(200) NOT NULL,  -- 제품명
    content CLOB,                         -- 리뷰 내용
    rating NUMBER(2) NOT NULL,            -- 평점 (1~10 등등)
    reg_date DATE DEFAULT SYSDATE         -- 작성일
);

select *
from review;
 
CREATE SEQUENCE review_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;


INSERT INTO review (review_no, member_id, product_name, content, rating, reg_date) 
VALUES (review_seq.NEXTVAL, 'user01', '세럼', '촉촉하고 좋음', 5, SYSDATE);

CREATE SEQUENCE review_seq START WITH 1 INCREMENT BY 1;


DESC review;

