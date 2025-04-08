ALTER SESSION SET "_ORACLE_SCRIPT" = true;
CREATE USER kwj IDENTIFIED BY kwj;
GRANT CONNECT, RESOURCE TO kwj;
GRANT UNLIMITED TABLESPACE TO kwj;

commit;


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
                                 -----boards (ȸ���Խ���)------------
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
--�����Խ��� ī�װ� ����(���帧 �𳶿� �Ǻ��������߰�)--
--=======================================
SELECT * FROM comm_code
where comm_parent = 'BC00';

SELECT * FROM comm_code
where comm_nm = '���帧';


select *
from free_board;
where bo_category = 'BC06';


INSERT INTO comm_code (comm_cd, comm_parent, comm_nm) 
VALUES ('BC05', 'BC00', '���帧');

INSERT INTO comm_code (comm_cd, comm_parent, comm_nm) 
VALUES ('BC06', 'BC00', '�𳪿�');
commit;

UPDATE comm_code
SET comm_nm = '�𳶿�'
WHERE comm_nm = '�𳪿�' AND comm_cd = 'BC06';

INSERT INTO comm_code (comm_cd, comm_parent, comm_nm) 
VALUES ('BC07', 'BC00', '�Ǻ�������');

--=============================================
--�����Խ���(�Ǻα��)-
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

--�����Խ��� ����--
--free.xml (����)����
UPDATE free_board
SET bo_title = 's',
    bo_category = 'BC06',
    bo_writer = 's',
    bo_content = '��',
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
,board_content='�����Դϴ�.����'
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


--===========�ۼ�����================
CREATE TABLE review (
    review_no NUMBER PRIMARY KEY,         -- ���� ��ȣ
    member_id VARCHAR2(50) NOT NULL,      -- ȸ�� ID
    product_name VARCHAR2(200) NOT NULL,  -- ��ǰ��
    content CLOB,                         -- ���� ����
    rating NUMBER(2) NOT NULL,            -- ���� (1~10 ���)
    reg_date DATE DEFAULT SYSDATE         -- �ۼ���
);

select *
from review;
 
CREATE SEQUENCE review_seq
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;


INSERT INTO review (review_no, member_id, product_name, content, rating, reg_date) 
VALUES (review_seq.NEXTVAL, 'user01', '����', '�����ϰ� ����', 5, SYSDATE);

CREATE SEQUENCE review_seq START WITH 1 INCREMENT BY 1;


DESC review;

