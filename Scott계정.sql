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

select empno, ename, sal, comm, deptno from emp order by comm desc; --내림차순(desc)정렬일떄는 Null값을 먼저 출력함
select empno, ename, sal, comm, deptno from emp order by comm asc; --오름차순(desc)정렬일떄는 Null값을 뒤에 출력함
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

























