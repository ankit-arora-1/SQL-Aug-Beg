-- Session 1
show variables like "transaction_isolation";
SET SESSION TRANSACTION ISOLATION LEVEL serializable;
use sakila;

start transaction; -- this will end when we commit or rollback

-- Read uncommitted start
select * from film;

update film 
set title = "abc"
where film_id = 2;

-- Read uncommitted end

-- read committed start 
commit;
start transaction;

update film 
set title = "Rohits film"
where film_id = 3;

select * from film;

commit;
-- read committed end

-- update in both transactions
start transaction;

update film 
set title = "Saurabhs film"
where film_id = 4;

select * from film;

commit;

-- repeatable read start
start transaction;
select * from film;
commit;
-- repeatable read end


-- Phantom reads.
start transaction;

select * from rental limit 1000000; -- 16051 becomes 16502 


select * from rental limit 1000000; -- 16503 

update rental 
set customer_id = 103
where rental_id = 16054;

select * from rental limit 1000000; -- 16504 -> Phantom read  

commit;

-- the above is called Phantom reads. 

-- serializable
start transaction;

select * from film where film_id = 100;

commit;

-- deadlock
start transaction;
select * 
from film 
where film_id = 5;

update film 
set title = "praveen"
where film_id = 6;

-- views 
select f.title, f.description, f.release_year, a.first_name, a.last_name, l.name 
from film f
join film_actor fa on f.film_id = fa.film_id
join actor a on fa.actor_id = a.actor_id
join language l on f.language_id = l.language_id;

create view film_actor_language AS 
select f.title, f.description, f.release_year, a.first_name, a.last_name, l.name 
from film f
join film_actor fa on f.film_id = fa.film_id
join actor a on fa.actor_id = a.actor_id
join language l on f.language_id = l.language_id;


select * from film_actor_language;

--------------------------------------
-- session 2

show variables like "transaction_isolation";
SET SESSION TRANSACTION ISOLATION LEVEL serializable;
use sakila;

-- read uncommitted start

start transaction;
select * from film;
commit;

-- read uncommitted end

-- read committed start 
commit;
start transaction;

select * from film;
-- read committed end

-- update in both transactions
start transaction;

update film 
set title = "Praveens film"
where film_id = 4;

select * from film;

commit;


-- repeatable read start
start transaction;
update film 
set title = "neelesh film"
where film_id = 7;

select * from film;

commit;


-- repeatable read end

-- 
start transaction;

insert into rental values (default, '2005-05-24 22:54:33', 1711, 333, default, 1, default);

select * from rental limit 1000000;


insert into rental values (default, '2005-05-24 22:54:33', 1711, 333, default, 1, default);
commit;

commit;

-- serializable
start transaction;

select * from film where film_id = 100;

update film 
set title = "neelesh"
where film_id = 100;

-- deadlock
start transaction;
select * 
from film 
where film_id = 6;

update film 
set title = "praveen"
where film_id = 5;
