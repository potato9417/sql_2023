-- ���̺��� ���ǿ� �´� �׸� ���
SELECT EMPNO, ENAME, JOB, SAL, HIREDATE, DEPTNO FROM EMP
    WHERE HIREDATE >= '82-01-01';
    
-- ��ȯ�Լ� ����Ͽ� ��� => TO_CHAR(��¥�� ���ڸ� ���ڷ� ��ȯ) /  TO_DATE(���ڸ� ��¥�� ��ȯ)
SELECT EMPNO, ENAME, JOB, SAL, HIREDATE, DEPTNO FROM EMP
    WHERE HIREDATE >= TO_CHAR(TO_DATE('01-JAN-82', 'dd-Month-YY', 'NLS_DATE_LANGUAGE = American'));
    
-- Ư������ �������ִ��� Ȯ���Ͽ� ��� => IN(WHERE�� �Բ� ���)
SELECT EMPNO, ENAME, JOB, SAL, HIREDATE FROM EMP
    WHERE EMPNO IN(7902,7788,7566);
    
-- ���ǿ� �´� ���� ��� => LIKE(����˻�)
SELECT EMPNO, ENAME, JOB, SAL, HIREDATE, DEPTNO FROM EMP
    WHERE HIREDATE LIKE '82%';
    
-- ���ǹ� => IS NULL(NULL�� ��)
SELECT EMPNO, ENAME, JOB, SAL, COMM, DEPTNO FROM EMP
    WHERE COMM IS NULL;

-- ���ǹ�(������ ��� �����ؾ��� ���) => AND
SELECT EMPNO, ENAME, JOB, SAL, HIREDATE, DEPTNO FROM EMP
    WHERE SAL >= 1100 AND JOB = 'MANAGER';
    
-- ���ǹ�(������ �ϳ��� �����ص��Ǵ� ���) => OR
SELECT EMPNO, ENAME, JOB, SAL, HIREDATE, DEPTNO FROM EMP
    WHERE SAL >= 1100 OR JOB = 'MANAGER';
    
-- ���ǹ�(��������) => NOT IN(~����)
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO FROM EMP
    WHERE JOB NOT IN('MANAGER', 'CLERK', 'ANALYST');

-- ���ǹ� Ȱ�� => ���ǹ� ���� �߿�(AND�� OR���� �켱���� ���Ƽ� AND�� �����а� OR�� ���߿�)
SELECT EMPNO, ENAME, JOB, SAL FROM EMP
    WHERE JOB = 'PRESIDENT' OR SAL >= 1500 AND JOB = 'SALESMAN';

-- ���ǹ� Ȱ�� => ()�� ����Ͽ� �켱���� ��ȭ�� ��
SELECT EMPNO, ENAME, JOB, SAL FROM EMP
    WHERE (JOB = 'SALESMAN' OR JOB = 'PRESIDENT') AND SAL >= 1500;

-- �����ϱ� => ORDER BY(�⺻�� ASC : ��������)
SELECT EMPNO, ENAME, JOB, SAL, HIREDATE, DEPTNO FROM EMP
    ORDER BY HIREDATE;
    
-- �����ϱ� => ORDER BY(DESC : ��������) 
SELECT EMPNO, ENAME, JOB, SAL, HIREDATE, DEPTNO FROM EMP
    ORDER BY HIREDATE DESC;
    
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO FROM EMP
    ORDER BY SAL DESC;
    
-- ������������ �����ϱ� => ODER BY(�켱������� �Է�)
SELECT EMPNO, ENAME, JOB, SAL, DEPTNO FROM EMP
    ORDER BY DEPTNO DESC, JOB, SAL DESC;
    