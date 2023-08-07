-- 모든 항목 출력 => SELECT
SELECT * FROM EMPLOYEES;

-- 조건이 붙은 모든 항목 출력 => SELECT WHERE
SELECT * FROM EMPLOYEES
    WHERE FIRST_NAME = 'Steven';
    
-- 테이블 항목 현황 조회 => DESC
DESC EMPLOYEES;

-- 문자열 합쳐서 출력 => || (+연산자와 같은 의미)
SELECT FIRST_NAME ||' '|| LAST_NAME FROM EMPLOYEES
    WHERE FIRST_NAME = 'Steven';
    
-- 별칭(alias)를 첨가하여 출력 => AS(생략가능)
SELECT FIRST_NAME ||' '|| LAST_NAME AS "이름" FROM EMPLOYEES
    WHERE FIRST_NAME = 'Steven';

SELECT SALARY+10000 "10000달러 인상분" FROM EMPLOYEES
    WHERE FIRST_NAME = 'Steven';
    
-- 테이블에서 중복제거하여 항목 출력 => DISTINCT
SELECT DISTINCT FIRST_NAME FROM EMPLOYEES;

-- 조건문안에 연산자 사용
SELECT FIRST_NAME ||' '|| LAST_NAME "이름" FROM EMPLOYEES
    WHERE EMPLOYEE_ID > 150;
    
-- 조건문안에 연산자 사용 => AND / OR 
SELECT FIRST_NAME ||' '|| LAST_NAME "이름" FROM EMPLOYEES
    WHERE EMPLOYEE_ID >= 150 AND EMPLOYEE_ID <= 170;

-- 문자열의 패턴 일치 검색(유사검색 : 포함만 되어있으면 OK) => LIKE (% : 모든 문자 / _ : 한글자)
SELECT FIRST_NAME ||' '|| LAST_NAME "이름" FROM EMPLOYEES
    WHERE FIRST_NAME LIKE 'D%';

-- 오류 발생 => 동일검색(무조건적으로 같아야함)
SELECT FIRST_NAME ||' '|| LAST_NAME "이름" FROM EMPLOYEES
    WHERE FIRST_NAME = 'D%';

-- 이상/이하범위 값 => BETWEEN A AND B
SELECT EMAIL AS "이메일" FROM EMPLOYEES
    WHERE EMPLOYEE_ID BETWEEN 150 AND 170;
