-- �����ͺ��̽� ���
 -- 1) ������ ���Ǿ� (DDL, Data Definition Language) : ������
 -- 2) ������ ���۾� (DML, Data Manipulation Language) : ������, �����
 -- 3) ������ ����� (DCL, Data Control Language) : ������
 
 
 -- ** ������ ���Ǿ� (DDL) �ǽ� : Create, Alter, Rename, Comment, Truncate, Drop
 Create table books (
    no number,
    name varchar2(30));
    
select * from tab;

desc books;

select * from books;

-- Alter : ���̺��� ������ ������ �� ���
-- ��ɾ�� ��ҹ��� ������ ����

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
is '���� ���� ���';

desc user_tab_comments;

select *
from user_tab_comments
where table_name = 'T_BOOKS';

select * from t_books;

truncate table t_books;

drop table t_books;

select * from tab;

 -- 2) ������ ���۾� (DML) �ǽ� : Select(�˻�), Insert(�߰�), Update(����), Delete(����)
 
Create table ģ�� (
    �̸� varchar2(20),
    �޴��� varchar2(11),
    ���� date);

insert into ģ��
values('Chris', '01011112222', '2007/08/28');

insert into ģ��(����, �޴���, �̸�)
values('2010/03/29', null, 'Max');

insert into ģ��(�̸�, �޴���)
values('Mary', '01022223333');

select * from ģ��;

commit;

desc ģ��;

update ģ��
set �޴��� = '01099999999'
where �̸� = 'Mary';

select * from ģ��;

rollback;

delete
from ģ��
where �̸� = 'Mary';

select * from ģ��;

select * from ģ��;

alter session set nls_date_format = 'YYYY/MM/DD';

-- ** �����������(DCL) �ǽ�: Commit(����/����Ұ�), Rollback(����������� ����), Grant(���Ѻο�), Revoke(��������)

select * from tab;

create table Choi (
���¹�ȣ number,
�ݾ� number
);

create table ���� (
���¹�ȣ number,
�ݾ� number
);

select * from tab;

insert into choi values (1234, 20000);
insert into ���� values (9999, 5000);

select * from choi;
select * from ����;

-- Choi�� ���� 1234���� ������ ���� 9999�� 10,000���� ��ü
update choi
set �ݾ�=�ݾ�-10000
where ���¹�ȣ = 1234;

update ����
set �ݾ� = �ݾ� +10000
where ���¹�ȣ = 9999;

select * from choi;
select * from ����;

commit;

--Choi�� ���� 1234���� ���� ���� 9999fh 5,000�� ��ü
update choi
set �ݾ�=�ݾ�-5000
where ���¹�ȣ=1234;

update ����
set �ݾ�=�ݾ�+5000
where ���¹�ȣ=9999;

select * from choi;
select * from ����;

rollback;

-- * Select ���߿��� -6���� ����
/*
    1) select, from ->�����Ұ�
    2) select, from, where
    3) select, from, group by
    4) select, from, where, group by
    5) select, from, group by, having 
    6) select, from, where, group by, having

    **order by�� 6���� ��� ���Ͽ� �� ����� �� ����
*/
-- ����-1) select, from
select * from emp; 

--(����) �μ����̺�(dept)�� ��� ������ ��ȸ
select * from dept;

desc emp;
select *form emp;
select ename, sal from emp;

-- ������̺�(emp)���� �����ȣ, �̸�, ����, �޿��� ��ȸ
select empno, ename, job, sal from emp;

select empno, ename, ename, ename, ename, sal, sal --�Ӽ�
from emp;

--(����) �޿��� 10% �λ��ؼ� ��� (�����ȣ, ����̸�, �޿�, 10%�λ�ȱ޿�)
select empno, ename, sal, sal *1.1 from emp;

-- (����) ������� ������ ���
select empno, ename, sal, comm, sal*12+comm as ����
from emp;--��ü

-- Null ������ ���Ͽ� ������� ��Ȯ���� ����
-- nvl(comm, 0) comm �÷��� ���� ������ �״�� ����ϰ�, ������(=Null��)0�� �����
select empno, ename, sal, comm, sal*12+nvl(comm, 0) from emp;

