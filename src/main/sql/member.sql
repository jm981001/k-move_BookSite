
create table member(
	id varchar(20) primary key,
	passwd varchar(20) not null,
	name varchar(20) not null,
	reg_date date not null
);

insert into member
     values ('admin', 'admin', '이순신', sysdate);

insert into member
     values ('aaa', 'aaa', '홍길동', sysdate);

insert into member
     values ('bbb', 'bbb', '이순신', sysdate);
     
insert into member
     values ('ccc', 'ccc', '강감찬', sysdate);
     
insert into member
     values ('ddd', 'ddd', '하하하', sysdate);     

update member set name = '관리자' where id = 'admin';

select * from member;