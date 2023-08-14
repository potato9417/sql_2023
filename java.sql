set serveroutput on;

declare
    v_year CHAR(4);
    v_month CHAR(2);
    v_date CHAR(2);   
    temp_birthday CHAR(10);    
    temp_month NUMBER(2);
    temp_date NUMBER(2);
begin

    FOR i IN 1..100 LOOP
    
        v_year := TO_CHAR(round(DBMS_RANDOM.VALUE(1900,2022),0));
        
        temp_month := round(DBMS_RANDOM.VALUE(1,12),0);
        temp_date := round(DBMS_RANDOM.VALUE(1,31),0);
        
        IF temp_month < 10 THEN
            v_month := '0' || TO_CHAR(temp_month); 
        ELSE
            v_month := TO_CHAR(temp_month); 
        END IF;
            
        IF temp_date < 10 THEN
            v_date :=  '0' || TO_CHAR(temp_date);
        ELSE 
            v_date := TO_CHAR(temp_date);
        END IF;    
        
        temp_birthday := TRIM(v_year || '-' || v_month || '-' || v_date);
            
        DBMS_OUTPUT.put_line(temp_birthday);        
        
        UPDATE member_tbl SET birthday = TO_DATE(temp_birthday)    
        WHERE id = 'ezen' || (1000+i);
        
        COMMIT;
          
    END LOOP;

end;
/

ALTER TABLE MEMBER_TBL MODIFY BIRTHDAY CHAR(20);


-- ȸ�� ���� ���̺� ȸ����(�̸�)/���� ����ȭ

-- ����)
-- ������ ��(random) : 1 => 'm', 2 => 'f'
/*
select round(DBMS_RANDOM.VALUE(1,2),0) from dual;  
select decode((select round(DBMS_RANDOM.VALUE(1,2),0) from dual), 1, 'm', 2, 'f') from dual;  
*/


CREATE OR REPLACE PROCEDURE name_update_gen_proc  
IS  
      TYPE first_name_array      IS VARRAY(20) OF CLOB;  
      TYPE middle_name_array      IS VARRAY(12) OF CLOB;  
      TYPE last_name_array      IS VARRAY(12) OF CLOB;  
      first_names   first_name_array;  
      middle_names   middle_name_array;  
      last_names   last_name_array;        
      v_firstName CLOB;  
      v_middleName CLOB;  
      v_lastName CLOB;  
      totalName CLOB;  
      temp_num NUMBER(2); 
      temp_random_gender NUMBER(1);
      temp_gender CHAR(1);
BEGIN  
      first_names := first_name_array('��','��','��','��','��','��','��','��','����','����','Ȳ','Ȳ��','��','��','��','��','��','��','��','��');  
      middle_names := middle_name_array('��','��','��','��','��','��','��','��','��','��','��','��');  
      last_names := last_name_array('��','��','��','��','��','��','��','��','��','��','ö','��');  
       
      FOR i IN 1..100 LOOP  
         
        temp_num := round(DBMS_RANDOM.VALUE(1,20),0);  
        v_firstName :=  first_names(temp_num);  
        temp_num := round(DBMS_RANDOM.VALUE(1,12),0);  
        v_middleName :=  middle_names(temp_num);  
        temp_num := round(DBMS_RANDOM.VALUE(1,12),0);  
        v_lastName :=  last_names(temp_num);  
        totalName := v_firstName || v_middleName || v_lastName;  
                         
        UPDATE member_tbl SET name = totalName  
        WHERE id = 'ezen' || (1000+i);
        
        -- ���� random ����
        temp_random_gender := round(DBMS_RANDOM.VALUE(1,2),0);
        
        select decode(temp_random_gender, 1, 'm', 2, 'f') into temp_gender from dual;  
        
        UPDATE member_tbl SET gender = temp_gender
        WHERE id = 'ezen' || (1000+i); 
        
    END LOOP;  

    COMMIT;         
  END;  
/  
 
EXECUTE name_update_gen_proc;


-- ȸ�� ���� ���̺� �����ȣ/�ּ� ���� ����ȭ

