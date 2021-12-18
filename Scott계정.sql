-- 데이터베이스 언어
 -- 1) 데이터 정의어 (DDL, Data Definition Language) : 관리자
 -- 2) 데이터 조작어 (DML, Data Manipulation Language) : 개발자, 사용자
 -- 3) 데이터 제어어 (DCL, Data Control Language) : 관리자
 
 
 -- ** 데이터 정의어 (DDL) 실습 : Create, Alter, Rename, Comment, Truncate, Drop
 Create table books (
    no number,
    name varchar2(30));
    
select * from tab;

desc books;

select * from books;

-- Alter : 테이블의 구조를 변경할 때 사용
-- 명령어는 대소문자 구문이 없음

alter table books
add (author varchar2(30));

alter table books
modify (name varchar(20));

select * from books;

desc books;

insert into books(no, name, author)
values (1, 'LeaderShip First', 'John');

insert into books(no, name, author)
values (2, 'Data Analysis', 'Peter');

select * from books;

rename books to t_books;

select * from tab;

comment on table t_books
is '출판 서적 목록';

desc user_tab_comments;

select *
from user_tab_comments
where table_name = 'T_BOOKS';

select * from t_books;

truncate table t_books;

drop table t_books;

select * from tab;

 -- 2) 데이터 조작어 (DML) 실습 : Select(검색), Insert(추가), Update(변경), Delete(제거)
 
Create table 친구 (
    이름 varchar2(20),
    휴대폰 varchar2(11),
    생일 date);

insert into 친구
values('Chris', '01011112222', '2007/08/28');

insert into 친구(생일, 휴대폰, 이름)
values('2010/03/29', null, 'Max');

insert into 친구(이름, 휴대폰)
values('Mary', '01022223333');

select * from 친구;

commit;

desc 친구;

update 친구
set 휴대폰 = '01099999999'
where 이름 = 'Mary';

select * from 친구;

rollback;

delete
from 친구
where 이름 = 'Mary';

select * from 친구;

select * from 친구;

alter session set nls_date_format = 'YYYY/MM/DD';

-- ** 데이터제어어(DCL) 실습: Commit(저장/변경불가), Rollback(이전계산으로 복구), Grant(권한부여), Revoke(권한제거)

select * from tab;

create table Choi (
계좌번호 number,
금액 number
);

create table 지함 (
계좌번호 number,
금액 number
);

select * from tab;

insert into choi values (1234, 20000);
insert into 지함 values (9999, 5000);

select * from choi;
select * from 지함;

-- Choi가 계좌 1234에서 지함의 계좌 9999로 10,000워을 이체
update choi
set 금액=금액-10000
where 계좌번호 = 1234;

update 지함
set 금액 = 금액 +10000
where 계좌번호 = 9999;

select * from choi;
select * from 지함;

commit;

--Choi가 계좌 1234에서 지함 계좌 9999fh 5,000원 이체
update choi
set 금액=금액-5000
where 계좌번호=1234;

update 지함
set 금액=금액+5000
where 계좌번호=9999;

select * from choi;
select * from 지함;

rollback;

-- * Select 집중연습 -6가지 패턴
/*
    1) select, from ->생략불가
    2) select, from, where
    3) select, from, group by
    4) select, from, where, group by
    5) select, from, group by, having 
    6) select, from, where, group by, having

    **order by는 6가지 모든 패턴에 다 사용할 수 있음
*/
-- 패턴-1) select, from
select * from emp; 

--(문제) 부서테이블(dept)의 모든 데이터 조회
select * from dept;

desc emp;
select *form emp;
select ename, sal from emp;

-- 사원테이블(emp)에서 사원번호, 이름, 직업, 급여를 조회
select empno, ename, job, sal from emp;

select empno, ename, ename, ename, ename, sal, sal --속성
from emp;

--(문제) 급여를 10% 인상해서 출력 (사원번호, 사원이름, 급여, 10%인상된급여)
select empno, ename, sal, sal *1.1 from emp;

-- (문제) 사원들의 연봉을 출력
select empno, ename, sal, comm, sal*12+comm as 연봉
from emp;--개체

-- Null 값으로 인하여 결과값이 정확하지 않음
-- nvl(comm, 0) comm 컬럼에 값이 있으면 그대로 사용하고, 없으면(=Null값)0을 사용함
select empno, ename, sal, comm, sal*12+nvl(comm, 0) from emp;

/* Null 값 정리
1. Null은 '알수 없는' 또는 '비어있는' 것을 의미
2. Null은 0이 아니고, 스페이스(공백)도 아님
3. Null과 어떤 값을 비교하거나 산술 연산하면 결과는 항상 Null
4. Null과 Null을 비교하면 결과는 Null
*/

-- emp 테이블에서 comm을 못 받는 사원의 사원번호와 이름, 보너스 조회
select empno, ename, comm from emp where comm is null;
-- emp 테이블에서 comm을 받는 사원의 사원번호와 이름, 보너스 조회
select empno, ename, comm from emp where comm is not null
-- emp 테이블에서 상사가 없는 직원의 사원번호, 사원이름, mgr 컬럼을 조회
select empno, ename, mgr from emp where mgr is null;
-- emp 테이블에서 상사가 있는 직원의 사원번호, 사원이름, mgr 컬럼을 조회
select empno, ename, mgr from emp where mgr is not null;

-- emp 테이블에서 급여를 적게 받는 순(오름차순: asc)
select empno, ename, sal, comm, deptno from emp order by sal asc;
-- emp 테이블에서 급여를 많이 받는 순(내림차순: desc)
select empno, ename, sal, comm, deptno from emp order by sal dec;

-- 사원의 이름을 알파벳 순으로 정렬(사원번호, 사원이름, 급여)
select empno, ename, sal from emp order by ename desc;  
--오름차순 정렬일때 asc 명령어는 생략가능/ 내림차순 정렬일때 desc 명령어 생략불가
-- 사원의 이름을 알파벳 순으로 정렬(사원번호, 사원이름, 급여)
select empno, ename, sal from emp order by 2 desc; -- 컬럼 번호 사용가능
-- 사원테이블에서 부서번호 순으로 오름차순 정렬(사원번호, 사원이름, 급여, 부서번호)
select empno, ename, sal, deptno from emp order by deptno asc, sal desc;

select empno, ename, sal, comm, deptno from emp order by comm desc; --내림차순(desc)정렬일는 Null값을 먼저 출력함
select empno, ename, sal, comm, deptno from emp order by comm asc; --오름차순(desc)정렬일는 Null값을 뒤에 출력함
-- 오름차순 정렬에 Null값을 먼저 출력하기
select empno, ename, sal, comm, deptno from emp order by comm nulls first;
-- 내림차순 정렬에 Null값 뒤에 출력
select empno, ename, sal, comm, deptno from emp order by comm nulls last;

-- select절에 없는 컬럼을 이용해서 정렬할 수 있음: 특정 컬럼의 데이터를 노풀하지 않으면서도 원하는 정렬을 수핼할 수 있음
select empno, ename, job from emp order by sal desc;
-- 정렬의 기준에 두 개 이상이면, order by 절에 두 개 이상의 컬럼을 나열
-- 부서번호를 기준으로 오름차순 정렬 1차, 같은 부서는 금여를 기준으로 내림차순 정렬 2차
select deptno, empno, ename, sal, comm from emp order by deptno asc, sal desc; --2차 정렬

-- alias(=별명)를 이용해서 컬럼명을 변경
select empno as 사원번호, ename "사원 이름", sal 급여 from emp; -- as는 생략 가능

select ename, sal 
from emp -- 실행순서 1
where ename= 'ALLEN'; -- 실행순서 2

-- (문제) emp테이블에서 모든 직업을 출력하시오.
-- disticnt를 이용해서 중복된 값을 제거/ order by와 distinct를 함께 사용하면 데이터 파악이 더욱 쉬워짐
select distinct job from emp;
select distinct job from emp order by job asc;

select deptno, job from emp order by 1, 2;
-- distinct 사용 후
select distinct deptno, job from emp order by 1, 2;

-- 문자 리터럴은 작은 따옴표('')로 감싸야됨
select ename, '사원의 업무는 ', job, '입니다.' from emp; -- 결과값 걸럼 4개
select ename || ' 사원의 업무는 ' || job || ' 입니다.' as 사원 from emp; -- 문자 연결자-컬럼 1개/오라클을 제외한 다른 DBMS에서는 문자열결자로 |기호, 오라클에서는 || 기호를 사용함

-- (출력 예)SNITR 사원의 입사일은 1981-11-12 입니다.
select ename || ' 사원의 입사일은 ' || hiredate || ' 입니다.' as 입사일 from emp;










-- 패턴 #2(select, from, where) ->수행평가2
select * from emp;
-- 30번 부서인 사원들의 모든 정보를 조회
select * from emp where deptno = 30;

-- 급여를 1500 예산 받는 사원의 이름과 급여 정보 조회
select ename, sal        --실행순서 3
from emp                 --실행순서 1
where sal >= 1500;       -- 실행순서2 /where은 선택연산- 튜플을 구함

-- 보너스를 받지 않는 회원이름과 급여 조회/ null은 연산이 성립 안됨
select ename, sal from emp where comm is null;   -- comm = null -> null임으로 출력값이 없음

-- 보너스를 받는 회원이름과 급여 조회
select ename, sal from emp where comm is not null;

select * from emp where empno = empno;  -- 항상 결과값이 true이므로 모든 튜플이 출력
 
select * from emp where comm = comm;  -- comm이 null값이 아닌 튜플들이 출력

-- 직업이 'salesman'이고 급여가 1500 이상인 사원들의 모든 정보 조회/ '~': 대소문자 구분하기
select * from emp where job = 'SALESMAN' and sal >= 1500;   -- 명령어는 대소문자 구분하지 않음/문자열은 대소분자 구분함 
select * from emp where job = 'SALESMAN' or sal >= 1500;

select * from emp where deptno = 30 and comm = null;   -- 연산의 결과값이 null이므로 출력값은 없음
select * from emp where deptno = 30 or comm = null;   -- 부서번호가 30인 사원만 출력됨
select * from emp where deptno = 30 and comm is null;

-- 급여가 1500 이상 이거나 직업이 'salesman'이면서 부서번호가 20인 사원의 모든 정보 조회
select * from emp where sal >= 1500 or (job = 'SALESMAN' and empno = 20);  -- and 조건이 or 조건보다 먼저 실행됨
select * from emp where (sal >= 1500 or job = 'SALESMAN') and empno = 20;  -- ()를 이용하여 우선순위 변경


select * from emp where 1= 2; --모든 결과값이 falas 이므로 출력되는 값이 없음

select * from emp where 120 > 119; -- 모든 결과값이 true 이므로 모든 전체 레코드가 출력됨

select * from emp where '120' > '21'; --문자열은 앞자리부터 비교, 결과값이 false 이므로 출력값 없음

select * from emp where to_number('120') > to_number('21'); --항상 결과값이 true이므로 모든 레코드 출력
--to_number: 문자열을 숫자로 바꿔줌

select * from tab;

create table emp1 as select * from emp; -- emp 내용 복사

select * from emp1;

desc emp1;

create table emp2 as select * from emp where 1 = 2;
emp테이블과 같은 테이블을 만들면서 레코드(내용)은 안들어감/ 속성만 복사

select * from emp2;

select job from emp;
select distinct job from emp; --중복된 값 제거(distinct, unique)
select unique job from emp;

select unique deptno from emp;

select deptno, job from emp;
select distinct deptno, job from emp;

--salesman인 모든 사원의 정보 조회
select * from emp where job = 'SALESMAN';
--salesman이 아닌 모든 사원의 정보 조회
select * from emp where job != 'SALESMAN';
select * from emp where job <> 'SALESMAN';
select * from emp where job ^= 'SALESMAN';
-- 부정을 의미: !=, <>, ^=
--급여를 2500 보다 많이 받는 사원의 이름과 급여 조회
select ename, sal from emp where sal > 2500    -- 2500 초과
select ename, sal from emp where sal >= 2500;  -- 2500 이상
select ename, sal from emp where sal < 2500;   -- 2500 미만
select ename, sal from emp where sal <= 2500;  -- 2500 이하

-- 이름이 M으로 시작하는 모든 사원의 이름, 급여, 입사일자, 부서번호 조회
-- like 연산자를 사용: 와일드 카드(%: zero or more, _:one)
select ename, sal, hiredate, deptno from emp where ename like 'M%'; -- M으로 시작하는 모든 이름이 나옴
-- 이름의 끝이 N으로 끝나는 사원의 이름, 급여 조회
select ename, sal from emp where ename like '%N';  
-- 이름이 5글짜인 사원의 모든 정보 조회
select * from emp where ename like '_____';
-- 이름의 두번째 글자가 A인 사월의 이름 조회
select ename from emp where ename like '_A%';
-- 이름에 S가 들어가는 사원의 이름과 급여와 부서번호 조회
select ename, sal, deptno from emp where ename like '%S%'; 


create table t1(
    col1 varchar2(10)
)

select * from tab;

insert into t1 values('UAAAO');
insert into t1 values('RABAY');
insert into t1 values('TOPACAOP');
insert into t1 values('POA_AP');

select * from t1;

-- A_A 부분 문자열이 포함된 속성값
--select * from t1 where coll like '%A_A%';
-- 속성값에 '_'가 들어있는 값을 출력
--select * from t1 where coll like '%$_%' escape '$';
-- 보너스(comm)를 받지 않는 사원의 모든 정보 출력
select * from emp where comm is null;
--보너스(comm)를 받는 사원의 모든 정보 출력
select * from emp where com is not null;
select * from emp where com >= 0;