/* Null �� ����
1. Null�� '�˼� ����' �Ǵ� '����ִ�' ���� �ǹ�
2. Null�� 0�� �ƴϰ�, �����̽�(����)�� �ƴ�
3. Null�� � ���� ���ϰų� ��� �����ϸ� ����� �׻� Null
4. Null�� Null�� ���ϸ� ����� Null
*/

-- emp ���̺��� comm�� �� �޴� ����� �����ȣ�� �̸�, ���ʽ� ��ȸ
select empno, ename, comm from emp where comm is null;
-- emp ���̺��� comm�� �޴� ����� �����ȣ�� �̸�, ���ʽ� ��ȸ
select empno, ename, comm from emp where comm is not null
-- emp ���̺��� ��簡 ���� ������ �����ȣ, ����̸�, mgr �÷��� ��ȸ
select empno, ename, mgr from emp where mgr is null;
-- emp ���̺��� ��簡 �ִ� ������ �����ȣ, ����̸�, mgr �÷��� ��ȸ
select empno, ename, mgr from emp where mgr is not null;

-- emp ���̺��� �޿��� ���� �޴� ��(��������: asc)
select empno, ename, sal, comm, deptno from emp order by sal asc;
-- emp ���̺��� �޿��� ���� �޴� ��(��������: desc)
select empno, ename, sal, comm, deptno from emp order by sal dec;

-- ����� �̸��� ���ĺ� ������ ����(�����ȣ, ����̸�, �޿�)
select empno, ename, sal from emp order by ename desc;  
--�������� �����϶� asc ��ɾ�� ��������/ �������� �����϶� desc ��ɾ� �����Ұ�
-- ����� �̸��� ���ĺ� ������ ����(�����ȣ, ����̸�, �޿�)
select empno, ename, sal from emp order by 2 desc; -- �÷� ��ȣ ��밡��
-- ������̺��� �μ���ȣ ������ �������� ����(�����ȣ, ����̸�, �޿�, �μ���ȣ)
select empno, ename, sal, deptno from emp order by deptno asc, sal desc;

select empno, ename, sal, comm, deptno from emp order by comm desc; --��������(desc)�����ϋ��� Null���� ���� �����
select empno, ename, sal, comm, deptno from emp order by comm asc; --��������(desc)�����ϋ��� Null���� �ڿ� �����
-- �������� ���Ŀ� Null���� ���� ����ϱ�
select empno, ename, sal, comm, deptno from emp order by comm nulls first;
-- �������� ���Ŀ� Null�� �ڿ� ���
select empno, ename, sal, comm, deptno from emp order by comm nulls last;

-- select���� ���� �÷��� �̿��ؼ� ������ �� ����: Ư�� �÷��� �����͸� ��Ǯ���� �����鼭�� ���ϴ� ������ ������ �� ����
select empno, ename, job from emp order by sal desc;
-- ������ ���ؿ� �� �� �̻��̸�, order by ���� �� �� �̻��� �÷��� ����
-- �μ���ȣ�� �������� �������� ���� 1��, ���� �μ��� �ݿ��� �������� �������� ���� 2��
select deptno, empno, ename, sal, comm from emp order by deptno asc, sal desc; --2�� ����

-- alias(=����)�� �̿��ؼ� �÷����� ����
select empno as �����ȣ, ename "��� �̸�", sal �޿� from emp; -- as�� ���� ����

select ename, sal 
from emp -- ������� 1
where ename= 'ALLEN'; -- ������� 2

-- (����) emp���̺��� ��� ������ ����Ͻÿ�.
-- disticnt�� �̿��ؼ� �ߺ��� ���� ����/ order by�� distinct�� �Բ� ����ϸ� ������ �ľ��� ���� ������
select distinct job from emp;
select distinct job from emp order by job asc;

select deptno, job from emp order by 1, 2;
-- distinct ��� ��
select distinct deptno, job from emp order by 1, 2;

-- ���� ���ͷ��� ���� ����ǥ('')�� ���ξߵ�
select ename, '����� ������ ', job, '�Դϴ�.' from emp; -- ����� �ɷ� 4��
select ename || ' ����� ������ ' || job || ' �Դϴ�.' as ��� from emp; -- ���� ������-�÷� 1��/����Ŭ�� ������ �ٸ� DBMS������ ���ڿ����ڷ� |��ȣ, ����Ŭ������ || ��ȣ�� �����

