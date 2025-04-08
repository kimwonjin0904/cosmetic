ALTER SESSION SET "_ORACLE_SCRIPT" = true;
CREATE USER jdbc IDENTIFIED BY jdbc;
GRANT CONNECT, RESOURCE TO jdbc;
GRANT UNLIMITED TABLESPACE TO jdbc;


--ȸ������--
CREATE TABLE MEMBERS (
    mem_id       VARCHAR2(50)    PRIMARY KEY,  -- ȸ�� ID (�⺻ Ű)
    mem_pw       VARCHAR2(1000)  NOT NULL,     -- ȸ�� ��й�ȣ
    mem_nm       VARCHAR2(100),                -- ȸ�� �̸�
    mem_addr     VARCHAR2(1000),               -- ȸ�� �ּ�
    profile_img  VARCHAR2(1000),               -- ������ �̹��� URL �Ǵ� ���
    use_yn       VARCHAR2(1)    DEFAULT 'Y',   -- ��� ���� (Y �Ǵ� N)
    update_dt    DATE           DEFAULT SYSDATE, -- ���� ������
    create_dt    DATE           DEFAULT SYSDATE  -- ���� ������
                                                 --������� 
);

COMMENT ON COLUMN members.mem_id IS 'ȸ�� ID (�⺻ Ű)';
COMMENT ON COLUMN members.mem_pw IS 'ȸ�� ��й�ȣ';
COMMENT ON COLUMN members.mem_nm IS 'ȸ�� �̸�';
COMMENT ON COLUMN members.mem_addr IS 'ȸ�� �ּ�';
COMMENT ON COLUMN members.profile_img IS '������ �̹��� URL �Ǵ� ���';
COMMENT ON COLUMN members.use_yn IS '��� ���� (Y �Ǵ� N)';
COMMENT ON COLUMN members.update_dt IS '���� ������';
COMMENT ON COLUMN members.create_dt IS '���� ������';

--���̵� � �ִ��� �˻�--


INSERT INTO members (mem_id,mem_pw, mem_nm)
VALUES('a001','1234','��');
commit;


--�ش�Ƶ���ã������--
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
SET board_category = '�����Խ���'
WHERE board_category IS NULL;

-----------
UPDATE boards SET board_category = '�⺻ī�װ�' WHERE board_category IS NULL;
COMMIT;

--------------
ALTER TABLE boards ADD board_category VARCHAR2(50);
---
commit;
--------board�˻�------------------
SELECT a.board_no,
       a.board_title,
       b.mem_id,
       b.mem_nm,
       a.board_category,
       TO_CHAR(a.update_dt,'YYYY/MM/DD HH24:MI:SS') as update_dt
FROM boards a
JOIN members b ON a.mem_id = b.mem_id
WHERE a.use_yn = 'Y'
    -- �˻��� ���͸�
    AND (
        ('T' = :searchType AND a.board_title LIKE '%' || :searchWord || '%') OR
        ('W' = :searchType AND b.mem_nm LIKE '%' || :searchWord || '%') OR
        ('C' = :searchType AND a.board_content LIKE '%' || :searchWord || '%') OR
        (:searchType IS NULL OR :searchType = '')
    )
    -- ī�װ� ���͸�
    AND (a.board_category = :searchCategory OR :searchCategory IS NULL OR :searchCategory = '')
ORDER BY a.update_dt DESC;



--�����Խ��� ī�װ� ����(���帧 �𳶿� �Ǻ��������߰�)--
SELECT * FROM comm_code
where comm_parent = 'BC00';

INSERT INTO comm_code (comm_cd, comm_parent, comm_nm) 
VALUES ('BC05', 'BC00', '���帧');

INSERT INTO comm_code (comm_cd, comm_parent, comm_nm) 
VALUES ('BC06', 'BC00', '�𳪿�');

INSERT INTO comm_code (comm_cd, comm_parent, comm_nm) 
VALUES ('BC07', 'BC00', '�Ǻ�������');

---------




--ī�װ��߰�
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



--replys ���̺��� ��Ű�� ����--
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

