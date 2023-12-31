SELECT EMPNO, ENAME, JOB, SAL,
    DECODE(JOB, 'ANALYST', SAL*1.1, 'CLERK', SAL*1.15, 'MANAGER', SAL*1.2, SAL) D_SAL
    FROM EMP
    ORDER BY SAL DESC;
    
SELECT DEPTNO, COUNT(*), AVG(SAL), MIN(SAL), MAX(SAL)
    FROM EMP
    GROUP BY DEPTNO;
    
SELECT DEPTNO, COUNT(*) COUNT, ROUND(AVG(SAL),1) AVG, MIN(SAL) MIN, MAX(SAL) MAX, SUM(SAL) AS "�޿��� ��"
    FROM EMP
    GROUP BY DEPTNO
    ORDER BY SUM(SAL) DESC;