-- ��� �׸� ��� => SELECT
SELECT * FROM EMPLOYEES;

-- ������ ���� ��� �׸� ��� => SELECT WHERE
SELECT * FROM EMPLOYEES
    WHERE FIRST_NAME = 'Steven';
    
-- ���̺� �׸� ��Ȳ ��ȸ => DESC
DESC EMPLOYEES;

-- ���ڿ� ���ļ� ��� => || (+�����ڿ� ���� �ǹ�)
SELECT FIRST_NAME ||' '|| LAST_NAME FROM EMPLOYEES
    WHERE FIRST_NAME = 'Steven';
    
-- ��Ī(alias)�� ÷���Ͽ� ��� => AS(��������)
SELECT FIRST_NAME ||' '|| LAST_NAME AS "�̸�" FROM EMPLOYEES
    WHERE FIRST_NAME = 'Steven';

SELECT SALARY+10000 "10000�޷� �λ��" FROM EMPLOYEES
    WHERE FIRST_NAME = 'Steven';
    
-- ���̺��� �ߺ������Ͽ� �׸� ��� => DISTINCT
SELECT DISTINCT FIRST_NAME FROM EMPLOYEES;

-- ���ǹ��ȿ� ������ ���
SELECT FIRST_NAME ||' '|| LAST_NAME "�̸�" FROM EMPLOYEES
    WHERE EMPLOYEE_ID > 150;
    
-- ���ǹ��ȿ� ������ ��� => AND / OR 
SELECT FIRST_NAME ||' '|| LAST_NAME "�̸�" FROM EMPLOYEES
    WHERE EMPLOYEE_ID >= 150 AND EMPLOYEE_ID <= 170;

-- ���ڿ��� ���� ��ġ �˻�(����˻� : ���Ը� �Ǿ������� OK) => LIKE (% : ��� ���� / _ : �ѱ���)
SELECT FIRST_NAME ||' '|| LAST_NAME "�̸�" FROM EMPLOYEES
    WHERE FIRST_NAME LIKE 'D%';

-- ���� �߻� => ���ϰ˻�(������������ ���ƾ���)
SELECT FIRST_NAME ||' '|| LAST_NAME "�̸�" FROM EMPLOYEES
    WHERE FIRST_NAME = 'D%';

-- �̻�/���Ϲ��� �� => BETWEEN A AND B
SELECT EMAIL AS "�̸���" FROM EMPLOYEES
    WHERE EMPLOYEE_ID BETWEEN 150 AND 170;
