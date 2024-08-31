use sakila;

-- find out all the movies where rental duration is greater than avg rental duration 
select * 
from film 
where rental_duration > (
	select avg(rental_duration)
    from film
);

-- Below query will not work because inner query returns multiple rows 
select * 
from film 
where rental_duration > (
	select rental_duration
    from film
);

-- Same question as above but use joins + subquery
select * 
from film f
join (select avg(rental_duration) avg_rental from film) as avg_rental_table 
on f.rental_duration > avg_rental_table.avg_rental;

-- find films where rental duration is greater than rental duration of film with id 500 
select * 
from film 
where rental_duration > (
	select rental_duration 
    from film 
    where film_id = 500
);

-- with joins 
select * 
from film f1
join film f2
on f2.film_id = 500 and f1.rental_duration > f2.rental_duration;

-- Find the students whose psp is greater than the min psp of each and every batch
-- part 1 
-- select min(psp) as min_batch_psp 
-- from students
-- group by batch_id

-- part 2
-- select max(x) from <abvove table>

-- part 3
-- select * 
-- from students 
-- where psp > select max(x) from <abvove table>


use scalerAugBeg;

select * 
from students 
where psp > (
	select max(min_batch_psp)
    from (
		select min(psp) as min_batch_psp
        from students 
        group by batch_id
    ) as min_psp_table
);

-- Get psp of all students whose psp is greater than average psp of their batch 
-- not a correlated query 
select * 
from students s
join (
	select batch_id, avg(psp) as avg_psp
    from students 
    group by batch_id
) as batch_avg
on s.batch_id = batch_avg.batch_id and s.psp > batch_avg.avg_psp;
