
create table manager(
	id varchar(20) primary key,
	passwd varchar(20) not null
);

insert into manager
     values ('admin', 'admin');

update manager set passwd = '123' where id = 'admin';

select * from manager;