-- (��� ��)SNITR ����� �Ի����� 1981-11-12 �Դϴ�.
select ename || ' ����� �Ի����� ' || hiredate || ' �Դϴ�.' as �Ի��� from emp;










-- ���� #2(select, from, where) ->������2
select * from emp;
-- 30�� �μ��� ������� ��� ������ ��ȸ
select * from emp where deptno = 30;

-- �޿��� 1500 ���� �޴� ����� �̸��� �޿� ���� ��ȸ
select ename, sal        --������� 3
from emp                 --������� 1
where sal >= 1500;       -- �������2 /where�� ���ÿ���- Ʃ���� ����

-- ���ʽ��� ���� �ʴ� ȸ���̸��� �޿� ��ȸ/ null�� ������ ���� �ȵ�
select ename, sal from emp where comm is null;   -- comm = null -> null������ ��°��� ����

-- ���ʽ��� �޴� ȸ���̸��� �޿� ��ȸ
select ename, sal from emp where comm is not null;

select * from emp where empno = empno;  -- �׻� ������� true�̹Ƿ� ��� Ʃ���� ���
 
select * from emp where comm = comm;  -- comm�� null���� �ƴ� Ʃ�õ��� ���

-- ������ 'salesman'�̰� �޿��� 1500 �̻��� ������� ��� ���� ��ȸ/ '~': ��ҹ��� �����ϱ�
select * from emp where job = 'SALESMAN' and sal >= 1500;   -- ��ɾ�� ��ҹ��� �������� ����/���ڿ��� ��Һ��� ������ 
select * from emp where job = 'SALESMAN' or sal >= 1500;

select * from emp where deptno = 30 and comm = null;   -- ������ ������� null�̹Ƿ� ��°��� ����
select * from emp where deptno = 30 or comm = null;   -- �μ���ȣ�� 30�� ����� ��µ�
select * from emp where deptno = 30 and comm is null;

-- �޿��� 1500 �̻� �̰ų� ������ 'salesman'�̸鼭 �μ���ȣ�� 20�� ����� ��� ���� ��ȸ
select * from emp where sal >= 1500 or (job = 'SALESMAN' and empno = 20);  -- and ������ or ���Ǻ��� ���� �����
select * from emp where (sal >= 1500 or job = 'SALESMAN') and empno = 20;  -- ()�� �̿��Ͽ� �켱���� ����


select * from emp where 1= 2; --��� ������� falas �̹Ƿ� ��µǴ� ���� ����

select * from emp where 120 > 119; -- ��� ������� true �̹Ƿ� ��� ��ü ���ڵ尡 ��µ�

select * from emp where '120' > '21'; --���ڿ��� ���ڸ����� ��, ������� false �̹Ƿ� ��°� ����

select * from emp where to_number('120') > to_number('21'); --�׻� ������� true�̹Ƿ� ��� ���ڵ� ���
--to_number: ���ڿ��� ���ڷ� �ٲ���

select * from tab;

create table emp1 as select * from emp; -- emp ���� ����

select * from emp1;

desc emp1;

create table emp2 as select * from emp where 1 = 2;
emp���̺�� ���� ���̺��� ����鼭 ���ڵ�(����)�� �ȵ�/ �Ӽ��� ����

select * from emp2;

select job from emp;
select distinct job from emp; --�ߺ��� �� ����(distinct, unique)
select unique job from emp;

select unique deptno from emp;

select deptno, job from emp;
select distinct deptno, job from emp;

--salesman�� ��� ����� ���� ��ȸ
select * from emp where job = 'SALESMAN';
--salesman�� �ƴ� ��� ����� ���� ��ȸ
select * from emp where job != 'SALESMAN';
select * from emp where job <> 'SALESMAN';
select * from emp where job ^= 'SALESMAN';
-- ������ �ǹ�: !=, <>, ^=
--�޿��� 2500 ���� ���� �޴� ����� �̸��� �޿� ��ȸ
select ename, sal from emp where sal > 2500    -- 2500 �ʰ�
select ename, sal from emp where sal >= 2500;  -- 2500 �̻�
select ename, sal from emp where sal < 2500;   -- 2500 �̸�
select ename, sal from emp where sal <= 2500;  -- 2500 ����

