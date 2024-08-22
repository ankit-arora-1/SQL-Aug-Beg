use sakila;
select * from film;

-- Give me all the rows where the film name contains the word dark
select * from film where title like "dark%";

-- Give me all the rows where the film name starts with the word "academy"
select * from film where title like "academy%";

-- Give me all the movies where the description is null
select * from film where description = null; -- won't work because for sql null != null 

select * from film where description is null;

select * from film where description is not null;

-- find all rows where release_year is not 2006 (release year can be null as well) 
select * from film where release_year != 2006 or release_year is null;

-- LIMIT 
-- Give me top ten movies according to rental rate 
select * from film order by rental_rate desc limit 10;

select * from film order by rental_rate desc limit 5 offset 20; -- offset 20 means skip first 20 results 

-- Update 
update film set description = 'abc' where film_id = 21;
select * from film where film_id = 21;

update film set description = 'abc' where title like "%dark%"; 
update film set description = 'abc' where film_id > 999;

show variables like "sql_safe_updates";
set sql_safe_updates = 1;

-- Safe update mode says: 
-- It will not let you update if you are trying to update on non indexed columns 

-- delete 
delete from film where film_id = 7; -- Usually use something called soft delete 

-- Break for 5 minutes: 8:20 -> 8:27

