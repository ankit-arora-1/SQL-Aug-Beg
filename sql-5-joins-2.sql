use sakila;

-- find rental info for each and every movie 
-- (Don't include inventor that have never been rented)
select f.title, i.inventory_id, r.rental_id
from film f
inner join inventory i
on f.film_id = i.film_id
inner join rental r
on i.inventory_id = r.inventory_id;

-- Find rental info (movie name, rental id and inventory id) for each and every movie 
-- (Include movies that have never been rented as well)
select f.title, i.inventory_id, r.rental_id
from film f
left join inventory i
on f.film_id = i.film_id
left join rental r
on i.inventory_id = r.inventory_id;

-- Ordering matters in case of left join
-- change ordering from above 
select f.title, i.inventory_id, r.rental_id
from rental r
left join inventory i
on r.inventory_id = i.inventory_id
left join film f
on i.film_id = f.film_id;


-- natural join 
select * from film;
select * from inventory;

select * 
from film 
natural join inventory;

select * 
from film f
join inventory i
on f.film_id = i.film_id and f.last_update = i.last_update;


-----------
-- where vs on in left join
-----------
use scalerAugBeg;
select * from batches;
select * from students;

select * 
from batches b
left join students s
on b.batch_id = s.batch_id
where b.batch_id = 1;


select * 
from batches b
left join students s
on b.batch_id = s.batch_id and b.batch_id = 1;



---------
-- Union 
---------
select * from students;
select * from batches;

select student_id, first_name from students
union 
select batch_id, batch_name from batches;

-- Only distinct values are printed
select first_name, last_name from students
union 
select batch_id, batch_name from batches;

-- All values are printed
select first_name, last_name from students
union all
select batch_id, batch_name from batches;




-- cross join 
select * 
from students
join batches;

select * from students, batches;

select * from students, batches
where students.batch_id = batches.batch_id; -- implicit join 

-- using keyword
select * 
from batches b
left join students s
using (batch_id); -- on b.batch_id = s.batch_id