-- 상사가 없는 사원의 모든 정보 출력
select * from emp where mgr is null;
select * from emp where not(mgr is null);

-- 상사가 있는 사원의 모든 정보 출력
select * from emp where mgr is not null;

--급여(sal)가 1500이상 3000이하 받는 사원의 모든 정보 출력
select * from emp where sal >=1500 and sal <= 3000;
select * from emp where sal between 1500 and 3000;

-- 급여 1500보다 적게 받거나 또는 3000보다 많이 받는 사원의 모든 정보
select * from emp where sal < 1500 or sal > 3000;
select * from emp where sal not between 1500 and 3000;

select distinct job from emp;
select ename as 사원이름, job as 직업, sal * 12 + nvl(comm, 0) as 연봉 from emp;

drop table t1_history;
create table t1_history(
 no number,
 prive number,
 begin_date varchar2(8),
 end_date varchar2(8)
);

select * from t1_history;
delete from t1_history; 

insert into t1_history values(1, 1500, '20010101', '20050731');
insert into t1_history values(1, 1800, '20050801', '20091231');
insert into t1_history values(1, 2000, '20100101', '99991231');

insert into t1_history values(2, 1000, '20010101', '20071231');
insert into t1_history values(2, 1500, '20080101','99991231');
insert into t1_history values(3, 2900, '20080101', '99990731');

--select * from t1_history where '20060321' between begin_date and end_date;r
where '20060321' >= begin_date and '20060321' <= end_date;

select * from t1_hhistory where '2009087' between begin_date and end_date;

-- 사원 테이블의 모든 사원의 모든 정보를 조회
select * from emp;

-- 10번 부서에 근무하고 있는 사원의 사원번호, 이름, 부서 번호 조회
select empno, ename, from emp where deptno = 10;
-- 20번 부서에 근무하고 있는 사원의 이름과 급여와 보너스 조회
select ename, sal, comm from emp where deptno = 20;

-- 사원테이블에서 10번 부서 또는 30번 부서에 근무하는 직원의 모든 정보를 조회
-- or 연산자 사용
select * from emp where deptno = 10 or deptno = 30;
-- in 연산자
select * from emp where deptno in (10, 30);
-- 합집합 연산
select * from emp where deptno = 10
union all
select * from emp where deptno = 30;

 
-- 사원테이블에서 James, Allen, Scott의 이름, 급여, 입사날짜를 조회
select ename, sal, hiredate from emp where ename = 'JAMES' or ename = 'ALLEN' or ename = 'SCOTT';
-- in 연산자
select ename, sal, hiredate from emp where ename in ('JAMES', 'ALLEN', 'SCOTT');

-- 직업이 'Salesman'이거나 'Manager'인 사원의 이름, 급여, 보너스, 부서번호 조회
-- ro 연산자
select ename, sal, comm, deptno from emp where JOB = 'SALESMAN' or JOB = 'MANAGER';
-- in 연산자
select ename, sal, comm, deptno from emp where JOB in ('SALESMAN', 'MANAGER');
 
-- 급여가 2500 초과하는 사원의 이름과 급여와 직업 조회
select ename, sal, job from emp where sal >= 2500;

-- 사원번호가 7566인 사원의 사원번호, 이름, 부서번호 조회
select empno, ename, deptno from emp where emptno = 7566;
select * from emp;

select ename, sal from emp order by ename asc;

-- 사원번호가 7566인 사원의 사원번호, 이름, 부서번호를 조회
select empno, ename, deptno from emp where empno = 7566;
-- 급여가 1000과 3000사이가 아닌 사원의 이름과 급여를 조회
-- between 연산자 이용
select ename, sal from emp where sal not between 1000 and 3000;
select ename, sal from emp where sal < 1000 or sal > 3000;
-- Allen과 james의 사원번호, 직업, 급여, 부서번호 조회
-- or연산자
select empno, job, sal, deptno from emp where ename = 'ALLEN' or ename = 'JAMES';
-- in 연산자
select empno, job, sal, deptno from emp where ename in ('ALLEN', 'JAMES');
select empno, job, sal, deptno from emp where ename = 'ALLEN'
Union
select empno, job, sal, deptno from emp where ename = 'JAMES';

-- 화요일에 입사한 사원 사원번호, 이름, 입사날짜 DAY(화요일) 조회
-- select empno, ename, hiredate from emp where day = 3;
select empno, ename, hiredate, to_char(hiredate, 'day') from emp;
select empno, ename, hiredate from emp where to_char(hiredate, 'day')='화요일';

select to_char(to_date('20040829', 'yyyymmdd'), 'day') from dual;

-- 직업이 salesman인 사원의 모든 정보 조회
select * from emp where job = 'SALESMAN';







-- 패턴 #3(select, from, group by)
select * from emp;
-- 각 부서의 몇 명이 근무하는지 조회
select count(*) from emp;
select deptno, count(*) from emp group by deptno order by deptno;

-- 각 부서의 급여 합, 평균 구하기/ 각 부서별급여합, 부서별급여평균으로 이름 정하기
select deptno, sum(sal) as 부서별급여합, avg(sal) as 부서별급여평균 from emp group by deptno order by deptno;

-- 각 업무별 최고급여 및 최저급여 조회
-- select max(sal), min(sal) from emp;-> 오류 발생
select job, max(sal) 최고급여, min(sal) 최저급여 from emp group by job;

-- 부서별/업무별 사원수, 급여합, 급여평균 조회
select deptno, job, count(*) 사원수, sum(sal) 급여합, avg(sal) 급여평균 from emp group by deptno, job order by deptno, job desc;  

-- 부서별/업무별 최초입사자 및 마지막 입사자를 조회
select deptno, job, min(hiredate), max(hiredate) from emp group by deptno, job order by 1;

-- 전체 사원들의 평균 포너스를 조회
select ename, comm, comm + 100, nvl(comm, 0), nvl(comm, 0) + 100 from emp; -- 값이 있을 땐 그대로 넣고 ,comm이 null값이면 0으로 치환
select avg(comm) 평균보너스4명, avg(nvl(comm, 0)) 전체사원의 평균보너스 from emp;

-- 부서별 사원들의 평균 보너스 조회
select deptno, avg(comm), trunc(avg(nvl(comm, 0))) from emp group by deptno;







-- 패턴 #4(select, from, where, group by)
-- 실행순서: from -> where -> group by -> select -> order by

-- 급여가 1000 이상인 사원들의 업무별 사원수, 부서별 최대급여, 부서별 최소급여를 조회
select job 업무, count(*) 사원수, max(sal) 최대급여, min(sal) 최소급여 from emp where sal >= 100 group by job;

-- 각 부서별로 Clerk은 몇명인가
select deptno, count(*) from emp group by deptno order by deptno;



-- ppt 19~20강 실습예제
create table 수강 (
    학번 char(7) not null,
    과목번호 varchar2(20) not null);
    
insert into 수강 values('9902101', 'CS100');    
insert into 수강 values('9902101', 'CS200');    
insert into 수강 values('9902102', 'CS200');    
insert into 수강 values('9902102', 'CS300');    
insert into 수강 values('9902103', 'CS400');    

create table 학생 (
    학번 char(4) not null,
    학생명 char(10) not null,
    학년 integer);

insert into 학생 values('901', '박', 2);    
insert into 학생 values('902', '조', 4);    
insert into 학생 values('903', '최', 3);    
   
     
create table 점수 (
    학번 char(4) not null,
    코드번호 char(10) not null,
    중간고사 integer,
    기말고사 integer);

insert into 점수 values ('901', 'C-101', 80, 95);
insert into 점수 values ('901', 'C-102', 75, 85);
insert into 점수 values ('902', 'C-101', 90, 80);
insert into 점수 values ('902', 'C-102', 95, 75);
insert into 점수 values ('902', 'D-103', 60, 90);
insert into 점수 values ('903', 'D-103', 65, 70);

create table 학생2 (
    학번 char(7) not null,
    이름 char(10) not null,
    학과번호 char(4),
    이수학점 integer,
    평균평점 number(3,2));

insert into 학생2 values ('9902101', '홍길동', '010', 100, 4.10);    
insert into 학생2 values ('9902102', '박두리', '010', 80, 3.25);    
insert into 학생2 values ('9902103', '김돌쇠', '020', 90, 3.00);    
insert into 학생2 values ('9902104', '이해솔', '020', 120, 2.60);    
insert into 학생2 values ('9902105', '임하늘', '030', 130, 1.90);   

select * from tab;
select * from 학생2;

-- 2번 처리
select 학번 from 수강 where 과목번호 = 'CS300';
select 학번 from 수강 where 과목번호 = 'CS200' and 학번 = 9902102;
-- 서브쿼리(1번 처리)
select 학번 from 수강 where 과목번호 = 'CS200' and 학번 = (select 학번 from 수강 where 과목번호 = 'CS300');

-- 보다 금여를 더 많이 받는 사원의 이름과 급여 조회
select sal from emp where ename = 'TURNER';
select ename, sal from emp where sal > (select sal from emp where ename = 'TURNER');


select 학번 from 점수 where 코드번호 = 'C-102';
select 학생명 from 학생 where 학번 = '901' or 학번 = '902';
-- 서브 쿼리
select 학생명 from 학생 where 학번 in (select 학번 from 점수 where 코드번호 = 'C-102');
-- join
select 학생.학생명 from 학생, 점수 where 학생.학번 = 점수.학번 and 점수.코드번호 ='C-102';

-- 중간고사가 70점 이하인 학생의 학생명 검색
select 학번 from 점수 where 중간고사 <= 70;
select 학생명 from 학생 where 학번 in(select 학번 from 점수 where 중간고사 <= 70);

select 이수학점 from 학생2 where 학과번호 = '020';
select  * from 학생2 where 이수학점 >= 90 or 이수학점 >= 120;
select * from 학생2 where 학과번호 != '020' and 이수학점 > some(select 이수학점 from 학생2 where 학과번호 = '020');
-- some: 적어도 하나 이상 의미

select * from 학생 where 이수학점 > all(select 이수학점 from 학생 where 학과번호 = '020');

-- 적어도 902학번의 학생보다 중간고사 점수가 높은 항생의 학번과 중간고사 점수 검색
                                                                                                                                                                                                                         
select * from 학생;

insert into 학생 (학번, 학생명, 학년) values('904', '이순신', 3);
insert into 학생 values('905', '강감찬', 3);

create table Test(
    학번 char(4),
    핵생명 char(10),
    학년 number(10)
);

insert into temp select * from 학생 where 학년 = '3';

select * from Test;
Delete from Test;

insert into 학생(학생명, 학번) values('류현진', '908');
insert into 학생(학생명, 학번, 학년) values('박찬호', '908', null);
insert into 학생 values('910', '송', 2);

create table temp(
    학번 char(7)
);

-- 학생 테이블에서 3학년 학생의 학번을 temp테이블에 추가 단, insert명령어는 한번만 사용
insert into temp select * from 학생 where 학년 = 3;

-- 보너스를 받지 않는 사원이 부서별로 몇 명인지 조회
select count(*) from emp where comm is null;
select deptno, count(*) from emp where comm is null group by deptno order by deptno;













-- 패턴 #5 (select, from, group by, hacing)
-- 실행 순서: from -> group by -> having -> select -> order by 

-- 5명 이상 근무하는 부서 및 인원수를 조회
select deptno, count(*) from emp group by deptno  having count(*) >= 5 order by deptno; 
-- emp테이블에서 최고급여와 최저급여의 차이가 500 이상인 업무 조회
select job, max(sal), min(sal) from emp group by job having max(sal) - min(sal) >= 500;
select job, max(sal), min(sal), max(sal) - min(sal) 급여차 from emp group by job having max(sal) - min(sal) >= 500 order by 급여차;--order by 4
-- 전체 사원 중에서 최초입사일과 마지막입사일 조회
select max(hiredate) 마지막입사일, min(hiredate) 최초입사일 from emp; 
-- 부서별 최초 입사일과 마지막 입사일을 조회
select deptno, max(hiredate) 마지막입사일, min(hiredate) 최초입사일 from emp group by deptno order by deptno;
-- 업무별 최초입사일과 마지막 입사일 조회
select job, max(hiredate) 마지막입사일, min(hiredate) 최초입사일 from emp group by job;
-- 업무별 최초입사일과 마지막입사일 조회 단, 마지막입사일이 82년 이전인 업무만 조회
select job, max(hiredate) 마지막입사일, min(hiredate) 최초입사일 from emp group by job having max(hiredate) < to_date('820101') order by 3;









-- 패턴 #6 (select, from, where, group by, hacing)
-- 실행 순서: from -> where -> group by -> having -> select -> order by 


-- 급여가 1000 이상인 사원들의 업무별로 나눠서 집계하기
-- 단, 부서별 최저급여가 2000 이상인 결과만 출력하도록 할 것
-- 집계함수 : 업무별 사원수-count, 업무별 최대급여-max, 업무별 최소급여-min
-- ** 집계함수가 아닌 것과 같이 쓸면 에러남/ group by의 조건은 쓸수 있음
select * from emp;
select count(*), max(sal), min(sal), sum(sal), avg(sal) from emp;
select deptno, count(*) from emp group by deptno;
select job, count(*) 사원수, max(sal) 부서별최대급여, min(sal) 부서별최소급여 from emp where sal >= 1000 group by job having min(sal) >= 2000;
-- having은 group by가 반드시 있어야 함 


