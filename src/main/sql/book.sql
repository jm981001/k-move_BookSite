drop table book;

create table book(
     bnum number primary key,
     bkind varchar(3) not null,
     btitle varchar(100) not null,
     author varchar(40) not null,
     pubcom varchar(40) not null,
     pubdate date  not null,
     page number not null,
     bimage varchar(100) default 'nothing.jpg',     
     bcontent CLOB not null
);

create sequence book_seq
increment by 1
start with 1;

insert into book(bnum, bkind, btitle, author, pubcom, pubdate, page, bimage, bcontent)
values (book_seq.nextval, '100', '미분적분학:대학수학의 첫걸음', '수학교재편찬위원회', '한빛아카데미', '2021-01-06', 620, 'a1234.jpg', '이공계 신입생을 위한 미분적분학 맞춤 기본서...');

insert into book(bnum, bkind, btitle, author, pubcom, pubdate, page, bimage, bcontent)
values (book_seq.nextval, '100', '파이썬 자료구조와 알고리즘', '우재남', '한빛아카데미', '2021-01-23', 520, '파이썬 자료구조와 알고리즘.jpg', '파이썬으로 구현하며 다지는 논리적 사고를 위한 기초 체력...');


delete from book where bnum=21;

select * from book;	