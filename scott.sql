CREATE OR REPLACE PROCEDURE proc2 (v_empno IN NUMBER, Msg OUT VARCHAR2)
    IS -- 변수 선언 부분
        v_avg_sal NUMBER;
        v_sal NUMBER;
        v_ename VARCHAR2(20);
        v_increase NUMBER;
        
    BEGIN -- PL/SQL 프로그래밍 코딩
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
            
        -- 밖으로 내보낼 출력인자 입력(OUT)
        Msg := v_ename ||'사원의 '||'월급이 '||v_increase||'배 월급 인상으로 '||v_sal*v_increase||'으로 인상';
        
    END; -- 프로시저 마무리
/
SET serveroutput on;

var msg varchar2(200);
EXECUTE proc2(7369, :msg); -- proc2의 출력인자(OUT)를 불러올때는 :입력 필수
print msg;


----------------------------------------------------------------------


-- 패키지 pack01 생성
CREATE OR REPLACE PACKAGE pack01 AS
    -- TYPE cur_typ : 커서의 데이터 타입(변수)
    -- IS REF CURSOR : 커서의 데이터 유형을 REF CURSOR로 지정(사용자 정의 커서)
    TYPE cur_typ IS REF CURSOR;
    PROCEDURE sel_proc(v_cur OUT cur_typ, deptno_or_job IN varchar2);
    END pack01;
/
    
-- 패키지안의 프로시저 수정
CREATE OR REPLACE PACKAGE BODY pack01 AS
    PROCEDURE sel_proc(v_cur OUT cur_typ, deptno_or_job IN varchar2)
        IS 
        
        BEGIN
        
            IF deptno_or_job = 'job' THEN
                -- 커서 오픈
                OPEN v_cur FOR
                    SELECT job, SUM(sal), ROUND(AVG(sal)), MAX(sal), MIN(sal)
                    FROM emp
                    GROUP BY job;
            ELSIF deptno_or_job = 'deptno' THEN
                -- 커서 오픈
                OPEN v_cur FOR
                    SELECT dname, SUM(e.sal), ROUND(AVG(e.sal)), MAX(e.sal), MIN(e.sal)
                    FROM emp e, dept d
                    WHERE e.deptno = d.deptno
                    GROUP BY d.dname;
            END IF;
            
        END sel_proc; -- 프로시저 마무리
        
    END pack01; -- 패키지 마무리
/

-- 패키지 실행
var cur_pack refcursor;
-- 패키지안에 있는 프로시저실행
EXECUTE pack01.sel_proc(:cur_pack, 'deptno');
print cur_pack;


----------------------------------------------------------------------


-- 함수 생성
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
        
        v_return := v_ename ||'사원의 '||'월급이 '||v_increase||'배 월급 인상으로 '||v_sal*v_increase||'으로 인상';
        
        RETURN v_return;
    END;
/
        
var msg2 VARCHAR2(100);
EXEC :msg2 := FUNC2(7369);
PRINT msg2;