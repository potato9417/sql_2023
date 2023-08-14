CREATE OR REPLACE PROCEDURE proc2 (v_empno IN NUMBER, Msg OUT VARCHAR2)
    IS -- ���� ���� �κ�
        v_avg_sal NUMBER;
        v_sal NUMBER;
        v_ename VARCHAR2(20);
        v_increase NUMBER;
        
    BEGIN -- PL/SQL ���α׷��� �ڵ�
        SELECT ename, sal INTO v_ename, v_sal
        FROM emp
		WHERE empno = v_empno;
		
		SELECT AVG(sal) INTO v_avg_sal
		FROM emp
        WHERE deptno = (
            SELECT deptno FROM emp
                WHERE empno = v_empno
        );
        
        IF v_sal > v_avg_sal THEN
            v_increase := 1.1;
        ELSE
            v_increase := 1.2;
        END IF;
        
        UPDATE emp SET sal = sal * v_increase
            WHERE empno = v_empno;
            
        -- ������ ������ ������� �Է�(OUT)
        Msg := v_ename ||'����� '||'������ '||v_increase||'�� ���� �λ����� '||v_sal*v_increase||'���� �λ�';
        
    END; -- ���ν��� ������
/
SET serveroutput on;

var msg varchar2(200);
EXECUTE proc2(7369, :msg); -- proc2�� �������(OUT)�� �ҷ��ö��� :�Է� �ʼ�
print msg;


----------------------------------------------------------------------


-- ��Ű�� pack01 ����
CREATE OR REPLACE PACKAGE pack01 AS
    -- TYPE cur_typ : Ŀ���� ������ Ÿ��(����)
    -- IS REF CURSOR : Ŀ���� ������ ������ REF CURSOR�� ����(����� ���� Ŀ��)
    TYPE cur_typ IS REF CURSOR;
    PROCEDURE sel_proc(v_cur OUT cur_typ, deptno_or_job IN varchar2);
    END pack01;
/
    
-- ��Ű������ ���ν��� ����
CREATE OR REPLACE PACKAGE BODY pack01 AS
    PROCEDURE sel_proc(v_cur OUT cur_typ, deptno_or_job IN varchar2)
        IS 
        
        BEGIN
        
            IF deptno_or_job = 'job' THEN
                -- Ŀ�� ����
                OPEN v_cur FOR
                    SELECT job, SUM(sal), ROUND(AVG(sal)), MAX(sal), MIN(sal)
                    FROM emp
                    GROUP BY job;
            ELSIF deptno_or_job = 'deptno' THEN
                -- Ŀ�� ����
                OPEN v_cur FOR
                    SELECT dname, SUM(e.sal), ROUND(AVG(e.sal)), MAX(e.sal), MIN(e.sal)
                    FROM emp e, dept d
                    WHERE e.deptno = d.deptno
                    GROUP BY d.dname;
            END IF;
            
        END sel_proc; -- ���ν��� ������
        
    END pack01; -- ��Ű�� ������
/

-- ��Ű�� ����
var cur_pack refcursor;
-- ��Ű���ȿ� �ִ� ���ν�������
EXECUTE pack01.sel_proc(:cur_pack, 'deptno');
print cur_pack;


----------------------------------------------------------------------


-- �Լ� ����
CREATE OR REPLACE FUNCTION func2 (v_empno IN NUMBER)
    RETURN varchar2
        IS
            v_avg_sal NUMBER;
            v_sal NUMBER;
            v_ename VARCHAR(20);
            v_increase NUMBER;
            v_return VARCHAR2(100);
        BEGIN
            SELECT ename, sal INTO v_ename, v_sal
            FROM emp
            WHERE empno = v_empno;
            
            SELECT AVG(sal) INTO v_avg_sal
            FROM emp
            WHERE deptno = (
                SELECT deptno FROM emp
                    WHERE empno = V_EMPNO
            );
            
            IF v_sal > v_avg_sal THEN
                v_increase := 1.1;
            else
                v_increase := 1.2;
            END IF;
            
        UPDATE emp SET sal = sal * v_increase
            WHERE empno = v_empno;
        
        v_return := v_ename ||'����� '||'������ '||v_increase||'�� ���� �λ����� '||v_sal*v_increase||'���� �λ�';
        
        RETURN v_return;
    END;
/
        
var msg2 VARCHAR2(100);
EXEC :msg2 := FUNC2(7369);
PRINT msg2;