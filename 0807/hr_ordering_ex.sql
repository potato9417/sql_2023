DESC EMPLOYEES;

-- ��� ���̵� 200 �̻��� ������� ��� ������ ���̵� �߽����� �������� �����Ͽ� ���
SELECT * FROM EMPLOYEES
    WHERE EMPLOYEE_ID >= 200
    ORDER BY EMPLOYEE_ID;

-- ��� ���̵� 200 �̻��� ������� ��� ������ ���̵� �߽����� �������� �����Ͽ� ���
SELECT * FROM EMPLOYEES
    WHERE EMPLOYEE_ID >= 200
    ORDER BY EMPLOYEE_ID DESC;

-- ��� ���̵� 200 �̻��� ������� ��� ������ ù �̸�(����)�� �߽����� �������� �����Ͽ� ���
SELECT * FROM EMPLOYEES
    WHERE EMPLOYEE_ID >= 200
    ORDER BY FIRST_NAME;

-- ��� ���̵� 200 �̻��� ������� ��� ������ �̸��� �޿��� �������� �������� �����Ͽ� ���
SELECT * FROM EMPLOYEES
    WHERE EMPLOYEE_ID >= 200
    ORDER BY FIRST_NAME, SALARY;

-- ������ ���̵�, �̸�, �޿� ������ ������ ���̵�� �޿��� �������� ������������ �����Ͽ� ���
SELECT MANAGER_ID, FIRST_NAME ||' '|| LAST_NAME, SALARY FROM EMPLOYEES
    ORDER BY MANAGER_ID, SALARY;