-- 커미션을 받지 않는 사원이 부서별로 몇 명인지 조회
-- 단, 커미션을 받지 사원이 3명 이상인 결과만 출력
select deptno, count(*) from emp where comm is null group by deptno having count(*) >= 3 order by deptno;


-- 부서별 인원수를 구한 다음, 결과값에서 20번 부서 제외
select deptno, count(*) from emp group by deptno;
-- where절, having절 둘 다 사용가능하나 where절을 사용하는게 성능에 좋음
-- 실행순서*
-- where절에서 필터링한 다음에 그룹화 -> 성능에 좋음
select deptno, count(*) from emp where deptno != 20 group by deptno order by deptno;

-- having절에서 필터링 -> 전체 데이터를 그룹화하고, 연산을 수행하므로 결과에 포함되지 않을 데이터까지도 그룹화를 진행하므로 비효율적
select deptno, count(*) from emp group by deptno having deptno != 20;


-- emp테이블에서 부서별 사원수가 5명 이상인 부서의 부서번호, 사원수를 조회
select deptno, count(*) from emp group by deptno order by deptno;

select deptno, count(*) from emp where count(*) >= 5 group by deptno; -- 에러 발생:실행순서

-- 연습문제
-- dept 테이블의 모든 정보 조회
select * from dept;
select * from emp;

-- martin의 급여와 부서번호 조회
select sal, deptno from emp where ename = 'MARTIN';
-- 50번 부서의 부서이름은 무엇인지 조회
select deptno, dname from dept where deptno = 50;
-- scott의 이름, 급여, 부서이름 조회(조인-공통된 속성 필요)
select emp.ename, emp.sal, dept.dname from emp, dept where emp.deptno = dept.deptno and emp.ename = 'SCOTT'; 
-- locations 테이블에서 지역코드와 도시명 조회
desc locations;
select * from locations;
select loc_code, city from locations;

select dept.dname, locations.city from dept, locations where dept.loc_code = locations.loc_code;

-- 스미스의 급여, 부서이름, 근무지이름 조회
-- select emp.sal, dept.dname, locations.city from emp, dept, locations where emp.deptno = dept.deptno and dept.loc_code = lcoation.loc_code and emp.


-- emp 테이블에서 부서별 사원수 조회(부서별로 오름차순 정렬)
select deptno, count(*) from emp group by deptno order by deptno;








--------------------------------------------------------------
--drop table departments cascade CONSTRAINTS;
--drop table employees cascade CONSTRAINTS;
--drop table jobs cascade CONSTRAINTS;
--drop table job_grades cascade CONSTRAINTS;
--drop table job_history cascade CONSTRAINTS;
--drop table locations cascade CONSTRAINTS;
--drop table regions cascade CONSTRAINTS;
--drop table countries cascade CONSTRAINTS;

SET FEEDBACK 1
SET NUMWIDTH 10
SET LINESIZE 80
SET TRIMSPOOL ON
SET TAB OFF
SET PAGESIZE 100
SET ECHO OFF 


CREATE TABLE regions
    ( region_id      NUMBER 
       CONSTRAINT  region_id_nn NOT NULL 
    , region_name    VARCHAR2(25) 
    );

CREATE UNIQUE INDEX reg_id_pk
ON regions (region_id);

ALTER TABLE regions
ADD ( CONSTRAINT reg_id_pk
       		 PRIMARY KEY (region_id)
    ) ;

CREATE TABLE countries 
    ( country_id      CHAR(2) 
       CONSTRAINT  country_id_nn NOT NULL 
    , country_name    VARCHAR2(40) 
    , region_id       NUMBER 
    , CONSTRAINT     country_c_id_pk 
        	     PRIMARY KEY (country_id) 
    ) 
    ORGANIZATION INDEX; 

ALTER TABLE countries
ADD ( CONSTRAINT countr_reg_fk
        	 FOREIGN KEY (region_id)
          	  REFERENCES regions(region_id) 
    ) ;

CREATE TABLE locations
    ( location_id    NUMBER(4)
    , street_address VARCHAR2(40)
    , postal_code    VARCHAR2(12)
    , city       VARCHAR2(30)
	CONSTRAINT     loc_city_nn  NOT NULL
    , state_province VARCHAR2(25)
    , country_id     CHAR(2)
    ) ;

CREATE UNIQUE INDEX loc_id_pk
ON locations (location_id) ;

ALTER TABLE locations
ADD ( CONSTRAINT loc_id_pk
       		 PRIMARY KEY (location_id)
    , CONSTRAINT loc_c_id_fk
       		 FOREIGN KEY (country_id)
        	  REFERENCES countries(country_id) 
    ) ;


CREATE TABLE departments
    ( department_id    NUMBER(4)
    , department_name  VARCHAR2(30)
	CONSTRAINT  dept_name_nn  NOT NULL
    , manager_id       NUMBER(6)
    , location_id      NUMBER(4)
    ) ;



CREATE UNIQUE INDEX dept_id_pk
ON departments (department_id) ;

ALTER TABLE departments
ADD ( CONSTRAINT dept_id_pk
       		 PRIMARY KEY (department_id)
    , CONSTRAINT dept_loc_fk
       		 FOREIGN KEY (location_id)
        	  REFERENCES locations (location_id)
     ) ;

--CREATE SEQUENCE departments_seq
-- START WITH     280
-- INCREMENT BY   10
-- MAXVALUE       9990
-- NOCACHE
-- NOCYCLE;

CREATE TABLE jobs
    ( job_id         VARCHAR2(10)
    , job_title      VARCHAR2(35)
	CONSTRAINT     job_title_nn  NOT NULL
    , min_salary     NUMBER(6)
    , max_salary     NUMBER(6)
    ) ;

CREATE UNIQUE INDEX job_id_pk 
ON jobs (job_id) ;

ALTER TABLE jobs
ADD ( CONSTRAINT job_id_pk
      		 PRIMARY KEY(job_id)
    ) ;

CREATE TABLE employees
    ( employee_id    NUMBER(6)
    , first_name     VARCHAR2(20)
    , last_name      VARCHAR2(25)
	 CONSTRAINT     emp_last_name_nn  NOT NULL
    , email          VARCHAR2(25)
	CONSTRAINT     emp_email_nn  NOT NULL
    , phone_number   VARCHAR2(20)
    , hire_date      DATE
	CONSTRAINT     emp_hire_date_nn  NOT NULL
    , job_id         VARCHAR2(10)
	CONSTRAINT     emp_job_nn  NOT NULL
    , salary         NUMBER(8,2)
    , commission_pct NUMBER(2,2)
    , manager_id     NUMBER(6)
    , department_id  NUMBER(4)
    , CONSTRAINT     emp_salary_min
                     CHECK (salary > 0) 
    , CONSTRAINT     emp_email_uk
                     UNIQUE (email)
    ) ;

CREATE UNIQUE INDEX emp_emp_id_pk
ON employees (employee_id) ;


ALTER TABLE employees
ADD ( CONSTRAINT     emp_emp_id_pk
                     PRIMARY KEY (employee_id)
    , CONSTRAINT     emp_dept_fk
                     FOREIGN KEY (department_id)
                      REFERENCES departments
    , CONSTRAINT     emp_job_fk
                     FOREIGN KEY (job_id)
                      REFERENCES jobs (job_id)
    , CONSTRAINT     emp_manager_fk
                     FOREIGN KEY (manager_id)
                      REFERENCES employees
    ) ;

ALTER TABLE departments
ADD ( CONSTRAINT dept_mgr_fk
      		 FOREIGN KEY (manager_id)
      		  REFERENCES employees (employee_id)
    ) ;


--CREATE SEQUENCE employees_seq
-- START WITH     207
-- INCREMENT BY   1
-- NOCACHE
-- NOCYCLE;


CREATE TABLE job_history
    ( employee_id   NUMBER(6)
	 CONSTRAINT    jhist_employee_nn  NOT NULL
    , start_date    DATE
	CONSTRAINT    jhist_start_date_nn  NOT NULL
    , end_date      DATE
	CONSTRAINT    jhist_end_date_nn  NOT NULL
    , job_id        VARCHAR2(10)
	CONSTRAINT    jhist_job_nn  NOT NULL
    , department_id NUMBER(4)
    , CONSTRAINT    jhist_date_interval
                    CHECK (end_date > start_date)
    ) ;

CREATE UNIQUE INDEX jhist_emp_id_st_date_pk 
ON job_history (employee_id, start_date) ;

ALTER TABLE job_history
ADD ( CONSTRAINT jhist_emp_id_st_date_pk
      PRIMARY KEY (employee_id, start_date)
    , CONSTRAINT     jhist_job_fk
                     FOREIGN KEY (job_id)
                     REFERENCES jobs
    , CONSTRAINT     jhist_emp_fk
                     FOREIGN KEY (employee_id)
                     REFERENCES employees
    , CONSTRAINT     jhist_dept_fk
                     FOREIGN KEY (department_id)
                     REFERENCES departments
    ) ;

----------------------------------------

--CREATE OR REPLACE VIEW emp_details_view
--  (employee_id,
--   job_id,
--   manager_id,
--   department_id,
--   location_id,
--   country_id,
--   first_name,
--   last_name,
--   salary,
--   commission_pct,
--   department_name,
--   job_title,
--   city,
--   state_province,
--   country_name,
--   region_name)
--AS SELECT
--  e.employee_id, 
--  e.job_id, 
--  e.manager_id, 
--  e.department_id,
--  d.location_id,
--  l.country_id,
--  e.first_name,
--  e.last_name,
--  e.salary,
--  e.commission_pct,
--  d.department_name,
--  j.job_title,
--  l.city,
--  l.state_province,
--  c.country_name,
--  r.region_name
--FROM
--  employees e,
--  departments d,
--  jobs j,
--  locations l,
--  countries c,
--  regions r
--WHERE e.department_id = d.department_id
--  AND d.location_id = l.location_id
--  AND l.country_id = c.country_id
--  AND c.region_id = r.region_id
--  AND j.job_id = e.job_id 
--WITH READ ONLY;

COMMIT;

SET VERIFY OFF
ALTER SESSION SET NLS_LANGUAGE=American; 


INSERT INTO regions VALUES 
        ( 1
        , 'Europe' 
        );

INSERT INTO regions VALUES 
        ( 2
        , 'Americas' 
        );

INSERT INTO regions VALUES 
        ( 3
        , 'Asia' 
        );

INSERT INTO regions VALUES 
        ( 4
        , 'Middle East and Africa' 
        );

INSERT INTO countries VALUES 
        ( 'IT'
        , 'Italy'
        , 1 
        );

INSERT INTO countries VALUES 
        ( 'JP'
        , 'Japan'
	, 3 
        );

INSERT INTO countries VALUES 
        ( 'US'
        , 'United States of America'
        , 2 
        );

INSERT INTO countries VALUES 
        ( 'CA'
        , 'Canada'
        , 2 
        );

INSERT INTO countries VALUES 
        ( 'CN'
        , 'China'
        , 3 
        );

INSERT INTO countries VALUES 
        ( 'IN'
        , 'India'
        , 3 
        );

INSERT INTO countries VALUES 
        ( 'AU'
        , 'Australia'
        , 3 
        );

INSERT INTO countries VALUES 
        ( 'ZW'
        , 'Zimbabwe'
        , 4 
        );

INSERT INTO countries VALUES 
        ( 'SG'
        , 'Singapore'
        , 3 
        );

INSERT INTO countries VALUES 
        ( 'UK'
        , 'United Kingdom'
        , 1 
        );

INSERT INTO countries VALUES 
        ( 'FR'
        , 'France'
        , 1 
        );

INSERT INTO countries VALUES 
        ( 'DE'
        , 'Germany'
        , 1 
        );

INSERT INTO countries VALUES 
        ( 'ZM'
        , 'Zambia'
        , 4 
        );

INSERT INTO countries VALUES 
        ( 'EG'
        , 'Egypt'
        , 4 
        );

INSERT INTO countries VALUES 
        ( 'BR'
        , 'Brazil'
        , 2 
        );

INSERT INTO countries VALUES 
        ( 'CH'
        , 'Switzerland'
        , 1 
        );

INSERT INTO countries VALUES 
        ( 'NL'
        , 'Netherlands'
        , 1 
        );

INSERT INTO countries VALUES 
        ( 'MX'
        , 'Mexico'
        , 2 
        );

INSERT INTO countries VALUES 
        ( 'KW'
        , 'Kuwait'
        , 4 
        );

INSERT INTO countries VALUES 
        ( 'IL'
        , 'Israel'
        , 4 
        );

INSERT INTO countries VALUES 
        ( 'DK'
        , 'Denmark'
        , 1 
        );

INSERT INTO countries VALUES 
        ( 'HK'
        , 'HongKong'
        , 3 
        );

INSERT INTO countries VALUES 
        ( 'NG'
        , 'Nigeria'
        , 4 
        );

INSERT INTO countries VALUES 
        ( 'AR'
        , 'Argentina'
        , 2 
        );

INSERT INTO countries VALUES 
        ( 'BE'
        , 'Belgium'
        , 1 
        );

INSERT INTO locations VALUES 
        ( 1000 
        , '1297 Via Cola di Rie'
        , '00989'
        , 'Roma'
        , NULL
        , 'IT'
        );

INSERT INTO locations VALUES 
        ( 1100 
        , '93091 Calle della Testa'
        , '10934'
        , 'Venice'
        , NULL
        , 'IT'
        );

