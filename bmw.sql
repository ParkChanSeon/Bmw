
CREATE DATABASE BMW;

USE BMW;

drop table member;
select*from member;


CREATE TABLE MEMBER(
member_id varchar(50) not null primary key,
member_pw varchar(20) not null,
member_name varchar(30) not null,
member_birth date not null,
member_gender varchar(10) not null,
member_phone varchar(15) not null,
member_image varchar(300) null,
member_regDate datetime not null,
AUTHORITY varchar(50) NOT NULL DEFAULT 'ROLE_USER',
ENABLED tinyint(1) unsigned zerofill DEFAULT '1',
FAILURE_CNT int not null DEFAULT 0
);




ALTER TABLE MEMBER_INFO ADD CONSTRAINT FK_MEMBER_INFO_member_id FOREIGN KEY(member_id)
			REFERENCES MEMBER (member_id) ON DELETE CASCADE ON UPDATE CASCADE;


drop table team;

CREATE TABLE TEAM (
team_code varchar(20) not null primary key,
team_name varchar(15) ,
man varchar(10) ,
woman varchar(10) ,
result varchar(30) null,
team_date datetime 
);

call p_save_team ('찬선혜진','찬선','혜진');

select * from team;

drop procedure p_save_team;
/* =================================================================================================================
================================================== 팀 저장 프로시저 ==================================================
===================================================== 18.11.14 =====================================================
================================================================================================================= */
DELIMITER $$
CREATE PROCEDURE p_save_team ( IN T_Team_name	VARCHAR(15)		-- 팀 명
							  , IN T_man		VARCHAR(10)		-- 남자
                              , IN T_woman		VARCHAR(10)		-- 여자
                              )
                              BEGIN
    
    DECLARE NB1		INT(5);			-- 고유번호 저장 변수1
    DECLARE NB2		CHAR(20);		-- 고유번호 저장 변수2
    
    DECLARE SCOUNT	INT	DEFAULT 0;	-- 가게 카운터
    
    
    /* 오늘 날짜의 가게 데이터 카운트 */
    SELECT COUNT(team_code) INTO SCOUNT
      FROM TEAM
	 WHERE SUBSTRING(team_code, 2, 6) = DATE_FORMAT(NOW(), '%y%m%d');
    
    
    IF SCOUNT > 0 THEN
    
		/* 오늘 날짜의 가장 최근의 가게 고유번호 변수에 저장 */
		SELECT RIGHT(team_code, 3) + 0 INTO NB1
		  FROM team
		 WHERE SUBSTRING(team_code, 2, 6) = DATE_FORMAT(NOW(), '%y%m%d')
		 ORDER BY team_code DESC LIMIT 1;

		/* 번호 + 1 및 문자로 형변환 */
		SET NB2 = CONVERT(NB1 + 1, CHAR(20));
        
	ELSE
		/* 오늘 날짜의 가게 데이터가 없을 경우 1부터 시작 */
        SET NB2 = CONVERT('1', CHAR(20));
    
    END IF;
    
    
    /* 5자리가 될 때 까지 앞자리에 '0' 붙여주기 */
	LOOP_NB:LOOP
    
		/* 5자리가 되었을 때 루프문 종료 */
		IF LENGTH(NB2) >= 3 THEN
			SET NB2 = CONCAT(CONCAT('T', CONVERT(DATE_FORMAT(NOW(), '%y%m%d'), CHAR(20))), NB2);
			LEAVE LOOP_NB;
		END IF;
        
        SET NB2 = CONCAT('0', NB2);
        
	END LOOP;
    
    
    /* 저장 */
    INSERT INTO team
    VALUES (
			NB2				
		,	T_Team_name        
        ,	T_man       	
        ,	T_woman
        ,   NULL
        ,	NOW()
        
    );
    
    COMMIT;
    
END $$

DELIMITER ;




CREATE TABLE GAME_RESULT (
game_id int auto_increment not null primary key,
team_code01 varchar(20) not null,
team_code02 varchar(20) not null,
score varchar(15) not null default '0:0',
game_date datetime not null
);

select * from game_result;


/* =================================================================================================================
================================================== 게임결과 프로시저 ==================================================
===================================================== 18.11.14 =====================================================
================================================================================================================= */
DELIMITER $$
CREATE PROCEDURE p_save_game ( IN T_Team_name	VARCHAR(15)		-- 팀 명
							  , IN T_man		VARCHAR(10)		-- 남자
                              , IN T_woman		VARCHAR(10)		-- 여자
                              )
                              BEGIN
    
    DECLARE NB1		INT(5);			-- 고유번호 저장 변수1
    DECLARE NB2		CHAR(20);		-- 고유번호 저장 변수2
    
    DECLARE SCOUNT	INT	DEFAULT 0;	-- 가게 카운터
    
    
    /* 오늘 날짜의 가게 데이터 카운트 */
    SELECT COUNT(team_code) INTO SCOUNT
      FROM TEAM
	 WHERE SUBSTRING(team_code, 2, 6) = DATE_FORMAT(NOW(), '%y%m%d');
    
    
    IF SCOUNT > 0 THEN
    
		/* 오늘 날짜의 가장 최근의 가게 고유번호 변수에 저장 */
		SELECT RIGHT(team_code, 3) + 0 INTO NB1
		  FROM team
		 WHERE SUBSTRING(team_code, 2, 6) = DATE_FORMAT(NOW(), '%y%m%d')
		 ORDER BY team_code DESC LIMIT 1;

		/* 번호 + 1 및 문자로 형변환 */
		SET NB2 = CONVERT(NB1 + 1, CHAR(20));
        
	ELSE
		/* 오늘 날짜의 가게 데이터가 없을 경우 1부터 시작 */
        SET NB2 = CONVERT('1', CHAR(20));
    
    END IF;
    
    
    /* 5자리가 될 때 까지 앞자리에 '0' 붙여주기 */
	LOOP_NB:LOOP
    
		/* 5자리가 되었을 때 루프문 종료 */
		IF LENGTH(NB2) >= 3 THEN
			SET NB2 = CONCAT(CONCAT('T', CONVERT(DATE_FORMAT(NOW(), '%y%m%d'), CHAR(20))), NB2);
			LEAVE LOOP_NB;
		END IF;
        
        SET NB2 = CONCAT('0', NB2);
        
	END LOOP;
    
    
    /* 저장 */
    INSERT INTO team
    VALUES (
			NB2				
		,	T_Team_name        
        ,	T_man       	
        ,	T_woman
        ,   NULL
        ,	NOW()
        
    );
    
    COMMIT;
    
END $$

DELIMITER ;