-- �̸��� M���� �����ϴ� ��� ����� �̸�, �޿�, �Ի�����, �μ���ȣ ��ȸ
-- like �����ڸ� ���: ���ϵ� ī��(%: zero or more, _:one)
select ename, sal, hiredate, deptno from emp where ename like 'M%'; -- M���� �����ϴ� ��� �̸��� ����
-- �̸��� ���� N���� ������ ����� �̸�, �޿� ��ȸ
select ename, sal from emp where ename like '%N';  
-- �̸��� 5��¥�� ����� ��� ���� ��ȸ
select * from emp where ename like '_____';
-- �̸��� �ι�° ���ڰ� A�� ����� �̸� ��ȸ
select ename from emp where ename like '_A%';
-- �̸��� S�� ���� ����� �̸��� �޿��� �μ���ȣ ��ȸ
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

-- A_A �κ� ���ڿ��� ���Ե� �Ӽ���
--select * from t1 where coll like '%A_A%';
-- �Ӽ����� '_'�� ����ִ� ���� ���
--select * from t1 where coll like '%$_%' escape '$';
-- ���ʽ�(comm)�� ���� �ʴ� ����� ��� ���� ���
select * from emp where comm is null;
--���ʽ�(comm)�� �޴� ����� ��� ���� ���
select * from emp where com is not null;
select * from emp where com >= 0;

-- ��簡 ���� ����� ��� ���� ���
select * from emp where mgr is null;
select * from emp where not(mgr is null);

-- ��簡 �ִ� ����� ��� ���� ���
select * from emp where mgr is not null;

--�޿�(sal)�� 1500�̻� 3000���� �޴� ����� ��� ���� ���
select * from emp where sal >=1500 and sal <= 3000;
select * from emp where sal between 1500 and 3000;

-- �޿� 1500���� ���� �ްų� �Ǵ� 3000���� ���� �޴� ����� ��� ����
select * from emp where sal < 1500 or sal > 3000;
select * from emp where sal not between 1500 and 3000;

select distinct job from emp;
select ename as ����̸�, job as ����, sal * 12 + nvl(comm, 0) as ���� from emp;

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

-- ��� ���̺��� ��� ����� ��� ������ ��ȸ
select * from emp;

-- 10�� �μ��� �ٹ��ϰ� �ִ� ����� �����ȣ, �̸�, �μ� ��ȣ ��ȸ
select empno, ename, from emp where deptno = 10;
-- 20�� �μ��� �ٹ��ϰ� �ִ� ����� �̸��� �޿��� ���ʽ� ��ȸ
select ename, sal, comm from emp where deptno = 20;

-- ������̺��� 10�� �μ� �Ǵ� 30�� �μ��� �ٹ��ϴ� ������ ��� ������ ��ȸ
-- or ������ ���
select * from emp where deptno = 10 or deptno = 30;
-- in ������
select * from emp where deptno in (10, 30);
-- ������ ����
select * from emp where deptno = 10
union all
select * from emp where deptno = 30;

 
-- ������̺��� James, Allen, Scott�� �̸�, �޿�, �Ի糯¥�� ��ȸ
select ename, sal, hiredate from emp where ename = 'JAMES' or ename = 'ALLEN' or ename = 'SCOTT';
-- in ������
select ename, sal, hiredate from emp where ename in ('JAMES', 'ALLEN', 'SCOTT');

-- ������ 'Salesman'�̰ų� 'Manager'�� ����� �̸�, �޿�, ���ʽ�, �μ���ȣ ��ȸ
-- ro ������
select ename, sal, comm, deptno from emp where JOB = 'SALESMAN' or JOB = 'MANAGER';
-- in ������
select ename, sal, comm, deptno from emp where JOB in ('SALESMAN', 'MANAGER');
 
-- �޿��� 2500 �ʰ��ϴ� ����� �̸��� �޿��� ���� ��ȸ
select ename, sal, job from emp where sal >= 2500;

-- �����ȣ�� 7566�� ����� �����ȣ, �̸�, �μ���ȣ ��ȸ
select empno, ename, deptno from emp where emptno = 7566;
select * from emp;

select ename, sal from emp order by ename asc;