--��������� ���� 2��
DROP TABLE replys CASCADE CONSTRAINTS PURGE;
DROP TABLE boards CASCADE CONSTRAINTS PURGE;






----�����Բ�------
 -- ����� �Խ��� 
CREATE TABLE boards (
    board_no NUMBER GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1 NOCACHE), -- 1�� ���� (NOCACHE ����)
    board_title VARCHAR2(1000),
    mem_id VARCHAR2(100) NOT NULL,
    board_content VARCHAR2(2000),
    create_dt DATE DEFAULT SYSDATE,
    update_dt DATE DEFAULT SYSDATE,
    use_yn VARCHAR2(1) DEFAULT 'Y',
    PRIMARY KEY (board_no), -- PRIMARY KEY ����
    CONSTRAINT fk_member FOREIGN KEY(mem_id) REFERENCES members(mem_id) -- FOREIGN KEY ���� ����
);


-- ��� ���̺�
CREATE TABLE replys (
    reply_no NUMBER, -- �ڵ� ���� ����, ���� �� �Է� �ʿ�
    board_no NUMBER(10),
    mem_id VARCHAR2(100),
    reply_content VARCHAR2(1000),
    reply_date DATE DEFAULT SYSDATE,
    del_yn VARCHAR2(1) DEFAULT 'N',
    PRIMARY KEY (board_no, reply_no),
    CONSTRAINT fk_mem_id FOREIGN KEY (mem_id) REFERENCES members(mem_id) ON DELETE CASCADE, -- ȸ�� ���� �� ���� ��۵� ����
    CONSTRAINT fk_board_no FOREIGN KEY (board_no) REFERENCES boards(board_no) ON DELETE CASCADE -- �Խñ� ���� �� ���� ��۵� ����
);
commit;
---
select *
from boards;


--�׽�Ʈ--
INSERT INTO boards (board_title, mem_id, board_content)
VALUES  ('test2','nick','�����Դϴ�.');




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


----����ȸ
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


--updateboard����(�Խ���)--
UPDATE boards
SET board_title = 'test'
,board_content='�����Դϴ�.����'
,update_dt = SYSDATE
WHERE board_no='1'
AND mem_id ='nick';


--��� ����
INSERT INTO replys (board_no,reply_no, mem_id, reply_content)
VALUES('1','12345','nick','��� �׽�Ʈ');
INSERT INTO replys (board_no,reply_no, mem_id, reply_content)
VALUES('62','123456','a001','��� �׽�Ʈ22');
INSERT INTO replys (board_no,reply_no, mem_id, reply_content)
VALUES('62','12345','judy','��� �׽�Ʈ');

--��� 1�� ��ȸ
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
--��� ������ ��ȸ
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


--����--
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





--�̹������� Ȯ��
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

--��ȸ��
UPDATE free_board
 SET   bo_hit = bo_hit + 1
WHERE  bo_no = 24;
--ȭ����������� ����






/* ä�� 
rooms  ���̺��� ��Ű�� ������ ������ ���̺��Դϴ�.				
�÷���	������ Ÿ��	�⺻��	���� ����	����
room_no	NUMBER	����	PRIMARY KEY	�� ��ȣ (�⺻ Ű)
room_name	VARCHAR2(1000)	����		�� �̸�
mem_id	VARCHAR2(50)	����	FOREIGN KEY (members ���̺��� mem_id ����)	�� ������ ID
reg_date	DATE	SYSDATE	����	�� ���� ��¥
del_yn	VARCHAR2(1)	N'	����	���� ���� (�⺻�� 'N')
*/				
CREATE TABLE rooms (
    room_no     NUMBER PRIMARY KEY,                      -- �� ��ȣ (�⺻ Ű)
    room_name   VARCHAR2(1000),                          -- �� �̸�
    mem_id      VARCHAR2(50),                            -- �� ������ ID
    reg_date    DATE DEFAULT SYSDATE,                    -- �� ���� ��¥ (�⺻�� SYSDATE)
    del_yn      VARCHAR2(1) DEFAULT 'N',                 -- ���� ���� (�⺻�� 'N')
    CONSTRAINT fk_rooms_mem_id FOREIGN KEY (mem_id) REFERENCES members(mem_id)  -- �ܷ� Ű ���� ���� (���� �̸�)
    --            room_fk
);
CREATE SEQUENCE room_seq
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;


