CREATE TABLE MEMBERTBL(
    -- MEMBER_ID CHAR(8) NOT NULL PRIMARY KEY,
    -- 기본키는 NOTNULL이므로 빼도 상관없음
    MEMBER_ID CHAR(8) PRIMARY KEY,
    MEMBER_NAME NCHAR(5) NOT NULL,
    MEMBER_ADDRESS NVARCHAR2(20)
);

DROP TABLE MEMBERTBL;