INSERT INTO locations VALUES 
        ( 1200 
        , '2017 Shinjuku-ku'
        , '1689'
        , 'Tokyo'
        , 'Tokyo Prefecture'
        , 'JP'
        );

INSERT INTO locations VALUES 
        ( 1300 
        , '9450 Kamiya-cho'
        , '6823'
        , 'Hiroshima'
        , NULL
        , 'JP'
        );

INSERT INTO locations VALUES 
        ( 1400 
        , '2014 Jabberwocky Rd'
        , '26192'
        , 'Southlake'
        , 'Texas'
        , 'US'
        );

INSERT INTO locations VALUES 
        ( 1500 
        , '2011 Interiors Blvd'
        , '99236'
        , 'South San Francisco'
        , 'California'
        , 'US'
        );

INSERT INTO locations VALUES 
        ( 1600 
        , '2007 Zagora St'
        , '50090'
        , 'South Brunswick'
        , 'New Jersey'
        , 'US'
        );

INSERT INTO locations VALUES 
        ( 1700 
        , '2004 Charade Rd'
        , '98199'
        , 'Seattle'
        , 'Washington'
        , 'US'
        );

INSERT INTO locations VALUES 
        ( 1800 
        , '147 Spadina Ave'
        , 'M5V 2L7'
        , 'Toronto'
        , 'Ontario'
        , 'CA'
        );

INSERT INTO locations VALUES 
        ( 1900 
        , '6092 Boxwood St'
        , 'YSW 9T2'
        , 'Whitehorse'
        , 'Yukon'
        , 'CA'
        );

INSERT INTO locations VALUES 
        ( 2000 
        , '40-5-12 Laogianggen'
        , '190518'
        , 'Beijing'
        , NULL
        , 'CN'
        );

INSERT INTO locations VALUES 
        ( 2100 
        , '1298 Vileparle (E)'
        , '490231'
        , 'Bombay'
        , 'Maharashtra'
        , 'IN'
        );

INSERT INTO locations VALUES 
        ( 2200 
        , '12-98 Victoria Street'
        , '2901'
        , 'Sydney'
        , 'New South Wales'
        , 'AU'
        );

INSERT INTO locations VALUES 
        ( 2300 
        , '198 Clementi North'
        , '540198'
        , 'Singapore'
        , NULL
        , 'SG'
        );

INSERT INTO locations VALUES 
        ( 2400 
        , '8204 Arthur St'
        , NULL
        , 'London'
        , NULL
        , 'UK'
        );

INSERT INTO locations VALUES 
        ( 2500 
        , 'Magdalen Centre, The Oxford Science Park'
        , 'OX9 9ZB'
        , 'Oxford'
        , 'Oxford'
        , 'UK'
        );

INSERT INTO locations VALUES 
        ( 2600 
        , '9702 Chester Road'
        , '09629850293'
        , 'Stretford'
        , 'Manchester'
        , 'UK'
        );

INSERT INTO locations VALUES 
        ( 2700 
        , 'Schwanthalerstr. 7031'
        , '80925'
        , 'Munich'
        , 'Bavaria'
        , 'DE'
        );

INSERT INTO locations VALUES 
        ( 2800 
        , 'Rua Frei Caneca 1360 '
        , '01307-002'
        , 'Sao Paulo'
        , 'Sao Paulo'
        , 'BR'
        );

INSERT INTO locations VALUES 
        ( 2900 
        , '20 Rue des Corps-Saints'
        , '1730'
        , 'Geneva'
        , 'Geneve'
        , 'CH'
        );

INSERT INTO locations VALUES 
        ( 3000 
        , 'Murtenstrasse 921'
        , '3095'
        , 'Bern'
        , 'BE'
        , 'CH'
        );

INSERT INTO locations VALUES 
        ( 3100 
        , 'Pieter Breughelstraat 837'
        , '3029SK'
        , 'Utrecht'
        , 'Utrecht'
        , 'NL'
        );

INSERT INTO locations VALUES 
        ( 3200 
        , 'Mariano Escobedo 9991'
        , '11932'
        , 'Mexico City'
        , 'Distrito Federal,'
        , 'MX'
        );


ALTER TABLE departments 
  DISABLE CONSTRAINT dept_mgr_fk;

INSERT INTO departments VALUES 
        ( 10
        , 'Administration'
        , 200
        , 1700
        );

INSERT INTO departments VALUES 
        ( 20
        , 'Marketing'
        , 201
        , 1800
        );
                                
INSERT INTO departments VALUES 
        ( 30
        , 'Purchasing'
        , 114
        , 1700
	);
                
INSERT INTO departments VALUES 
        ( 40
        , 'Human Resources'
        , 203
        , 2400
        );

INSERT INTO departments VALUES 
        ( 50
        , 'Shipping'
        , 121
        , 1500
        );
                
INSERT INTO departments VALUES 
        ( 60 
        , 'IT'
        , 103
        , 1400
        );
                
INSERT INTO departments VALUES 
        ( 70 
        , 'Public Relations'
        , 204
        , 2700
        );
                
INSERT INTO departments VALUES 
        ( 80 
        , 'Sales'
        , 145
        , 2500
        );
                
INSERT INTO departments VALUES 
        ( 90 
        , 'Executive'
        , 100
        , 1700
        );

INSERT INTO departments VALUES 
        ( 100 
        , 'Finance'
        , 108
        , 1700
        );
                
INSERT INTO departments VALUES 
        ( 110 
        , 'Accounting'
        , 205
        , 1700
        );

INSERT INTO departments VALUES 
        ( 120 
        , 'Treasury'
        , NULL
        , 1700
        );

INSERT INTO departments VALUES 
        ( 130 
        , 'Corporate Tax'
        , NULL
        , 1700
        );

INSERT INTO departments VALUES 
        ( 140 
        , 'Control And Credit'
        , NULL
        , 1700
        );

INSERT INTO departments VALUES 
        ( 150 
        , 'Shareholder Services'
        , NULL
        , 1700
        );

INSERT INTO departments VALUES 
        ( 160 
        , 'Benefits'
        , NULL
        , 1700
        );

INSERT INTO departments VALUES 
        ( 170 
        , 'Manufacturing'
        , NULL
        , 1700
        );

INSERT INTO departments VALUES 
        ( 180 
        , 'Construction'
        , NULL
        , 1700
        );

INSERT INTO departments VALUES 
        ( 190 
        , 'Contracting'
        , NULL
        , 1700
        );

INSERT INTO departments VALUES 
        ( 200 
        , 'Operations'
        , NULL
        , 1700
        );

INSERT INTO departments VALUES 
        ( 210 
        , 'IT Support'
        , NULL
        , 1700
        );

INSERT INTO departments VALUES 
        ( 220 
        , 'NOC'
        , NULL
        , 1700
        );

INSERT INTO departments VALUES 
        ( 230 
        , 'IT Helpdesk'
        , NULL
        , 1700
        );

INSERT INTO departments VALUES 
        ( 240 
        , 'Government Sales'
        , NULL
        , 1700
        );

INSERT INTO departments VALUES 
        ( 250 
        , 'Retail Sales'
        , NULL
        , 1700
        );

INSERT INTO departments VALUES 
        ( 260 
        , 'Recruiting'
        , NULL
        , 1700
        );

INSERT INTO departments VALUES 
        ( 270 
        , 'Payroll'
        , NULL
        , 1700
        );


INSERT INTO jobs VALUES 
        ( 'AD_PRES'
        , 'President'
        , 20000
        , 40000
        );
INSERT INTO jobs VALUES 
        ( 'AD_VP'
        , 'Administration Vice President'
        , 15000
        , 30000
        );

INSERT INTO jobs VALUES 
        ( 'AD_ASST'
        , 'Administration Assistant'
        , 3000
        , 6000
        );

INSERT INTO jobs VALUES 
        ( 'FI_MGR'
        , 'Finance Manager'
        , 8200
        , 16000
        );

INSERT INTO jobs VALUES 
        ( 'FI_ACCOUNT'
        , 'Accountant'
        , 4200
        , 9000
        );

INSERT INTO jobs VALUES 
        ( 'AC_MGR'
        , 'Accounting Manager'
        , 8200
        , 16000
        );

INSERT INTO jobs VALUES 
        ( 'AC_ACCOUNT'
        , 'Public Accountant'
        , 4200
        , 9000
        );
INSERT INTO jobs VALUES 
        ( 'SA_MAN'
        , 'Sales Manager'
        , 10000
        , 20000
        );

INSERT INTO jobs VALUES 
        ( 'SA_REP'
        , 'Sales Representative'
        , 6000
        , 12000
        );

INSERT INTO jobs VALUES 
        ( 'PU_MAN'
        , 'Purchasing Manager'
        , 8000
        , 15000
        );

INSERT INTO jobs VALUES 
        ( 'PU_CLERK'
        , 'Purchasing Clerk'
        , 2500
        , 5500
        );

INSERT INTO jobs VALUES 
        ( 'ST_MAN'
        , 'Stock Manager'
        , 5500
        , 8500
        );
INSERT INTO jobs VALUES 
        ( 'ST_CLERK'
        , 'Stock Clerk'
        , 2000
        , 5000
        );

INSERT INTO jobs VALUES 
        ( 'SH_CLERK'
        , 'Shipping Clerk'
        , 2500
        , 5500
        );

INSERT INTO jobs VALUES 
        ( 'IT_PROG'
        , 'Programmer'
        , 4000
        , 10000
        );

INSERT INTO jobs VALUES 
        ( 'MK_MAN'
        , 'Marketing Manager'
        , 9000
        , 15000
        );

INSERT INTO jobs VALUES 
        ( 'MK_REP'
        , 'Marketing Representative'
        , 4000
        , 9000
        );

INSERT INTO jobs VALUES 
        ( 'HR_REP'
        , 'Human Resources Representative'
        , 4000
        , 9000
        );

INSERT INTO jobs VALUES 
        ( 'PR_REP'
        , 'Public Relations Representative'
        , 4500
        , 10500
        );

INSERT INTO employees VALUES 
        ( 100
        , 'Steven'
        , 'King'
        , 'SKING'
        , '515.123.4567'
        , TO_DATE('17-JUN-1987', 'dd-MON-yyyy')
        , 'AD_PRES'
        , 24000
        , NULL
        , NULL
        , 90
        );

INSERT INTO employees VALUES 
        ( 101
        , 'Neena'
        , 'Kochhar'
        , 'NKOCHHAR'
        , '515.123.4568'
        , TO_DATE('21-SEP-1989', 'dd-MON-yyyy')
        , 'AD_VP'
        , 17000
        , NULL
        , 100
        , 90
        );

INSERT INTO employees VALUES 
        ( 102
        , 'Lex'
        , 'De Haan'
        , 'LDEHAAN'
        , '515.123.4569'
        , TO_DATE('13-JAN-1993', 'dd-MON-yyyy')
        , 'AD_VP'
        , 17000
        , NULL
        , 100
        , 90
        );

INSERT INTO employees VALUES 
        ( 103
        , 'Alexander'
        , 'Hunold'
        , 'AHUNOLD'
        , '590.423.4567'
        , TO_DATE('03-JAN-1990', 'dd-MON-yyyy')
        , 'IT_PROG'
        , 9000
        , NULL
        , 102
        , 60
        );

INSERT INTO employees VALUES 
        ( 104
        , 'Bruce'
        , 'Ernst'
        , 'BERNST'
        , '590.423.4568'
        , TO_DATE('21-MAY-1991', 'dd-MON-yyyy')
        , 'IT_PROG'
        , 6000
        , NULL
        , 103
        , 60
        );

INSERT INTO employees VALUES 
        ( 105
        , 'David'
        , 'Austin'
        , 'DAUSTIN'
        , '590.423.4569'
        , TO_DATE('25-JUN-1997', 'dd-MON-yyyy')
        , 'IT_PROG'
        , 4800
        , NULL
        , 103
        , 60
        );

INSERT INTO employees VALUES 
        ( 106
        , 'Valli'
        , 'Pataballa'
        , 'VPATABAL'
        , '590.423.4560'
        , TO_DATE('05-FEB-1998', 'dd-MON-yyyy')
        , 'IT_PROG'
        , 4800
        , NULL
        , 103
        , 60
        );

INSERT INTO employees VALUES 
        ( 107
        , 'Diana'
        , 'Lorentz'
        , 'DLORENTZ'
        , '590.423.5567'
        , TO_DATE('07-FEB-1999', 'dd-MON-yyyy')
        , 'IT_PROG'
        , 4200
        , NULL
        , 103
        , 60
        );

INSERT INTO employees VALUES 
        ( 108
        , 'Nancy'
        , 'Greenberg'
        , 'NGREENBE'
        , '515.124.4569'
        , TO_DATE('17-AUG-1994', 'dd-MON-yyyy')
        , 'FI_MGR'
        , 12000
        , NULL
        , 101
        , 100
        );

INSERT INTO employees VALUES 
        ( 109
        , 'Daniel'
        , 'Faviet'
        , 'DFAVIET'
        , '515.124.4169'
        , TO_DATE('16-AUG-1994', 'dd-MON-yyyy')
        , 'FI_ACCOUNT'
        , 9000
        , NULL
        , 108
        , 100
        );

INSERT INTO employees VALUES 
        ( 110
        , 'John'
        , 'Chen'
        , 'JCHEN'
        , '515.124.4269'
        , TO_DATE('28-SEP-1997', 'dd-MON-yyyy')
        , 'FI_ACCOUNT'
        , 8200
        , NULL
        , 108
        , 100
        );

