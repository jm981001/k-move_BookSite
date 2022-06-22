drop table freeboard;

create table freeboard(
     num number primary key,
     writer varchar(20) not null,     
     subject varchar(50) not null,
     reg_date date not null,
     readcount number default 0,
     content CLOB not null,
     FOREIGN KEY(writer) REFERENCES member(id)
);

create sequence freeboard_seq
increment by 1
start with 1;

insert into freeboard(num, writer, subject, reg_date, content)
values (freeboard_seq.nextval, 'aaa', '제목 test1', sysdate, '내용 test1');

insert into freeboard(num, writer, subject, reg_date, content)
values (freeboard_seq.nextval, 'aaa', '제목 test2', sysdate, '내용 test2');

insert into freeboard(num, writer, subject, reg_date, content)
values (freeboard_seq.nextval, 'bbb', '제목 test3', sysdate, '내용 test3');

select * from freeboard order by num desc;

select rownum as rnum, a.* 
from (select * from freeboard order by num desc) a; 

select b.*
from ( select rownum as rnum, a.*
	   from (select * from freeboard order by num desc) a ) b
where b.rnum >= 1 and b.rnum <= 10;