-- 08291
-- ����Ư���� ���α� ������9�� 45 (���ε�, �ŵ����������Ʈ) 
-- ����Ư���� ���α� ���ε� 560 �ŵ����������Ʈ
-- ���ּ� ���� : 101~103�� 1~19�� ex) 1901ȣ

-- 08288
-- ����Ư���� ���α� ������ 93 (���ε�, �ŵ����¿�Ÿ��)
-- ����Ư���� ���α� ���ε� 1267 �ŵ����¿�Ÿ��
-- ���ּ� ���� : 101~113�� 1~16�� ex) 1601ȣ

-- 07376
-- ����Ư���� �������� ���ŷ� 31 (�븲��, ����3������Ʈ)
-- ����Ư���� �������� �븲�� 608-1 ����3������Ʈ
-- ���ּ� ���� : 301~307�� 1~30�� ex) 2801ȣ

-- 08208 
-- ����Ư���� ���α� ���η�65�� 16-15 (�ŵ�����, �ŵ���4�� e-���Ѽ���)
-- ����Ư���� ���α� �ŵ����� 646 �ŵ���4�� e-���Ѽ���
-- ���ּ� ���� : 1101~1115�� 1~25�� ex) 2501ȣ

set SERVEROUTPUT ON

----------------------------------------------------

DECLARE
   
    TYPE apt_address_record IS RECORD (
        zip_code CHAR(5),
        road_address NVARCHAR2(200),
        jibun_address NVARCHAR2(200),
        detail_address NVARCHAR2(200)
    );
    
    TYPE apt_address_tbl IS TABLE OF apt_address_record;
    
    apt_addresses apt_address_tbl;
    
    temp_num NUMBER(1);
    
    temp_detail_address NVARCHAR2(200);
    
    temp_dong NVARCHAR2(5);
    
    temp_ho NVARCHAR2(5);
    
    FUNCTION apt_address_record_constructor (
            zip_code CHAR,
            road_address NVARCHAR2,
            jibun_address NVARCHAR2,
            detail_address NVARCHAR2
        ) RETURN apt_address_record IS
        apt apt_address_record;
    BEGIN
        apt.zip_code := zip_code;
        apt.road_address := road_address;
        apt.jibun_address := jibun_address;
        apt.detail_address := detail_address;
        RETURN apt;
    END apt_address_record_constructor;          
 
