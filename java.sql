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


-- 회원 정보 테이블 회원명(이름)/성별 현실화

-- 참고)
-- 임의의 수(random) : 1 => 'm', 2 => 'f'
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
      first_names := first_name_array('김','이','박','최','주','임','엄','성','남궁','독고','황','황보','송','오','유','류','윤','장','정','추');  
      middle_names := middle_name_array('숙','갑','영','순','선','원','우','이','운','성','정','희');  
      last_names := last_name_array('영','수','희','빈','민','정','순','주','연','영','철','석');  
       
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
        
        -- 성별 random 적용
        temp_random_gender := round(DBMS_RANDOM.VALUE(1,2),0);
        
        select decode(temp_random_gender, 1, 'm', 2, 'f') into temp_gender from dual;  
        
        UPDATE member_tbl SET gender = temp_gender
        WHERE id = 'ezen' || (1000+i); 
        
    END LOOP;  

    COMMIT;         
  END;  
/  
 
EXECUTE name_update_gen_proc;


-- 회원 정보 테이블 우편번호/주소 정보 현실화

-- 08291
-- 서울특별시 구로구 새말로9길 45 (구로동, 신도림현대아파트) 
-- 서울특별시 구로구 구로동 560 신도림현대아파트
-- 상세주소 범위 : 101~103동 1~19층 ex) 1901호

-- 08288
-- 서울특별시 구로구 새말로 93 (구로동, 신도림태영타운)
-- 서울특별시 구로구 구로동 1267 신도림태영타운
-- 상세주소 범위 : 101~113동 1~16층 ex) 1601호

-- 07376
-- 서울특별시 영등포구 도신로 31 (대림동, 현대3차아파트)
-- 서울특별시 영등포구 대림동 608-1 현대3차아파트
-- 상세주소 범위 : 301~307동 1~30층 ex) 2801호

-- 08208 
-- 서울특별시 구로구 경인로65길 16-15 (신도림동, 신도림4차 e-편한세상)
-- 서울특별시 구로구 신도림동 646 신도림4차 e-편한세상
-- 상세주소 범위 : 1101~1115동 1~25층 ex) 2501호

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
                    '서울특별시 구로구 새말로9길 45 (구로동, 신도림현대아파트)',
                    '서울특별시 구로구 구로동 560 신도림현대아파트',
                    ''),
            apt_address_record_constructor('08288',
                    '서울특별시 구로구 새말로 93 (구로동, 신도림태영타운)',
                    '서울특별시 구로구 구로동 1267 신도림태영타운',
                    ''),
            apt_address_record_constructor('07376',
                    '서울특별시 영등포구 도신로 31 (대림동, 현대3차아파트)',
                    '서울특별시 영등포구 대림동 608-1 현대3차아파트',
                    ''),
            apt_address_record_constructor('08208',        
                    '서울특별시 구로구 경인로65길 16-15 (신도림동, 신도림4차 e-편한세상)',
                    '서울특별시 구로구 신도림동 646 신도림4차 e-편한세상',
                    '')
      );      
      
 FOR i IN 1..100 LOOP  
         
        temp_num := round(DBMS_RANDOM.VALUE(1,4),0);  
        DBMS_OUTPUT.put_line('temp_num : ' ||  temp_num);
        
        -- 상세 주소 임의(random) 설정
        /*
            -- 1번 :
            -- 08291
            -- 서울특별시 구로구 새말로9길 45 (구로동, 신도림현대아파트) 
            -- 서울특별시 구로구 구로동 560 신도림현대아파트
            -- 상세주소 범위 : 101~103동 1~19층 ex) 1901호
            
            -- 2번 :
            -- 08288
            -- 서울특별시 구로구 새말로 93 (구로동, 신도림태영타운)
            -- 서울특별시 구로구 구로동 1267 신도림태영타운
            -- 상세주소 범위 : 101~113동 1~16층 ex) 1601호
            
            -- 3번 :
            -- 07376
            -- 서울특별시 영등포구 도신로 31 (대림동, 현대3차아파트)
            -- 서울특별시 영등포구 대림동 608-1 현대3차아파트
            -- 상세주소 범위 : 301~307동 1~30층 ex) 2801호
            
            -- 4번 :
            -- 08208 
            -- 서울특별시 구로구 경인로65길 16-15 (신도림동, 신도림4차 e-편한세상)
            -- 서울특별시 구로구 신도림동 646 신도림4차 e-편한세상
            -- 상세주소 범위 : 1101~1115동 1~25층 ex) 2501호
        
           ex) 
           select round(DBMS_RANDOM.VALUE(10,19),0) || 
           round(DBMS_RANDOM.VALUE(0,1),0) || 
           round(DBMS_RANDOM.VALUE(1,9),0) || '동'
           from dual;
        */
            IF temp_num = 1 THEN           
                              
                -- 상세주소 범위 : 101~103동 1~19층 ex) 1901호                
                temp_dong := round(DBMS_RANDOM.VALUE(101,103),0) || '동';
                 
                temp_ho := round(DBMS_RANDOM.VALUE(10,19),0) || 
                           round(DBMS_RANDOM.VALUE(0,1),0) || 
                           round(DBMS_RANDOM.VALUE(1,9),0) || '호';    
                               
             ELSIF temp_num = 3 THEN
                -- 상세주소 범위 : 101~113동 1~16층 ex) 1601호
                temp_dong := round(DBMS_RANDOM.VALUE(101,113),0) || '동';
                
                temp_ho := round(DBMS_RANDOM.VALUE(10,16),0) || 
                           round(DBMS_RANDOM.VALUE(0,1),0) || 
                           round(DBMS_RANDOM.VALUE(1,9),0) || '호';    
                
             ELSIF temp_num = 3 THEN
                    -- 상세주소 범위 : 301~307동 1~30층 ex) 2801호                
                    temp_dong := round(DBMS_RANDOM.VALUE(301,307),0) || '동';
                    
                    temp_ho := round(DBMS_RANDOM.VALUE(10,30),0) || 
                               round(DBMS_RANDOM.VALUE(0,1),0) || 
                               round(DBMS_RANDOM.VALUE(1,9),0) || '호';    
                
             ELSE
                    -- 상세주소 범위 : 1101~1115동 1~25층 ex) 2501호                
                    temp_dong := round(DBMS_RANDOM.VALUE(1101,1115),0) || '동';
                    
                    temp_ho := round(DBMS_RANDOM.VALUE(10,25),0) || 
                               round(DBMS_RANDOM.VALUE(0,1),0) || 
                               round(DBMS_RANDOM.VALUE(1,9),0) || '호';    
            END IF;           
        
            DBMS_OUTPUT.put_line(apt_addresses(temp_num).zip_code);
            DBMS_OUTPUT.put_line(apt_addresses(temp_num).road_address);
            DBMS_OUTPUT.put_line(apt_addresses(temp_num).jibun_address);
        
            -- 상세주소
            temp_detail_address := temp_dong || ' ' || temp_ho;            
            DBMS_OUTPUT.put_line('상세 주소 : ' || temp_detail_address);
            
            -- 주소 현황 업데이트(수정)
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
