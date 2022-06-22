drop table reply;

create table reply(
     rnum number primary key,
     rwriter varchar(20) not null,     
     reply varchar(500) not null,
     rreg_date date not null,
     ref number not null,
     FOREIGN KEY(rwriter) REFERENCES member(id),
     FOREIGN KEY(ref) REFERENCES freeboard(num)
);

create sequence reply_seq
increment by 1
start with 1;

insert into reply(rnum, rwriter, reply, rreg_date, ref)
values (reply_seq.nextval, 'aaa', '하하하', sysdate, 1);

insert into reply(rnum, rwriter, reply, rreg_date, ref)
values (reply_seq.nextval, 'bbb', '히히히', sysdate, 1);

select * from reply order by ref;

delete from reply where rnum=41;