BEGIN  
      
      apt_addresses := apt_address_tbl(
    
            apt_address_record_constructor('08291',
                    '����Ư���� ���α� ������9�� 45 (���ε�, �ŵ����������Ʈ)',
                    '����Ư���� ���α� ���ε� 560 �ŵ����������Ʈ',
                    ''),
            apt_address_record_constructor('08288',
                    '����Ư���� ���α� ������ 93 (���ε�, �ŵ����¿�Ÿ��)',
                    '����Ư���� ���α� ���ε� 1267 �ŵ����¿�Ÿ��',
                    ''),
            apt_address_record_constructor('07376',
                    '����Ư���� �������� ���ŷ� 31 (�븲��, ����3������Ʈ)',
                    '����Ư���� �������� �븲�� 608-1 ����3������Ʈ',
                    ''),
            apt_address_record_constructor('08208',        
                    '����Ư���� ���α� ���η�65�� 16-15 (�ŵ�����, �ŵ���4�� e-���Ѽ���)',
                    '����Ư���� ���α� �ŵ����� 646 �ŵ���4�� e-���Ѽ���',
                    '')
      );      
      
 FOR i IN 1..100 LOOP  
         
        temp_num := round(DBMS_RANDOM.VALUE(1,4),0);  
        DBMS_OUTPUT.put_line('temp_num : ' ||  temp_num);
        
        -- �� �ּ� ����(random) ����
        /*
            -- 1�� :
            -- 08291
            -- ����Ư���� ���α� ������9�� 45 (���ε�, �ŵ����������Ʈ) 
            -- ����Ư���� ���α� ���ε� 560 �ŵ����������Ʈ
            -- ���ּ� ���� : 101~103�� 1~19�� ex) 1901ȣ
            
            -- 2�� :
            -- 08288
            -- ����Ư���� ���α� ������ 93 (���ε�, �ŵ����¿�Ÿ��)
            -- ����Ư���� ���α� ���ε� 1267 �ŵ����¿�Ÿ��
            -- ���ּ� ���� : 101~113�� 1~16�� ex) 1601ȣ
            
            -- 3�� :
            -- 07376
            -- ����Ư���� �������� ���ŷ� 31 (�븲��, ����3������Ʈ)
            -- ����Ư���� �������� �븲�� 608-1 ����3������Ʈ
            -- ���ּ� ���� : 301~307�� 1~30�� ex) 2801ȣ
            
            -- 4�� :
            -- 08208 
            -- ����Ư���� ���α� ���η�65�� 16-15 (�ŵ�����, �ŵ���4�� e-���Ѽ���)
            -- ����Ư���� ���α� �ŵ����� 646 �ŵ���4�� e-���Ѽ���
            -- ���ּ� ���� : 1101~1115�� 1~25�� ex) 2501ȣ
        
           ex) 
           select round(DBMS_RANDOM.VALUE(10,19),0) || 
           round(DBMS_RANDOM.VALUE(0,1),0) || 
           round(DBMS_RANDOM.VALUE(1,9),0) || '��'
           from dual;
        */
            IF temp_num = 1 THEN           
                              
                -- ���ּ� ���� : 101~103�� 1~19�� ex) 1901ȣ                
                temp_dong := round(DBMS_RANDOM.VALUE(101,103),0) || '��';
                 
                temp_ho := round(DBMS_RANDOM.VALUE(10,19),0) || 
                           round(DBMS_RANDOM.VALUE(0,1),0) || 
                           round(DBMS_RANDOM.VALUE(1,9),0) || 'ȣ';    
                               
             ELSIF temp_num = 3 THEN
                -- ���ּ� ���� : 101~113�� 1~16�� ex) 1601ȣ
                temp_dong := round(DBMS_RANDOM.VALUE(101,113),0) || '��';
                
                temp_ho := round(DBMS_RANDOM.VALUE(10,16),0) || 
                           round(DBMS_RANDOM.VALUE(0,1),0) || 
                           round(DBMS_RANDOM.VALUE(1,9),0) || 'ȣ';    
                
             ELSIF temp_num = 3 THEN
                    -- ���ּ� ���� : 301~307�� 1~30�� ex) 2801ȣ                
                    temp_dong := round(DBMS_RANDOM.VALUE(301,307),0) || '��';
                    
                    temp_ho := round(DBMS_RANDOM.VALUE(10,30),0) || 
                               round(DBMS_RANDOM.VALUE(0,1),0) || 
                               round(DBMS_RANDOM.VALUE(1,9),0) || 'ȣ';    
                
             ELSE
                    -- ���ּ� ���� : 1101~1115�� 1~25�� ex) 2501ȣ                
                    temp_dong := round(DBMS_RANDOM.VALUE(1101,1115),0) || '��';
                    
                    temp_ho := round(DBMS_RANDOM.VALUE(10,25),0) || 
                               round(DBMS_RANDOM.VALUE(0,1),0) || 
                               round(DBMS_RANDOM.VALUE(1,9),0) || 'ȣ';    
            END IF;           
        
            DBMS_OUTPUT.put_line(apt_addresses(temp_num).zip_code);
            DBMS_OUTPUT.put_line(apt_addresses(temp_num).road_address);
            DBMS_OUTPUT.put_line(apt_addresses(temp_num).jibun_address);
        
            -- ���ּ�
            temp_detail_address := temp_dong || ' ' || temp_ho;            
            DBMS_OUTPUT.put_line('�� �ּ� : ' || temp_detail_address);
            
            -- �ּ� ��Ȳ ������Ʈ(����)
            UPDATE member_tbl SET 
            zip = apt_addresses(temp_num).zip_code,
            address1 = apt_addresses(temp_num).road_address || '*' || temp_detail_address,
            address2 = apt_addresses(temp_num).jibun_address || '*' || temp_detail_address
            WHERE id = 'ezen' || (1000+i);
        
      END LOOP;  

  COMMIT;         
END;  
/  


SELECT *  
FROM (SELECT m.*,  
             FLOOR((ROWNUM - 1) / 10 + 1) page  
      FROM (
             SELECT *
			 FROM member_tbl
             ORDER BY id DESC
           ) m  
      )  
WHERE page = 1;