-- �����ȣ�� 7566�� ����� �����ȣ, �̸�, �μ���ȣ�� ��ȸ
select empno, ename, deptno from emp where empno = 7566;
-- �޿��� 1000�� 3000���̰� �ƴ� ����� �̸��� �޿��� ��ȸ
-- between ������ �̿�
select ename, sal from emp where sal not between 1000 and 3000;
select ename, sal from emp where sal < 1000 or sal > 3000;
-- Allen�� james�� �����ȣ, ����, �޿�, �μ���ȣ ��ȸ
-- or������
select empno, job, sal, deptno from emp where ename = 'ALLEN' or ename = 'JAMES';
-- in ������
select empno, job, sal, deptno from emp where ename in ('ALLEN', 'JAMES');
select empno, job, sal, deptno from emp where ename = 'ALLEN'
Union
select empno, job, sal, deptno from emp where ename = 'JAMES';

-- ȭ���Ͽ� �Ի��� ��� �����ȣ, �̸�, �Ի糯¥ DAY(ȭ����) ��ȸ
-- select empno, ename, hiredate from emp where day = 3;
select empno, ename, hiredate, to_char(hiredate, 'day') from emp;
select empno, ename, hiredate from emp where to_char(hiredate, 'day')='ȭ����';

select to_char(to_date('20040829', 'yyyymmdd'), 'day') from dual;

-- ������ salesman�� ����� ��� ���� ��ȸ
select * from emp where job = 'SALESMAN';







-- ���� #3(select, from, group by)
select * from emp;
-- �� �μ��� �� ���� �ٹ��ϴ��� ��ȸ
select count(*) from emp;
select deptno, count(*) from emp group by deptno order by deptno;

-- �� �μ��� �޿� ��, ��� ���ϱ�/ �� �μ����޿���, �μ����޿�������� �̸� ���ϱ�
select deptno, sum(sal) as �μ����޿���, avg(sal) as �μ����޿���� from emp group by deptno order by deptno;

-- �� ������ �ְ�޿� �� �����޿� ��ȸ
-- select max(sal), min(sal) from emp;-> ���� �߻�
select job, max(sal) �ְ�޿�, min(sal) �����޿� from emp group by job;

-- �μ���/������ �����, �޿���, �޿���� ��ȸ
select deptno, job, count(*) �����, sum(sal) �޿���, avg(sal) �޿���� from emp group by deptno, job order by deptno, job desc;  

-- �μ���/������ �����Ի��� �� ������ �Ի��ڸ� ��ȸ
select deptno, job, min(hiredate), max(hiredate) from emp group by deptno, job order by 1;

-- ��ü ������� ��� ���ʽ��� ��ȸ
select ename, comm, comm + 100, nvl(comm, 0), nvl(comm, 0) + 100 from emp; -- ���� ���� �� �״�� �ְ� ,comm�� null���̸� 0���� ġȯ
select avg(comm) ��պ��ʽ�4��, avg(nvl(comm, 0)) ��ü����� ��պ��ʽ� from emp;

-- �μ��� ������� ��� ���ʽ� ��ȸ
select deptno, avg(comm), trunc(avg(nvl(comm, 0))) from emp group by deptno;







-- ���� #4(select, from, where, group by)
-- �������: from -> where -> group by -> select -> order by

-- �޿��� 1000 �̻��� ������� ������ �����, �μ��� �ִ�޿�, �μ��� �ּұ޿��� ��ȸ
select job ����, count(*) �����, max(sal) �ִ�޿�, min(sal) �ּұ޿� from emp where sal >= 100 group by job;

-- �� �μ����� Clerk�� ����ΰ�
select deptno, count(*) from emp group by deptno order by deptno;



-- ppt 19~20�� �ǽ�����
create table ���� (
    �й� char(7) not null,
    �����ȣ varchar2(20) not null);
    
insert into ���� values('9902101', 'CS100');    
insert into ���� values('9902101', 'CS200');    
insert into ���� values('9902102', 'CS200');    
insert into ���� values('9902102', 'CS300');    
insert into ���� values('9902103', 'CS400');    

create table �л� (
    �й� char(4) not null,
    �л��� char(10) not null,
    �г� integer);

insert into �л� values('901', '��', 2);    
insert into �л� values('902', '��', 4);    
insert into �л� values('903', '��', 3);    
   
     
create table ���� (
    �й� char(4) not null,
    �ڵ��ȣ char(10) not null,
    �߰���� integer,
    �⸻��� integer);

