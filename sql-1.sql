create database scalerAugBeg;

use scalerAugBeg;

create table BATCHES (
	batch_id INT PRIMARY KEY,
    batch_name VARCHAR(60)
);

create table STUDENTS (
	student_id INT PRIMARY KEY auto_increment,
    first_name VARCHAR(60) NOT NULL,
    last_name VARCHAR(60) NOT NULL,
    batch_id INT,
    foreign key(batch_id) references BATCHES(batch_id) ON DELETE CASCADE
);

insert into BATCHES (batch_id, batch_name) VALUES
(1, "May23 Beg"),
(2, "Apr 22 Adv"),
(3, "Aug 24 Beg");

insert into STUDENTS (first_name, last_name, batch_id) VALUES
("Rajashri", "Mane", 1),
("FAISAL", "Khan", 2),
("Prasad", "Prasad", 1);

select * from BATCHES;
select * from STUDENTS;

show tables;

drop table BATCHES;
drop table STUDENTS;

delete from BATCHES where batch_id = 1;