INSERT INTO employees VALUES 
        ( 111
        , 'Ismael'
        , 'Sciarra'
        , 'ISCIARRA'
        , '515.124.4369'
        , TO_DATE('30-SEP-1997', 'dd-MON-yyyy')
        , 'FI_ACCOUNT'
        , 7700
        , NULL
        , 108
        , 100
        );

INSERT INTO employees VALUES 
        ( 112
        , 'Jose Manuel'
        , 'Urman'
        , 'JMURMAN'
        , '515.124.4469'
        , TO_DATE('07-MAR-1998', 'dd-MON-yyyy')
        , 'FI_ACCOUNT'
        , 7800
        , NULL
        , 108
        , 100
        );

INSERT INTO employees VALUES 
        ( 113
        , 'Luis'
        , 'Popp'
        , 'LPOPP'
        , '515.124.4567'
        , TO_DATE('07-DEC-1999', 'dd-MON-yyyy')
        , 'FI_ACCOUNT'
        , 6900
        , NULL
        , 108
        , 100
        );

INSERT INTO employees VALUES 
        ( 114
        , 'Den'
        , 'Raphaely'
        , 'DRAPHEAL'
        , '515.127.4561'
        , TO_DATE('07-DEC-1994', 'dd-MON-yyyy')
        , 'PU_MAN'
        , 11000
        , NULL
        , 100
        , 30
        );

INSERT INTO employees VALUES 
        ( 115
        , 'Alexander'
        , 'Khoo'
        , 'AKHOO'
        , '515.127.4562'
        , TO_DATE('18-MAY-1995', 'dd-MON-yyyy')
        , 'PU_CLERK'
        , 3100
        , NULL
        , 114
        , 30
        );

INSERT INTO employees VALUES 
        ( 116
        , 'Shelli'
        , 'Baida'
        , 'SBAIDA'
        , '515.127.4563'
        , TO_DATE('24-DEC-1997', 'dd-MON-yyyy')
        , 'PU_CLERK'
        , 2900
        , NULL
        , 114
        , 30
        );

INSERT INTO employees VALUES 
        ( 117
        , 'Sigal'
        , 'Tobias'
        , 'STOBIAS'
        , '515.127.4564'
        , TO_DATE('24-JUL-1997', 'dd-MON-yyyy')
        , 'PU_CLERK'
        , 2800
        , NULL
        , 114
        , 30
        );

INSERT INTO employees VALUES 
        ( 118
        , 'Guy'
        , 'Himuro'
        , 'GHIMURO'
        , '515.127.4565'
        , TO_DATE('15-NOV-1998', 'dd-MON-yyyy')
        , 'PU_CLERK'
        , 2600
        , NULL
        , 114
        , 30
        );

INSERT INTO employees VALUES 
        ( 119
        , 'Karen'
        , 'Colmenares'
        , 'KCOLMENA'
        , '515.127.4566'
        , TO_DATE('10-AUG-1999', 'dd-MON-yyyy')
        , 'PU_CLERK'
        , 2500
        , NULL
        , 114
        , 30
        );

INSERT INTO employees VALUES 
        ( 120
        , 'Matthew'
        , 'Weiss'
        , 'MWEISS'
        , '650.123.1234'
        , TO_DATE('18-JUL-1996', 'dd-MON-yyyy')
        , 'ST_MAN'
        , 8000
        , NULL
        , 100
        , 50
        );

INSERT INTO employees VALUES 
        ( 121
        , 'Adam'
        , 'Fripp'
        , 'AFRIPP'
        , '650.123.2234'
        , TO_DATE('10-APR-1997', 'dd-MON-yyyy')
        , 'ST_MAN'
        , 8200
        , NULL
        , 100
        , 50
        );

INSERT INTO employees VALUES 
        ( 122
        , 'Payam'
        , 'Kaufling'
        , 'PKAUFLIN'
        , '650.123.3234'
        , TO_DATE('01-MAY-1995', 'dd-MON-yyyy')
        , 'ST_MAN'
        , 7900
        , NULL
        , 100
        , 50
        );

INSERT INTO employees VALUES 
        ( 123
        , 'Shanta'
        , 'Vollman'
        , 'SVOLLMAN'
        , '650.123.4234'
        , TO_DATE('10-OCT-1997', 'dd-MON-yyyy')
        , 'ST_MAN'
        , 6500
        , NULL
        , 100
        , 50
        );

INSERT INTO employees VALUES 
        ( 124
        , 'Kevin'
        , 'Mourgos'
        , 'KMOURGOS'
        , '650.123.5234'
        , TO_DATE('16-NOV-1999', 'dd-MON-yyyy')
        , 'ST_MAN'
        , 5800
        , NULL
        , 100
        , 50
        );

INSERT INTO employees VALUES 
        ( 125
        , 'Julia'
        , 'Nayer'
        , 'JNAYER'
        , '650.124.1214'
        , TO_DATE('16-JUL-1997', 'dd-MON-yyyy')
        , 'ST_CLERK'
        , 3200
        , NULL
        , 120
        , 50
        );

INSERT INTO employees VALUES 
        ( 126
        , 'Irene'
        , 'Mikkilineni'
        , 'IMIKKILI'
        , '650.124.1224'
        , TO_DATE('28-SEP-1998', 'dd-MON-yyyy')
        , 'ST_CLERK'
        , 2700
        , NULL
        , 120
        , 50
        );

INSERT INTO employees VALUES 
        ( 127
        , 'James'
        , 'Landry'
        , 'JLANDRY'
        , '650.124.1334'
        , TO_DATE('14-JAN-1999', 'dd-MON-yyyy')
        , 'ST_CLERK'
        , 2400
        , NULL
        , 120
        , 50
        );

INSERT INTO employees VALUES 
        ( 128
        , 'Steven'
        , 'Markle'
        , 'SMARKLE'
        , '650.124.1434'
        , TO_DATE('08-MAR-2000', 'dd-MON-yyyy')
        , 'ST_CLERK'
        , 2200
        , NULL
        , 120
        , 50
        );

INSERT INTO employees VALUES 
        ( 129
        , 'Laura'
        , 'Bissot'
        , 'LBISSOT'
        , '650.124.5234'
        , TO_DATE('20-AUG-1997', 'dd-MON-yyyy')
        , 'ST_CLERK'
        , 3300
        , NULL
        , 121
        , 50
        );

INSERT INTO employees VALUES 
        ( 130
        , 'Mozhe'
        , 'Atkinson'
        , 'MATKINSO'
        , '650.124.6234'
        , TO_DATE('30-OCT-1997', 'dd-MON-yyyy')
        , 'ST_CLERK'
        , 2800
        , NULL
        , 121
        , 50
        );

INSERT INTO employees VALUES 
        ( 131
        , 'James'
        , 'Marlow'
        , 'JAMRLOW'
        , '650.124.7234'
        , TO_DATE('16-FEB-1997', 'dd-MON-yyyy')
        , 'ST_CLERK'
        , 2500
        , NULL
        , 121
        , 50
        );

INSERT INTO employees VALUES 
        ( 132
        , 'TJ'
        , 'Olson'
        , 'TJOLSON'
        , '650.124.8234'
        , TO_DATE('10-APR-1999', 'dd-MON-yyyy')
        , 'ST_CLERK'
        , 2100
        , NULL
        , 121
        , 50
        );

INSERT INTO employees VALUES 
        ( 133
        , 'Jason'
        , 'Mallin'
        , 'JMALLIN'
        , '650.127.1934'
        , TO_DATE('14-JUN-1996', 'dd-MON-yyyy')
        , 'ST_CLERK'
        , 3300
        , NULL
        , 122
        , 50
        );

INSERT INTO employees VALUES 
        ( 134
        , 'Michael'
        , 'Rogers'
        , 'MROGERS'
        , '650.127.1834'
        , TO_DATE('26-AUG-1998', 'dd-MON-yyyy')
        , 'ST_CLERK'
        , 2900
        , NULL
        , 122
        , 50
        );

INSERT INTO employees VALUES 
        ( 135
        , 'Ki'
        , 'Gee'
        , 'KGEE'
        , '650.127.1734'
        , TO_DATE('12-DEC-1999', 'dd-MON-yyyy')
        , 'ST_CLERK'
        , 2400
        , NULL
        , 122
        , 50
        );

INSERT INTO employees VALUES 
        ( 136
        , 'Hazel'
        , 'Philtanker'
        , 'HPHILTAN'
        , '650.127.1634'
        , TO_DATE('06-FEB-2000', 'dd-MON-yyyy')
        , 'ST_CLERK'
        , 2200
        , NULL
        , 122
        , 50
        );

INSERT INTO employees VALUES 
        ( 137
        , 'Renske'
        , 'Ladwig'
        , 'RLADWIG'
        , '650.121.1234'
        , TO_DATE('14-JUL-1995', 'dd-MON-yyyy')
        , 'ST_CLERK'
        , 3600
        , NULL
        , 123
        , 50
        );

INSERT INTO employees VALUES 
        ( 138
        , 'Stephen'
        , 'Stiles'
        , 'SSTILES'
        , '650.121.2034'
        , TO_DATE('26-OCT-1997', 'dd-MON-yyyy')
        , 'ST_CLERK'
        , 3200
        , NULL
        , 123
        , 50
        );

INSERT INTO employees VALUES 
        ( 139
        , 'John'
        , 'Seo'
        , 'JSEO'
        , '650.121.2019'
        , TO_DATE('12-FEB-1998', 'dd-MON-yyyy')
        , 'ST_CLERK'
        , 2700
        , NULL
        , 123
        , 50
        );

INSERT INTO employees VALUES 
        ( 140
        , 'Joshua'
        , 'Patel'
        , 'JPATEL'
        , '650.121.1834'
        , TO_DATE('06-APR-1998', 'dd-MON-yyyy')
        , 'ST_CLERK'
        , 2500
        , NULL
        , 123
        , 50
        );

INSERT INTO employees VALUES 
        ( 141
        , 'Trenna'
        , 'Rajs'
        , 'TRAJS'
        , '650.121.8009'
        , TO_DATE('17-OCT-1995', 'dd-MON-yyyy')
        , 'ST_CLERK'
        , 3500
        , NULL
        , 124
        , 50
        );

INSERT INTO employees VALUES 
        ( 142
        , 'Curtis'
        , 'Davies'
        , 'CDAVIES'
        , '650.121.2994'
        , TO_DATE('29-JAN-1997', 'dd-MON-yyyy')
        , 'ST_CLERK'
        , 3100
        , NULL
        , 124
        , 50
        );

INSERT INTO employees VALUES 
        ( 143
        , 'Randall'
        , 'Matos'
        , 'RMATOS'
        , '650.121.2874'
        , TO_DATE('15-MAR-1998', 'dd-MON-yyyy')
        , 'ST_CLERK'
        , 2600
        , NULL
        , 124
        , 50
        );

INSERT INTO employees VALUES 
        ( 144
        , 'Peter'
        , 'Vargas'
        , 'PVARGAS'
        , '650.121.2004'
        , TO_DATE('09-JUL-1998', 'dd-MON-yyyy')
        , 'ST_CLERK'
        , 2500
        , NULL
        , 124
        , 50
        );

INSERT INTO employees VALUES 
        ( 145
        , 'John'
        , 'Russell'
        , 'JRUSSEL'
        , '011.44.1344.429268'
        , TO_DATE('01-OCT-1996', 'dd-MON-yyyy')
        , 'SA_MAN'
        , 14000
        , .4
        , 100
        , 80
        );

INSERT INTO employees VALUES 
        ( 146
        , 'Karen'
        , 'Partners'
        , 'KPARTNER'
        , '011.44.1344.467268'
        , TO_DATE('05-JAN-1997', 'dd-MON-yyyy')
        , 'SA_MAN'
        , 13500
        , .3
        , 100
        , 80
        );

INSERT INTO employees VALUES 
        ( 147
        , 'Alberto'
        , 'Errazuriz'
        , 'AERRAZUR'
        , '011.44.1344.429278'
        , TO_DATE('10-MAR-1997', 'dd-MON-yyyy')
        , 'SA_MAN'
        , 12000
        , .3
        , 100
        , 80
        );

INSERT INTO employees VALUES 
        ( 148
        , 'Gerald'
        , 'Cambrault'
        , 'GCAMBRAU'
        , '011.44.1344.619268'
        , TO_DATE('15-OCT-1999', 'dd-MON-yyyy')
        , 'SA_MAN'
        , 11000
        , .3
        , 100
        , 80
        );

INSERT INTO employees VALUES 
        ( 149
        , 'Eleni'
        , 'Zlotkey'
        , 'EZLOTKEY'
        , '011.44.1344.429018'
        , TO_DATE('29-JAN-2000', 'dd-MON-yyyy')
        , 'SA_MAN'
        , 10500
        , .2
        , 100
        , 80
        );

INSERT INTO employees VALUES 
        ( 150
        , 'Peter'
        , 'Tucker'
        , 'PTUCKER'
        , '011.44.1344.129268'
        , TO_DATE('30-JAN-1997', 'dd-MON-yyyy')
        , 'SA_REP'
        , 10000
        , .3
        , 145
        , 80
        );

INSERT INTO employees VALUES 
        ( 151
        , 'David'
        , 'Bernstein'
        , 'DBERNSTE'
        , '011.44.1344.345268'
        , TO_DATE('24-MAR-1997', 'dd-MON-yyyy')
        , 'SA_REP'
        , 9500
        , .25
        , 145
        , 80
        );

