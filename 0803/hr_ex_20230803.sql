SELECT TABLE_NAME FROM USER_TABLES;

SELECT * FROM USER_TABLES;

DESC USER_TABLES;

SELECT STATUS FROM USER_TABLES;

SELECT OWNER, TABLE_NAME FROM ALL_TABLES;

-- DUAL : DUMMY 테이블 => 테이블과 관련없이 간단한 함수/수식테스트 할때 사용
SELECT CURRENT_DATE FROM DUAL;

-- 객체 안에 있는 모든 것의 테이블
SELECT * FROM USER_OBJECTS;