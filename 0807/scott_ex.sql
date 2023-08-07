-- 테이블에서 조건에 맞는 항목 출력
SELECT EMPNO, ENAME, JOB, SAL, HIREDATE, DEPTNO FROM EMP
    WHERE HIREDATE >= '82-01-01';
    
-- 변환함수 사용하여 출력 => TO_CHAR(날짜와 숫자를 문자로 변환) /  TO_DATE(숫자를 날짜로 변환)
SELECT EMPNO, ENAME, JOB, SAL, HIREDATE, DEPTNO FROM EMP
    WHERE HIREDATE >= TO_CHAR(TO_DATE('01-JAN-82', 'dd-Month-YY', 'NLS_DATE_LANGUAGE = American'));
    
-- 특정값을 가지고있는지 확인하여 출력 => IN(WHERE과 함께 사용)
SELECT EMPNO, ENAME, JOB, SAL, HIREDATE FROM EMP
    WHERE EMPNO IN(7902,7788,7566);
    
-- 조건에 맞는 정보 출력 => LIKE(유사검색)
SELECT EMPNO, ENAME, JOB, SAL, HIREDATE, DEPTNO FROM EMP
    WHERE HIREDATE LIKE '82%';
    
-- 조건문 => IS NULL(NULL인 값)
SELECT EMPNO, ENAME, JOB, SAL, COMM, DEPTNO FROM EMP
    WHERE COMM IS NULL;

-- 조건문(조건이 모두 부합해야할 경우) => AND
SELECT EMPNO, ENAME, JOB, SAL, HIREDATE, DEPTNO FROM EMP
    WHERE SAL >= 1100 AND JOB = 'MANAGER';
    
-- 조건문(조건이 하나만 부합해도되는 경우) => OR
SELECT EMPNO, ENAME, JOB, SAL, HIREDATE, DEPTNO FROM EMP
    WHERE SAL >= 1100 OR JOB = 'MANAGER';
    
-- 조건문(예외조건) => NOT IN(~빼고)
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO FROM EMP
    WHERE JOB NOT IN('MANAGER', 'CLERK', 'ANALYST');

-- 조건문 활용 => 조건문 순서 중요(AND가 OR보다 우선순위 높아서 AND를 먼저읽고 OR을 나중에)
SELECT EMPNO, ENAME, JOB, SAL FROM EMP
    WHERE JOB = 'PRESIDENT' OR SAL >= 1500 AND JOB = 'SALESMAN';

-- 조건문 활용 => ()를 사용하여 우선순위 변화를 줌
SELECT EMPNO, ENAME, JOB, SAL FROM EMP
    WHERE (JOB = 'SALESMAN' OR JOB = 'PRESIDENT') AND SAL >= 1500;

-- 정렬하기 => ORDER BY(기본값 ASC : 오름차순)
SELECT EMPNO, ENAME, JOB, SAL, HIREDATE, DEPTNO FROM EMP
    ORDER BY HIREDATE;
    
-- 정렬하기 => ORDER BY(DESC : 내림차순) 
SELECT EMPNO, ENAME, JOB, SAL, HIREDATE, DEPTNO FROM EMP
    ORDER BY HIREDATE DESC;
    
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO FROM EMP
    ORDER BY SAL DESC;
    
-- 여러조건으로 정렬하기 => ODER BY(우선순위대로 입력)
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO FROM EMP
    ORDER BY DEPTNO DESC, JOB, SAL DESC;
    