INSERT INTO employees VALUES 
        ( 152
        , 'Peter'
        , 'Hall'
        , 'PHALL'
        , '011.44.1344.478968'
        , TO_DATE('20-AUG-1997', 'dd-MON-yyyy')
        , 'SA_REP'
        , 9000
        , .25
        , 145
        , 80
        );

INSERT INTO employees VALUES 
        ( 153
        , 'Christopher'
        , 'Olsen'
        , 'COLSEN'
        , '011.44.1344.498718'
        , TO_DATE('30-MAR-1998', 'dd-MON-yyyy')
        , 'SA_REP'
        , 8000
        , .2
        , 145
        , 80
        );

INSERT INTO employees VALUES 
        ( 154
        , 'Nanette'
        , 'Cambrault'
        , 'NCAMBRAU'
        , '011.44.1344.987668'
        , TO_DATE('09-DEC-1998', 'dd-MON-yyyy')
        , 'SA_REP'
        , 7500
        , .2
        , 145
        , 80
        );

INSERT INTO employees VALUES 
        ( 155
        , 'Oliver'
        , 'Tuvault'
        , 'OTUVAULT'
        , '011.44.1344.486508'
        , TO_DATE('23-NOV-1999', 'dd-MON-yyyy')
        , 'SA_REP'
        , 7000
        , .15
        , 145
        , 80
        );

INSERT INTO employees VALUES 
        ( 156
        , 'Janette'
        , 'King'
        , 'JKING'
        , '011.44.1345.429268'
        , TO_DATE('30-JAN-1996', 'dd-MON-yyyy')
        , 'SA_REP'
        , 10000
        , .35
        , 146
        , 80
        );

INSERT INTO employees VALUES 
        ( 157
        , 'Patrick'
        , 'Sully'
        , 'PSULLY'
        , '011.44.1345.929268'
        , TO_DATE('04-MAR-1996', 'dd-MON-yyyy')
        , 'SA_REP'
        , 9500
        , .35
        , 146
        , 80
        );

INSERT INTO employees VALUES 
        ( 158
        , 'Allan'
        , 'McEwen'
        , 'AMCEWEN'
        , '011.44.1345.829268'
        , TO_DATE('01-AUG-1996', 'dd-MON-yyyy')
        , 'SA_REP'
        , 9000
        , .35
        , 146
        , 80
        );

INSERT INTO employees VALUES 
        ( 159
        , 'Lindsey'
        , 'Smith'
        , 'LSMITH'
        , '011.44.1345.729268'
        , TO_DATE('10-MAR-1997', 'dd-MON-yyyy')
        , 'SA_REP'
        , 8000
        , .3
        , 146
        , 80
        );

INSERT INTO employees VALUES 
        ( 160
        , 'Louise'
        , 'Doran'
        , 'LDORAN'
        , '011.44.1345.629268'
        , TO_DATE('15-DEC-1997', 'dd-MON-yyyy')
        , 'SA_REP'
        , 7500
        , .3
        , 146
        , 80
        );

INSERT INTO employees VALUES 
        ( 161
        , 'Sarath'
        , 'Sewall'
        , 'SSEWALL'
        , '011.44.1345.529268'
        , TO_DATE('03-NOV-1998', 'dd-MON-yyyy')
        , 'SA_REP'
        , 7000
        , .25
        , 146
        , 80
        );

INSERT INTO employees VALUES 
        ( 162
        , 'Clara'
        , 'Vishney'
        , 'CVISHNEY'
        , '011.44.1346.129268'
        , TO_DATE('11-NOV-1997', 'dd-MON-yyyy')
        , 'SA_REP'
        , 10500
        , .25
        , 147
        , 80
        );

INSERT INTO employees VALUES 
        ( 163
        , 'Danielle'
        , 'Greene'
        , 'DGREENE'
        , '011.44.1346.229268'
        , TO_DATE('19-MAR-1999', 'dd-MON-yyyy')
        , 'SA_REP'
        , 9500
        , .15
        , 147
        , 80
        );

INSERT INTO employees VALUES 
        ( 164
        , 'Mattea'
        , 'Marvins'
        , 'MMARVINS'
        , '011.44.1346.329268'
        , TO_DATE('24-JAN-2000', 'dd-MON-yyyy')
        , 'SA_REP'
        , 7200
        , .10
        , 147
        , 80
        );

INSERT INTO employees VALUES 
        ( 165
        , 'David'
        , 'Lee'
        , 'DLEE'
        , '011.44.1346.529268'
        , TO_DATE('23-FEB-2000', 'dd-MON-yyyy')
        , 'SA_REP'
        , 6800
        , .1
        , 147
        , 80
        );

INSERT INTO employees VALUES 
        ( 166
        , 'Sundar'
        , 'Ande'
        , 'SANDE'
        , '011.44.1346.629268'
        , TO_DATE('24-MAR-2000', 'dd-MON-yyyy')
        , 'SA_REP'
        , 6400
        , .10
        , 147
        , 80
        );

INSERT INTO employees VALUES 
        ( 167
        , 'Amit'
        , 'Banda'
        , 'ABANDA'
        , '011.44.1346.729268'
        , TO_DATE('21-APR-2000', 'dd-MON-yyyy')
        , 'SA_REP'
        , 6200
        , .10
        , 147
        , 80
        );

INSERT INTO employees VALUES 
        ( 168
        , 'Lisa'
        , 'Ozer'
        , 'LOZER'
        , '011.44.1343.929268'
        , TO_DATE('11-MAR-1997', 'dd-MON-yyyy')
        , 'SA_REP'
        , 11500
        , .25
        , 148
        , 80
        );

INSERT INTO employees VALUES 
        ( 169  
        , 'Harrison'
        , 'Bloom'
        , 'HBLOOM'
        , '011.44.1343.829268'
        , TO_DATE('23-MAR-1998', 'dd-MON-yyyy')
        , 'SA_REP'
        , 10000
        , .20
        , 148
        , 80
        );

INSERT INTO employees VALUES 
        ( 170
        , 'Tayler'
        , 'Fox'
        , 'TFOX'
        , '011.44.1343.729268'
        , TO_DATE('24-JAN-1998', 'dd-MON-yyyy')
        , 'SA_REP'
        , 9600
        , .20
        , 148
        , 80
        );

INSERT INTO employees VALUES 
        ( 171
        , 'William'
        , 'Smith'
        , 'WSMITH'
        , '011.44.1343.629268'
        , TO_DATE('23-FEB-1999', 'dd-MON-yyyy')
        , 'SA_REP'
        , 7400
        , .15
        , 148
        , 80
        );

INSERT INTO employees VALUES 
        ( 172
        , 'Elizabeth'
        , 'Bates'
        , 'EBATES'
        , '011.44.1343.529268'
        , TO_DATE('24-MAR-1999', 'dd-MON-yyyy')
        , 'SA_REP'
        , 7300
        , .15
        , 148
        , 80
        );

INSERT INTO employees VALUES 
        ( 173
        , 'Sundita'
        , 'Kumar'
        , 'SKUMAR'
        , '011.44.1343.329268'
        , TO_DATE('21-APR-2000', 'dd-MON-yyyy')
        , 'SA_REP'
        , 6100
        , .10
        , 148
        , 80
        );

INSERT INTO employees VALUES 
        ( 174
        , 'Ellen'
        , 'Abel'
        , 'EABEL'
        , '011.44.1644.429267'
        , TO_DATE('11-MAY-1996', 'dd-MON-yyyy')
        , 'SA_REP'
        , 11000
        , .30
        , 149
        , 80
        );

INSERT INTO employees VALUES 
        ( 175
        , 'Alyssa'
        , 'Hutton'
        , 'AHUTTON'
        , '011.44.1644.429266'
        , TO_DATE('19-MAR-1997', 'dd-MON-yyyy')
        , 'SA_REP'
        , 8800
        , .25
        , 149
        , 80
        );

INSERT INTO employees VALUES 
        ( 176
        , 'Jonathon'
        , 'Taylor'
        , 'JTAYLOR'
        , '011.44.1644.429265'
        , TO_DATE('24-MAR-1998', 'dd-MON-yyyy')
        , 'SA_REP'
        , 8600
        , .20
        , 149
        , 80
        );

INSERT INTO employees VALUES 
        ( 177
        , 'Jack'
        , 'Livingston'
        , 'JLIVINGS'
        , '011.44.1644.429264'
        , TO_DATE('23-APR-1998', 'dd-MON-yyyy')
        , 'SA_REP'
        , 8400
        , .20
        , 149
        , 80
        );

INSERT INTO employees VALUES 
        ( 178
        , 'Kimberely'
        , 'Grant'
        , 'KGRANT'
        , '011.44.1644.429263'
        , TO_DATE('24-MAY-1999', 'dd-MON-yyyy')
        , 'SA_REP'
        , 7000
        , .15
        , 149
        , NULL
        );

INSERT INTO employees VALUES 
        ( 179
        , 'Charles'
        , 'Johnson'
        , 'CJOHNSON'
        , '011.44.1644.429262'
        , TO_DATE('04-JAN-2000', 'dd-MON-yyyy')
        , 'SA_REP'
        , 6200
        , .10
        , 149
        , 80
        );

INSERT INTO employees VALUES 
        ( 180
        , 'Winston'
        , 'Taylor'
        , 'WTAYLOR'
        , '650.507.9876'
        , TO_DATE('24-JAN-1998', 'dd-MON-yyyy')
        , 'SH_CLERK'
        , 3200
        , NULL
        , 120
        , 50
        );

INSERT INTO employees VALUES 
        ( 181
        , 'Jean'
        , 'Fleaur'
        , 'JFLEAUR'
        , '650.507.9877'
        , TO_DATE('23-FEB-1998', 'dd-MON-yyyy')
        , 'SH_CLERK'
        , 3100
        , NULL
        , 120
        , 50
        );

INSERT INTO employees VALUES 
        ( 182
        , 'Martha'
        , 'Sullivan'
        , 'MSULLIVA'
        , '650.507.9878'
        , TO_DATE('21-JUN-1999', 'dd-MON-yyyy')
        , 'SH_CLERK'
        , 2500
        , NULL
        , 120
        , 50
        );

INSERT INTO employees VALUES 
        ( 183
        , 'Girard'
        , 'Geoni'
        , 'GGEONI'
        , '650.507.9879'
        , TO_DATE('03-FEB-2000', 'dd-MON-yyyy')
        , 'SH_CLERK'
        , 2800
        , NULL
        , 120
        , 50
        );

INSERT INTO employees VALUES 
        ( 184
        , 'Nandita'
        , 'Sarchand'
        , 'NSARCHAN'
        , '650.509.1876'
        , TO_DATE('27-JAN-1996', 'dd-MON-yyyy')
        , 'SH_CLERK'
        , 4200
        , NULL
        , 121
        , 50
        );

INSERT INTO employees VALUES 
        ( 185
        , 'Alexis'
        , 'Bull'
        , 'ABULL'
        , '650.509.2876'
        , TO_DATE('20-FEB-1997', 'dd-MON-yyyy')
        , 'SH_CLERK'
        , 4100
        , NULL
        , 121
        , 50
        );

INSERT INTO employees VALUES 
        ( 186
        , 'Julia'
        , 'Dellinger'
        , 'JDELLING'
        , '650.509.3876'
        , TO_DATE('24-JUN-1998', 'dd-MON-yyyy')
        , 'SH_CLERK'
        , 3400
        , NULL
        , 121
        , 50
        );

INSERT INTO employees VALUES 
        ( 187
        , 'Anthony'
        , 'Cabrio'
        , 'ACABRIO'
        , '650.509.4876'
        , TO_DATE('07-FEB-1999', 'dd-MON-yyyy')
        , 'SH_CLERK'
        , 3000
        , NULL
        , 121
        , 50
        );

INSERT INTO employees VALUES 
        ( 188
        , 'Kelly'
        , 'Chung'
        , 'KCHUNG'
        , '650.505.1876'
        , TO_DATE('14-JUN-1997', 'dd-MON-yyyy')
        , 'SH_CLERK'
        , 3800
        , NULL
        , 122
        , 50
        );

INSERT INTO employees VALUES 
        ( 189
        , 'Jennifer'
        , 'Dilly'
        , 'JDILLY'
        , '650.505.2876'
        , TO_DATE('13-AUG-1997', 'dd-MON-yyyy')
        , 'SH_CLERK'
        , 3600
        , NULL
        , 122
        , 50
        );

INSERT INTO employees VALUES 
        ( 190
        , 'Timothy'
        , 'Gates'
        , 'TGATES'
        , '650.505.3876'
        , TO_DATE('11-JUL-1998', 'dd-MON-yyyy')
        , 'SH_CLERK'
        , 2900
        , NULL
        , 122
        , 50
        );

INSERT INTO employees VALUES 
        ( 191
        , 'Randall'
        , 'Perkins'
        , 'RPERKINS'
        , '650.505.4876'
        , TO_DATE('19-DEC-1999', 'dd-MON-yyyy')
        , 'SH_CLERK'
        , 2500
        , NULL
        , 122
        , 50
        );

INSERT INTO employees VALUES 
        ( 192
        , 'Sarah'
        , 'Bell'
        , 'SBELL'
        , '650.501.1876'
        , TO_DATE('04-FEB-1996', 'dd-MON-yyyy')
        , 'SH_CLERK'
        , 4000
        , NULL
        , 123
        , 50
        );