select *
from rooms;

/* ä��
chatlog ���̺��� ��Ű�� ������ ������ ���̺��Դϴ�.				
�÷���	������ Ÿ��	�⺻��	���� ����	����
chat_no	NUMBER	����	PRIMARY KEY	ä�� �޽��� ��ȣ (�⺻ Ű)
 room_no	NUMBER	����	FOREIGN KEY (rooms ���̺��� room_no ����)	ä���� ���� �� ��ȣ
 mem_id	VARCHAR2(50)	����	FOREIGN KEY (members ���̺��� mem_id ����)	ä���� ���� ȸ�� ID
chat_msg	VARCHAR2(4000)	����		ä�� �޽��� ����
send_date	DATE	SYSDATE		ä�� ���� �ð� (�⺻��: ���� �ð�)*/
CREATE TABLE chatlog (
    chat_no     NUMBER PRIMARY KEY,                     -- ä�� �޽��� ��ȣ (�⺻ Ű)
    room_no     NUMBER,                                 -- ä���� ���� �� ��ȣ
    mem_id      VARCHAR2(50),                            -- ä���� ���� ȸ�� ID
    chat_msg    VARCHAR2(4000),                          -- ä�� �޽��� ����
    send_date   DATE DEFAULT SYSDATE,                    -- ä�� ���� �ð� (�⺻�� SYSDATE)
    CONSTRAINT fk_chatlog_room_no FOREIGN KEY (room_no) REFERENCES rooms(room_no),  -- �ܷ� Ű (rooms ���̺��� room_no ����)
    CONSTRAINT fk_chatlog_mem_id FOREIGN KEY (mem_id) REFERENCES members(mem_id)  -- �ܷ� Ű (members ���̺��� mem_id ����)
                    --chat_mem_fk
                    --chat_room_fk
);

CREATE SEQUENCE chat_seq
INCREMENT BY 1
START WITH 1
NOCACHE
NOCYCLE;

--�����
INSERT INTO rooms(room_no, room_name, mem_id)
VALUES(room_seq.NEXTVAL, '�� �׽�Ʈ','nick');
--�� ����Ʈ(room.vo)
SELECT a.room_no
    ,a.room_name
    ,b.mem_id
    ,b.mem_nm
    ,a.reg_date
FROM rooms a, members b
WHERE a.mem_id = b.mem_id
AND a.del_yn = 'N'
ORDER BY a.reg_date DESC;
--ä�ó��� ����
INSERT INTO chatlog(chat_no, room_no ,mem_id, chat_msg)
VALUES(chat_seq.NEXTVAL, '1','cyj','�ȳ�^^');          --�ִ¾��̵��
--ä�� ����(chatVO)
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

--------------�������ϵ��丮 ����(dba ���� �ʿ� system����) �� ���� �ο�--------
CREATE OR REPLACE DIRECTORY dump_sql AS 'c:/dev/sql';
GRANT READ, WRITE ON DIRECTORY dump_sql TO jdbc;

--import ��ɾ�(cmd����)--
--impdp jdbc/jdbc DIRECTORY= dump_sql DUMPFILE=JDBC_MOVIE.DMP
--export ���(���� ��ü)
--expdp system/oracle@xe schemas=jdbc DIRECTORY=dump_sql dump DUMPFILE=spring_jdbc.dmp(�������� ���ϴ� ��)
expdp system/oracle@xe schemas=jdbc DIRECTORY=dump_sql DUMPFILE=spring_jdbc.dmp 

--export Ư�� ���̺�
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
where movie_nm = '�º�'
order by target_dt;

-----------------���� ���̺� �޷�---------------------------
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
AND a.user_yn = 'Y';  -- ��Ÿ ����




--------------- �����Խ���-----------------------------
select *
from free_board;











