-- Session 1
update film
set title = "abc1"
where film_id = 104;

update film
set title = "abc2"
where film_id = 105;

commit;

-- start transaction
-- query 1
-- query 2 
-- query 3
-- transaction end

use sakila;
select * from film where film_id = 105;

show variables like "autocommit"; 
-- autocommit on means, each query is treated as a transaction. 
-- Meaning, a transaction is started at the beg of a query and it ends with the query end 
-- When the transaction ends, it commits the data automatically

set autocommit = 0;

-- rollback -> undo something 
-- But, you can only rollback, if the data has not been committed. 
-- If it is committed, rollback will not work 
rollback;

-- To know the current trx level
show variables like "transaction_isolation";

-- set a transaction level at session level 
set session transaction isolation level read uncommitted;

select * from film where film_id = 105;

update film
set title = "Abulesh Movie"
where film_id = 105;

commit;

rollback;

---------------------------------------------------------------------------------------------------------------------------------
-- session 2

use sakila;
select * from film where film_id = 105; 

-- To know the current trx level
show variables like "transaction_isolation";

commit;

-- set a transaction level at session level 
set session transaction isolation level read uncommitted;
-- above will let you see the uncommitted value as well 
-- When we set isolation level as read uncommitted, we do something called a "dirty read"