INSERT INTO employees VALUES 
        ( 193
        , 'Britney'
        , 'Everett'
        , 'BEVERETT'
        , '650.501.2876'
        , TO_DATE('03-MAR-1997', 'dd-MON-yyyy')
        , 'SH_CLERK'
        , 3900
        , NULL
        , 123
        , 50
        );

INSERT INTO employees VALUES 
        ( 194
        , 'Samuel'
        , 'McCain'
        , 'SMCCAIN'
        , '650.501.3876'
        , TO_DATE('01-JUL-1998', 'dd-MON-yyyy')
        , 'SH_CLERK'
        , 3200
        , NULL
        , 123
        , 50
        );

INSERT INTO employees VALUES 
        ( 195
        , 'Vance'
        , 'Jones'
        , 'VJONES'
        , '650.501.4876'
        , TO_DATE('17-MAR-1999', 'dd-MON-yyyy')
        , 'SH_CLERK'
        , 2800
        , NULL
        , 123
        , 50
        );

INSERT INTO employees VALUES 
        ( 196
        , 'Alana'
        , 'Walsh'
        , 'AWALSH'
        , '650.507.9811'
        , TO_DATE('24-APR-1998', 'dd-MON-yyyy')
        , 'SH_CLERK'
        , 3100
        , NULL
        , 124
        , 50
        );

INSERT INTO employees VALUES 
        ( 197
        , 'Kevin'
        , 'Feeney'
        , 'KFEENEY'
        , '650.507.9822'
        , TO_DATE('23-MAY-1998', 'dd-MON-yyyy')
        , 'SH_CLERK'
        , 3000
        , NULL
        , 124
        , 50
        );

INSERT INTO employees VALUES 
        ( 198
        , 'Donald'
        , 'OConnell'
        , 'DOCONNEL'
        , '650.507.9833'
        , TO_DATE('21-JUN-1999', 'dd-MON-yyyy')
        , 'SH_CLERK'
        , 2600
        , NULL
        , 124
        , 50
        );

INSERT INTO employees VALUES 
        ( 199
        , 'Douglas'
        , 'Grant'
        , 'DGRANT'
        , '650.507.9844'
        , TO_DATE('13-JAN-2000', 'dd-MON-yyyy')
        , 'SH_CLERK'
        , 2600
        , NULL
        , 124
        , 50
        );

INSERT INTO employees VALUES 
        ( 200
        , 'Jennifer'
        , 'Whalen'
        , 'JWHALEN'
        , '515.123.4444'
        , TO_DATE('17-SEP-1987', 'dd-MON-yyyy')
        , 'AD_ASST'
        , 4400
        , NULL
        , 101
        , 10
        );

INSERT INTO employees VALUES 
        ( 201
        , 'Michael'
        , 'Hartstein'
        , 'MHARTSTE'
        , '515.123.5555'
        , TO_DATE('17-FEB-1996', 'dd-MON-yyyy')
        , 'MK_MAN'
        , 13000
        , NULL
        , 100
        , 20
        );

INSERT INTO employees VALUES 
        ( 202
        , 'Pat'
        , 'Fay'
        , 'PFAY'
        , '603.123.6666'
        , TO_DATE('17-AUG-1997', 'dd-MON-yyyy')
        , 'MK_REP'
        , 6000
        , NULL
        , 201
        , 20
        );

INSERT INTO employees VALUES 
        ( 203
        , 'Susan'
        , 'Mavris'
        , 'SMAVRIS'
        , '515.123.7777'
        , TO_DATE('07-JUN-1994', 'dd-MON-yyyy')
        , 'HR_REP'
        , 6500
        , NULL
        , 101
        , 40
        );

INSERT INTO employees VALUES 
        ( 204
        , 'Hermann'
        , 'Baer'
        , 'HBAER'
        , '515.123.8888'
        , TO_DATE('07-JUN-1994', 'dd-MON-yyyy')
        , 'PR_REP'
        , 10000
        , NULL
        , 101
        , 70
        );

INSERT INTO employees VALUES 
        ( 205
        , 'Shelley'
        , 'Higgins'
        , 'SHIGGINS'
        , '515.123.8080'
        , TO_DATE('07-JUN-1994', 'dd-MON-yyyy')
        , 'AC_MGR'
        , 12000
        , NULL
        , 101
        , 110
        );

INSERT INTO employees VALUES 
        ( 206
        , 'William'
        , 'Gietz'
        , 'WGIETZ'
        , '515.123.8181'
        , TO_DATE('07-JUN-1994', 'dd-MON-yyyy')
        , 'AC_ACCOUNT'
        , 8300
        , NULL
        , 205
        , 110
        );

INSERT INTO job_history
VALUES (102
       , TO_DATE('13-JAN-1993', 'dd-MON-yyyy')
       , TO_DATE('24-JUL-1998', 'dd-MON-yyyy')
       , 'IT_PROG'
       , 60);

INSERT INTO job_history
VALUES (101
       , TO_DATE('21-SEP-1989', 'dd-MON-yyyy')
       , TO_DATE('27-OCT-1993', 'dd-MON-yyyy')
       , 'AC_ACCOUNT'
       , 110);

INSERT INTO job_history
VALUES (101
       , TO_DATE('28-OCT-1993', 'dd-MON-yyyy')
       , TO_DATE('15-MAR-1997', 'dd-MON-yyyy')
       , 'AC_MGR'
       , 110);

INSERT INTO job_history
VALUES (201
       , TO_DATE('17-FEB-1996', 'dd-MON-yyyy')
       , TO_DATE('19-DEC-1999', 'dd-MON-yyyy')
       , 'MK_REP'
       , 20);

INSERT INTO job_history
VALUES  (114
        , TO_DATE('24-MAR-1998', 'dd-MON-yyyy')
        , TO_DATE('31-DEC-1999', 'dd-MON-yyyy')
        , 'ST_CLERK'
        , 50
        );

INSERT INTO job_history
VALUES  (122
        , TO_DATE('01-JAN-1999', 'dd-MON-yyyy')
        , TO_DATE('31-DEC-1999', 'dd-MON-yyyy')
        , 'ST_CLERK'
        , 50
        );

INSERT INTO job_history
VALUES  (200
        , TO_DATE('17-SEP-1987', 'dd-MON-yyyy')
        , TO_DATE('17-JUN-1993', 'dd-MON-yyyy')
        , 'AD_ASST'
        , 90
        );

INSERT INTO job_history
VALUES  (176
        , TO_DATE('24-MAR-1998', 'dd-MON-yyyy')
        , TO_DATE('31-DEC-1998', 'dd-MON-yyyy')
        , 'SA_REP'
        , 80
        );

INSERT INTO job_history
VALUES  (176
        , TO_DATE('01-JAN-1999', 'dd-MON-yyyy')
        , TO_DATE('31-DEC-1999', 'dd-MON-yyyy')
        , 'SA_MAN'
        , 80
        );

INSERT INTO job_history
VALUES  (200
        , TO_DATE('01-JUL-1994', 'dd-MON-yyyy')
        , TO_DATE('31-DEC-1998', 'dd-MON-yyyy')
        , 'AC_ACCOUNT'
        , 90
        );



ALTER TABLE departments 
  ENABLE CONSTRAINT dept_mgr_fk;

COMMIT;



SET FEEDBACK 1
SET NUMWIDTH 10
SET LINESIZE 80
SET TRIMSPOOL ON
SET TAB OFF
SET PAGESIZE 100
SET ECHO OFF 

CREATE INDEX emp_department_ix
       ON employees (department_id);

CREATE INDEX emp_job_ix
       ON employees (job_id);

CREATE INDEX emp_manager_ix
       ON employees (manager_id);

CREATE INDEX emp_name_ix
       ON employees (last_name, first_name);

CREATE INDEX dept_location_ix
       ON departments (location_id);

CREATE INDEX jhist_job_ix
       ON job_history (job_id);

CREATE INDEX jhist_employee_ix
       ON job_history (employee_id);

CREATE INDEX jhist_department_ix
       ON job_history (department_id);

CREATE INDEX loc_city_ix
       ON locations (city);

CREATE INDEX loc_state_province_ix	
       ON locations (state_province);

CREATE INDEX loc_country_ix
       ON locations (country_id);

COMMIT;





SET FEEDBACK 1
SET NUMWIDTH 10
SET LINESIZE 80
SET TRIMSPOOL ON
SET TAB OFF
SET PAGESIZE 100
SET ECHO OFF


CREATE OR REPLACE PROCEDURE secure_dml
IS
BEGIN
  IF TO_CHAR (SYSDATE, 'HH24:MI') NOT BETWEEN '08:00' AND '18:00'
        OR TO_CHAR (SYSDATE, 'DY') IN ('SAT', 'SUN') THEN
	RAISE_APPLICATION_ERROR (-20205, 
		'You may only make changes during normal office hours');
  END IF;
END secure_dml;
/

CREATE OR REPLACE TRIGGER secure_employees
  BEFORE INSERT OR UPDATE OR DELETE ON employees
BEGIN
  secure_dml;
END secure_employees;
/

CREATE OR REPLACE PROCEDURE add_job_history
  (  p_emp_id          job_history.employee_id%type
   , p_start_date      job_history.start_date%type
   , p_end_date        job_history.end_date%type
   , p_job_id          job_history.job_id%type
   , p_department_id   job_history.department_id%type 
   )
IS
BEGIN
  INSERT INTO job_history (employee_id, start_date, end_date, 
                           job_id, department_id)
    VALUES(p_emp_id, p_start_date, p_end_date, p_job_id, p_department_id);
END add_job_history;
/

CREATE OR REPLACE TRIGGER update_job_history
  AFTER UPDATE OF job_id, department_id ON employees
  FOR EACH ROW
BEGIN
  add_job_history(:old.employee_id, :old.hire_date, sysdate, 
                  :old.job_id, :old.department_id);
END;
/

COMMIT;





SET FEEDBACK 1
SET NUMWIDTH 10
SET LINESIZE 80
SET TRIMSPOOL ON
SET TAB OFF
SET PAGESIZE 100
SET ECHO OFF 

COMMENT ON TABLE regions 
IS 'Regions table that contains region numbers and names. Contains 4 rows; references with the Countries table.';

COMMENT ON COLUMN regions.region_id
IS 'Primary key of regions table.';

COMMENT ON COLUMN regions.region_name
IS 'Names of regions. Locations are in the countries of these regions.';

COMMENT ON TABLE locations
IS 'Locations table that contains specific address of a specific office,
warehouse, and/or production site of a company. Does not store addresses /
locations of customers. Contains 23 rows; references with the
departments and countries tables. ';

COMMENT ON COLUMN locations.location_id
IS 'Primary key of locations table';

COMMENT ON COLUMN locations.street_address
IS 'Street address of an office, warehouse, or production site of a company.
Contains building number and street name';

COMMENT ON COLUMN locations.postal_code
IS 'Postal code of the location of an office, warehouse, or production site 
of a company. ';

COMMENT ON COLUMN locations.city
IS 'A not null column that shows city where an office, warehouse, or 
production site of a company is located. ';

COMMENT ON COLUMN locations.state_province
IS 'State or Province where an office, warehouse, or production site of a 
company is located.';

COMMENT ON COLUMN locations.country_id
IS 'Country where an office, warehouse, or production site of a company is
located. Foreign key to country_id column of the countries table.';


COMMENT ON TABLE departments
IS 'Departments table that shows details of departments where employees 
work. Contains 27 rows; references with locations, employees, and job_history tables.';

COMMENT ON COLUMN departments.department_id
IS 'Primary key column of departments table.';

COMMENT ON COLUMN departments.department_name
IS 'A not null column that shows name of a department. Administration, 
Marketing, Purchasing, Human Resources, Shipping, IT, Executive, Public 
Relations, Sales, Finance, and Accounting. ';

COMMENT ON COLUMN departments.manager_id
IS 'Manager_id of a department. Foreign key to employee_id column of employees table. The manager_id column of the employee table references this column.';

COMMENT ON COLUMN departments.location_id
IS 'Location id where a department is located. Foreign key to location_id column of locations table.';


COMMENT ON TABLE job_history
IS 'Table that stores job history of the employees. If an employee 
changes departments within the job or changes jobs within the department, 
new rows get inserted into this table with old job information of the 
employee. Contains a complex primary key: employee_id+start_date.
Contains 25 rows. References with jobs, employees, and departments tables.';

COMMENT ON COLUMN job_history.employee_id
IS 'A not null column in the complex primary key employee_id+start_date.
Foreign key to employee_id column of the employee table';

COMMENT ON COLUMN job_history.start_date
IS 'A not null column in the complex primary key employee_id+start_date. 
Must be less than the end_date of the job_history table. (enforced by 
constraint jhist_date_interval)';

COMMENT ON COLUMN job_history.end_date
IS 'Last day of the employee in this job role. A not null column. Must be 
greater than the start_date of the job_history table. 
(enforced by constraint jhist_date_interval)';

COMMENT ON COLUMN job_history.job_id
IS 'Job role in which the employee worked in the past; foreign key to 
job_id column in the jobs table. A not null column.';

COMMENT ON COLUMN job_history.department_id
IS 'Department id in which the employee worked in the past; foreign key to deparment_id column in the departments table';


COMMENT ON TABLE countries
IS 'country table. Contains 25 rows. References with locations table.';

COMMENT ON COLUMN countries.country_id
IS 'Primary key of countries table.';

COMMENT ON COLUMN countries.country_name
IS 'Country name';

COMMENT ON COLUMN countries.region_id
IS 'Region ID for the country. Foreign key to region_id column in the departments table.';