insert into ���� values ('901', 'C-101', 80, 95);
insert into ���� values ('901', 'C-102', 75, 85);
insert into ���� values ('902', 'C-101', 90, 80);
insert into ���� values ('902', 'C-102', 95, 75);
insert into ���� values ('902', 'D-103', 60, 90);
insert into ���� values ('903', 'D-103', 65, 70);

create table �л�2 (
    �й� char(7) not null,
    �̸� char(10) not null,
    �а���ȣ char(4),
    �̼����� integer,
    ������� number(3,2));

insert into �л�2 values ('9902101', 'ȫ�浿', '010', 100, 4.10);    
insert into �л�2 values ('9902102', '�ڵθ�', '010', 80, 3.25);    
insert into �л�2 values ('9902103', '�赹��', '020', 90, 3.00);    
insert into �л�2 values ('9902104', '���ؼ�', '020', 120, 2.60);    
insert into �л�2 values ('9902105', '���ϴ�', '030', 130, 1.90);   

select * from tab;
select * from �л�2;

-- 2�� ó��
select �й� from ���� where �����ȣ = 'CS300';
select �й� from ���� where �����ȣ = 'CS200' and �й� = 9902102;
-- ��������(1�� ó��)
select �й� from ���� where �����ȣ = 'CS200' and �й� = (select �й� from ���� where �����ȣ = 'CS300');

-- ���� �ݿ��� �� ���� �޴� ����� �̸��� �޿� ��ȸ
select sal from emp where ename = 'TURNER';
select ename, sal from emp where sal > (select sal from emp where ename = 'TURNER');


select �й� from ���� where �ڵ��ȣ = 'C-102';
select �л��� from �л� where �й� = '901' or �й� = '902';
-- ���� ����
select �л��� from �л� where �й� in (select �й� from ���� where �ڵ��ȣ = 'C-102');
-- join
select �л�.�л��� from �л�, ���� where �л�.�й� = ����.�й� and ����.�ڵ��ȣ ='C-102';

-- �߰���簡 70�� ������ �л��� �л��� �˻�
select �й� from ���� where �߰���� <= 70;
select �л��� from �л� where �й� in(select �й� from ���� where �߰���� <= 70);

select �̼����� from �л�2 where �а���ȣ = '020';
select  * from �л�2 where �̼����� >= 90 or �̼����� >= 120;
select * from �л�2 where �а���ȣ != '020' and �̼����� > some(select �̼����� from �л�2 where �а���ȣ = '020');
-- some: ��� �ϳ� �̻� �ǹ�

select * from �л� where �̼����� > all(select �̼����� from �л� where �а���ȣ = '020');

-- ��� 902�й��� �л����� �߰���� ������ ���� �׻��� �й��� �߰���� ���� �˻�
                                                                                                                                                                                                                         
select * from �л�;

insert into �л� (�й�, �л���, �г�) values('904', '�̼���', 3);
insert into �л� values('905', '������', 3);

create table Test(
    �й� char(4),
    �ٻ��� char(10),
    �г� number(10)
);

insert into temp select * from �л� where �г� = '3';

select * from Test;
Delete from Test;

insert into �л�(�л���, �й�) values('������', '908');
insert into �л�(�л���, �й�, �г�) values('����ȣ', '908', null);
insert into �л� values('910', '��', 2);

create table temp(
    �й� char(7)
);

-- �л� ���̺��� 3�г� �л��� �й��� temp���̺� �߰� ��, insert��ɾ�� �ѹ��� ���
insert into temp select * from �л� where �г� = 3;

-- ���ʽ��� ���� �ʴ� ����� �μ����� �� ������ ��ȸ
select count(*) from emp where comm is null;
select deptno, count(*) from emp where comm is null group by deptno order by deptno;













-- ���� #5 (select, from, group by, hacing)
-- ���� ����: from -> group by -> having -> select -> order by 

