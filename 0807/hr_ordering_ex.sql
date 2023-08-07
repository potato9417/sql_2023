DESC EMPLOYEES;

-- 사원 아이디가 200 이상인 사원들의 모든 정보를 아이디를 중심으로 오름차순 정렬하여 출력
SELECT * FROM EMPLOYEES
    WHERE EMPLOYEE_ID >= 200
    ORDER BY EMPLOYEE_ID;

-- 사원 아이디가 200 이상인 사원들의 모든 정보를 아이디를 중심으로 내림차순 정렬하여 출력
SELECT * FROM EMPLOYEES
    WHERE EMPLOYEE_ID >= 200
    ORDER BY EMPLOYEE_ID DESC;

-- 사원 아이디가 200 이상인 사원들의 모든 정보를 첫 이름(함자)을 중심으로 오름차순 정렬하여 출력
SELECT * FROM EMPLOYEES
    WHERE EMPLOYEE_ID >= 200
    ORDER BY FIRST_NAME;

-- 사원 아이디가 200 이상인 사원들의 모든 정보를 이름과 급여를 기준으로 오름차순 정렬하여 출력
SELECT * FROM EMPLOYEES
    WHERE EMPLOYEE_ID >= 200
    ORDER BY FIRST_NAME, SALARY;

-- 관리자 아이디, 이름, 급여 정보를 관리자 아이디와 급여를 기준으로 오름차순으로 정렬하여 출력
SELECT MANAGER_ID, FIRST_NAME ||' '|| LAST_NAME, SALARY FROM EMPLOYEES
    ORDER BY MANAGER_ID, SALARY;