COMMENT ON TABLE jobs
IS 'jobs table with job titles and salary ranges. Contains 19 rows.
References with employees and job_history table.';

COMMENT ON COLUMN jobs.job_id
IS 'Primary key of jobs table.';

COMMENT ON COLUMN jobs.job_title
IS 'A not null column that shows job title, e.g. AD_VP, FI_ACCOUNTANT';

COMMENT ON COLUMN jobs.min_salary
IS 'Minimum salary for a job title.';

COMMENT ON COLUMN jobs.max_salary
IS 'Maximum salary for a job title';

COMMENT ON TABLE employees
IS 'employees table. Contains 107 rows. References with departments, 
jobs, job_history tables. Contains a self reference.';

COMMENT ON COLUMN employees.employee_id
IS 'Primary key of employees table.';

COMMENT ON COLUMN employees.first_name
IS 'First name of the employee. A not null column.';

COMMENT ON COLUMN employees.last_name
IS 'Last name of the employee. A not null column.';

COMMENT ON COLUMN employees.email
IS 'Email id of the employee';

COMMENT ON COLUMN employees.phone_number
IS 'Phone number of the employee; includes country code and area code';

COMMENT ON COLUMN employees.hire_date
IS 'Date when the employee started on this job. A not null column.';

COMMENT ON COLUMN employees.job_id
IS 'Current job of the employee; foreign key to job_id column of the 
jobs table. A not null column.';

COMMENT ON COLUMN employees.salary
IS 'Monthly salary of the employee. Must be greater 
than zero (enforced by constraint emp_salary_min)';

COMMENT ON COLUMN employees.commission_pct
IS 'Commission percentage of the employee; Only employees in sales 
department elgible for commission percentage';

COMMENT ON COLUMN employees.manager_id
IS 'Manager id of the employee; has same domain as manager_id in 
departments table. Foreign key to employee_id column of employees table.
(useful for reflexive joins and CONNECT BY query)';

COMMENT ON COLUMN employees.department_id
IS 'Department id where employee works; foreign key to department_id 
column of the departments table';

COMMIT;





ALTER TABLE departments
DISABLE CONSTRAINT DEPT_MGR_FK;

ALTER TABLE job_history
DISABLE CONSTRAINT JHIST_EMP_FK;

DROP TRIGGER secure_employees;

DROP TRIGGER update_job_history;

DROP PROCEDURE add_job_history;

DROP PROCEDURE secure_dml;

--DELETE FROM employees
--WHERE manager_id IN (108, 114, 120, 121, 122, 123, 145, 146, 147, 148);
--
--DELETE FROM employees
--WHERE employee_id IN (114, 120, 121, 122, 123, 145, 146, 147, 148, 
--                      196, 197, 198, 199, 105, 106, 108, 175, 177, 
--                      179, 203, 204);

--DELETE FROM locations
--WHERE location_id NOT IN 
--  (SELECT DISTINCT location_id
--   FROM departments);
--
--DELETE FROM countries
--WHERE country_id NOT IN
--  (SELECT country_id
--   FROM locations);
--
--DELETE FROM jobs
--WHERE job_id NOT IN
--  (SELECT job_id
--   FROM employees);
--
--DELETE FROM departments
--WHERE department_id NOT IN 
--  (SELECT DISTINCT department_id
--   FROM employees
--   WHERE department_id IS NOT NULL);
--
--UPDATE departments
--SET manager_id = 124
--WHERE department_id = 50;
--
--UPDATE departments
--SET manager_id = 149
--WHERE department_id = 80;
--
--DELETE FROM locations
--WHERE location_id IN (2700, 2400);
--
--UPDATE locations
--SET street_address = '460 Bloor St. W.', 
--    postal_code = 'ON M5S 1X8'
--WHERE location_id = 1800;

ALTER TABLE departments
ENABLE CONSTRAINT DEPT_MGR_FK;

CREATE TABLE job_grades
(grade_level VARCHAR2(3),
 lowest_sal  NUMBER,
 highest_sal NUMBER);

INSERT INTO job_grades
VALUES ('A', 1000, 2999);

INSERT INTO job_grades
VALUES ('B', 3000, 5999);

INSERT INTO job_grades
VALUES('C', 6000, 9999);

INSERT INTO job_grades
VALUES('D', 10000, 14999);

INSERT INTO job_grades
VALUES('E', 15000, 24999);

INSERT INTO job_grades
VALUES('F', 25000, 40000);

--INSERT INTO departments VALUES 
--        ( 190 
--        , 'Contracting'
--        , NULL
--        , 1700
--        );

COMMIT;

select count(*) NUM_EMP from employees;
select count(*) NUM_DEP from departments;
select count(*) NUM_LOC from locations;
select count(*) NUM_REG from regions;
select count(*) NUM_CTR from countries;
select count(*) NUM_JOB from jobs;
select count(*) NUM_JH from job_history;




select * from employees;

-- Simth 사원의 사원번호와 이름(last_name)을 조회
select employee_id, employee_name from employees where last_name='Smith';

-- 별칭(alias)사용
select employee_id "사원번호", salary "급여" from employees where name='Simth';

select employee_id as "사원번호", salary as "급여" from employees where last_name = 'Simth';

-- distnct를 사용한 중복 제거
select job_id from employees; 

select distinct job_id from employees;

-- 급여가 5000이상인 사원의 성, 이름, 급여 조회
select last_name, first_name, salary from employees where salary >= 5000;

-- 1994년 1얼 1일 이후에 입사한 사원만 사원의 성, 이름, 입사날짜를 조회
select last_name, first_name, hire_date from employees where hire_date >= '94/01/01';

-- and 연산자 사용
-- 50번 부서의 사원중에서 직업이 'SH_CLERK'인 사원의 성, 이름, ,직업ID, 부서ID를 조회
select last_name, first_name, job_id, department_id from employees where job_id = 'SH_CLERK' and department_id = 50;

-- or 연산자 사용
-- 부서번호가 50번 이거나, 상사ID가 100인 사원의 이름, 성, 매니저ID, 부서ID를 조회
select last_name, first_name, manager_id, department_id from employees where department_id = 50 or manager_id = 100;

-- not 연산자 사용
-- 50번 부서가 아닌 사원들의 이름, 성, 직업, 부서번호를 조회
select * from employees where not department_id = 50;
-- where department_id <> 50;/ != / ^=

-- 급여를 4000 이상, 8000 이하인 사원들의 이름, 성, 급여 조회
select last_name, first_name, salary from employees where salary between 4000 and 8000;
-- where salary >= 4000 and salary <= 8000;

-- 급여가 6500, 7700, 13000인 사원들의 이름, 성, 급여 조회
select last_name, first_name, salary from employees where salary=6500 or salary=7700 or salary=13000;
-- where salary in (6500, 7700, 1300);

-- 이름이 D로 시작하는 사원의 이름, 성, 직업 조회
select last_name, first_name, job_id from employees where last_name like 'D%';
select last_name, first_name, job_id from employees where last_name like 'D____';

-- 보너스를 받지 않는 사원의 이름, 성, 보너스 조회
select last_name, first_name, commission_pct from employees where commission_pct is null;

-- 정렬(order by): asc(오름차순), desc(내림차순)
-- 사원번호가 적은 순서대로 사원번호와 이름, 성을 조회
select last_name, first_name from employees order by employee_id;

-- 월급을 많이 받는 순서대로 사원번호, 이름, 성, 급여, 직업, 부서번호 조회
select last_name, first_name, salary, job_id, department_id from employees order by salary desc;

-- 집계(=그룹) 함수: sum, avg, count, max, min
select count(first_name), trunc(avg(salary)), sum(salary), max(salary), min(salary) from employees;

select count(*) from employees; -- 모든것
select count(commission_pct) from employees; -- null은 카운트 안함
select count(first_name), count(distinct first_name) from employees; -- distince 중복 제거
select avg(salary) from employees;
select count(*) from employees where department_id = 80;

-- 80번 부서에서 가장 급여가 높은 사원조회
select max(salary) from employees where department_id = 80;
-- 80번 부서에서 가장 급여가 작은 사원 조회
select min(salary) from employees where department_id = 80;

-- 가장 최근에 입사한 사원의 입사날짜(신입사원) 조회
select max(hire_date) from employees;
-- 가자 오래전에 입사한 사원의 입사날짜(왕고참) 조회
select min(hire_date) from employees;
select max(hire_date) as "신입사원", min(hire_date) "고참사원", trunc((max(hire_date)-min(hire_date))/365) from employees;
-- 집계함수끼리 같이 사용 가능

-- 집계합수는 where절에 사용 불가
select employee_id, first_name from employees where salary = max(salary); -- 에러발생

-- 숫자 함수: abs()-절대값, round()-반올림, trunc()-절삭
select -23, 23 from dual;
select sign(-23), sign(23), 0 from dual; -- sign(값) 함수 = 양수:1, 음수:-1, -:0
select round(0.153), round(0.543) from dual;
select round(0.153, 1), round(0.543, 1) from dual;
select round(0.12345678, 0), round(2.3423455, 4) from dual;

-- trunc() 함수: 절삭 -0은 소수점을 절삭, 양수는 오른쪽으로 이동하여 절삭, 음수는 왼쪽으로 이동해서 절삭
select trunc(1234.9234567, 0), trunc(1234.9234567, 1), round(1234.9234567, -1) from dual;
select trunc(1234.9234567), trunc(1234.9234567, 2), round(1234.9234567, -2) from dual;

-- ceil: 소수점 무조건 올림
select ceil(32.8), ceil(32.3), ceil(-32.3) from dual;

-- floor(): 소수점 무조건 내림
select floor(32.0), floor(32.3), floor(-32.3) from dual;

-- power(): 제곱 연산 함수
select power(4, 2) from dual;

-- mod(): 나머지 구하는 함수
select mod(7, 4) from dual;
select 1+1, 2*2 from dual;

-- sqrt(): 제곱근 구하는 함수
select sqrt(4), sqrt(3), sqrt(2) from dual;

-- 문자열 함수
-- concat(): 문자열을 연결해주는 함수 ||(or)와 같음
-- concat: 두개만 글자를 연결해줌/ ||: 두개 이상의 여러개  연결 가능
select concat('Hello', 'Bye') from dual;
select concat('Hello', 'Bye'), 'Good'||'Bad'||'Nice' from dual;

-- initCap(): 단어의 첫글자를 대분자로 바꿈
select initcap('good morning') from dual;
select initcap('good/bad morning') from dual; -- 공백 및 특수기호를 기준으로 단어의 첫글자를 대분자로 바꿈

-- lower(문자열): 소문자로 변환하여 출력
-- upper(문자열): 대문자로 변환하아ㅕ 출력
select lower('Good') from dual;
select upper('Good') from dual;

-- lpad()
select lpad('good', 10) from dual; --전체 10자리 할당 후 왼쪾 들여쓰기
select lpad('good', 10, '*') from dual;  -- 전체 10자리 할당 후 지정된 문자열 출력 
select lpad('good', 10, 'L') from dual;  -- 전체 10자리 할당 후 지정된 문자열 출력 

-- rpad()
select 'good' from dual;
select rpad('good', 10) from dual;
select rpad('good', 10, '*') from dual;
select rpad('good', 10, 'M') from dual;
select rpad('홍길동', 10, '*') from dual; -- 한글은 한 글자가 2byte로 처리

-- ltreim(), rtrim(): ㄱㅇ백을 제거하는 함수
select ltrim('     good') from dual;
select rtrim('good           ') from dual;

select ltrim('goodbye', 'g'), ltrim('goodbye', 'o'), ltrim('goodbye', 'go') from dual;
select rtrim('goodbye                 '), rtrim('goodbye', 'e') from dual;


-- substr(): 부분 문자열을 리턴해주는 함수 *자리 잘보기
select substr('good morning john', 8) from dual;
select substr('good morning john', 8, 4) from dual;
select substr('good morning john', -4) from dual;
select substr('good morning john', -4, 2) from dual;

select substr('good morning john', 8, 4), substr('굿모닝 존', 2, 2) from dual;

-- replace(): 문자열을 교체(1에서 2를 3으로 바꿔라)
select replace('good morning Tom', 'morning', 'evening') from dual;

-- translate(): 문자열 교체
select replace('You are not along', 'You', 'We') from dual;
select translate('You are not along', 'You', 'We') from dual; -- Y->W/ o->e/ u는 없어짐: 1:1 대응

-- length(): 문자열 길이 구하는 함수
select length(' good') from dual;  
select length(ltrim('   good   ')) from dual;
select length(rtrim('    good    ')) from dual;
select length(trim('  good   ')) from dual;

select sysdate from dual;
-- months_between(date1, date2) : 두 잘짜 사이의 개월수의 차

select hire_date from employees;
select first_name, hire_date, trunc(months_between(sysdate, hire_date)) from employees; 

-- add_months(): 현재 날짜에 지정한 개월수를 더함
select sysdate, add_months(sysdate, 7) from dual;

-- last_day(): 해당달의 마지막날을 출력
select last_day(sysdate) from dual;

-- to_char() : 출력 형식 변경
select to_char(sysdate, 'yyyy/mm/dd'), to_char(sysdate, 'mm/dd/yyy') from dual;

-- to_date()
select to_date('2021/03/15', 'yyyy/mm/dd') from dual;
select sysdate - to_date('2041/08/29', 'yyyy/mm/dd') from dual;

-- nvl(): null값을 특정한 값으로 치환해주는 함수
select first_name, commission_pct from employees;
select first_name, commission_pct, nvl(commission_pct, 0)+0.1 from employees;