-- 5�� �̻� �ٹ��ϴ� �μ� �� �ο����� ��ȸ
select deptno, count(*) from emp group by deptno  having count(*) >= 5 order by deptno; 
-- emp���̺��� �ְ�޿��� �����޿��� ���̰� 500 �̻��� ���� ��ȸ
select job, max(sal), min(sal) from emp group by job having max(sal) - min(sal) >= 500;
select job, max(sal), min(sal), max(sal) - min(sal) �޿��� from emp group by job having max(sal) - min(sal) >= 500 order by �޿���;--order by 4
-- ��ü ��� �߿��� �����Ի��ϰ� �������Ի��� ��ȸ
select max(hiredate) �������Ի���, min(hiredate) �����Ի��� from emp; 
-- �μ��� ���� �Ի��ϰ� ������ �Ի����� ��ȸ
select deptno, max(hiredate) �������Ի���, min(hiredate) �����Ի��� from emp group by deptno order by deptno;
-- ������ �����Ի��ϰ� ������ �Ի��� ��ȸ
select job, max(hiredate) �������Ի���, min(hiredate) �����Ի��� from emp group by job;
-- ������ �����Ի��ϰ� �������Ի��� ��ȸ ��, �������Ի����� 82�� ������ ������ ��ȸ
select job, max(hiredate) �������Ի���, min(hiredate) �����Ի��� from emp group by job having max(hiredate) < to_date('820101') order by 3;









-- ���� #6 (select, from, where, group by, hacing)
-- ���� ����: from -> where -> group by -> having -> select -> order by 


-- �޿��� 1000 �̻��� ������� �������� ������ �����ϱ�
-- ��, �μ��� �����޿��� 2000 �̻��� ����� ����ϵ��� �� ��
-- �����Լ� : ������ �����-count, ������ �ִ�޿�-max, ������ �ּұ޿�-min
-- ** �����Լ��� �ƴ� �Ͱ� ���� ���� ������/ group by�� ������ ���� ����
select * from emp;
select count(*), max(sal), min(sal), sum(sal), avg(sal) from emp;
select deptno, count(*) from emp group by deptno;
select job, count(*) �����, max(sal) �μ����ִ�޿�, min(sal) �μ����ּұ޿� from emp where sal >= 1000 group by job having min(sal) >= 2000;
-- having�� group by�� �ݵ�� �־�� �� 


-- Ŀ�̼��� ���� �ʴ� ����� �μ����� �� ������ ��ȸ
-- ��, Ŀ�̼��� ���� ����� 3�� �̻��� ����� ���
select deptno, count(*) from emp where comm is null group by deptno having count(*) >= 3 order by deptno;


-- �μ��� �ο����� ���� ����, ��������� 20�� �μ� ����
select deptno, count(*) from emp group by deptno;
-- where��, having�� �� �� ��밡���ϳ� where���� ����ϴ°� ���ɿ� ����
-- �������*
-- where������ ���͸��� ������ �׷�ȭ -> ���ɿ� ����
select deptno, count(*) from emp where deptno != 20 group by deptno order by deptno;

-- having������ ���͸� -> ��ü �����͸� �׷�ȭ�ϰ�, ������ �����ϹǷ� ����� ���Ե��� ���� �����ͱ����� �׷�ȭ�� �����ϹǷ� ��ȿ����
select deptno, count(*) from emp group by deptno having deptno != 20;


-- emp���̺��� �μ��� ������� 5�� �̻��� �μ��� �μ���ȣ, ������� ��ȸ
select deptno, count(*) from emp group by deptno order by deptno;

select deptno, count(*) from emp where count(*) >= 5 group by deptno; -- ���� �߻�:�������

-- ��������
-- dept ���̺��� ��� ���� ��ȸ
select * from dept;
select * from emp;

-- martin�� �޿��� �μ���ȣ ��ȸ
select sal, deptno from emp where ename = 'MARTIN';
-- 50�� �μ��� �μ��̸��� �������� ��ȸ
select deptno, dname from dept where deptno = 50;
-- scott�� �̸�, �޿�, �μ��̸� ��ȸ(����-����� �Ӽ� �ʿ�)
select emp.ename, emp.sal, dept.dname from emp, dept where emp.deptno = dept.deptno and emp.ename = 'SCOTT'; 
-- locations ���̺��� �����ڵ�� ���ø� ��ȸ
desc locations;
select * from locations;
select loc_code, city from locations;

select dept.dname, locations.city from dept, locations where dept.loc_code = locations.loc_code;

-- ���̽��� �޿�, �μ��̸�, �ٹ����̸� ��ȸ
-- select emp.sal, dept.dname, locations.city from emp, dept, locations where emp.deptno = dept.deptno and dept.loc_code = lcoation.loc_code and emp.


-- emp ���̺��� �μ��� ����� ��ȸ(�μ����� �������� ����)
select deptno, count(*) from emp group by deptno order by deptno;

























