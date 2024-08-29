use sakila;
-------
-- count
------- 
select * from film;
select film_id from film;
select 1 from film;

select count(*) from film;
select count(film_id) from film;
select count(1) from film;

-- "count()" does not count nulls 
select count(description) from film;

-- find avg rental rate for film 
select avg(rental_rate) from film;

select avg(rental_rate) 
from film 
where rental_rate is null;

-- find avg rental rate for film where rental rate is greater than 1.0
-- where is evaluated before the aggregate methods 
select avg(rental_rate) 
from film 
where rental_rate > 1;

-----------
-- group by
-----------

select release_year, count(release_year) 
from film; 

select count(*)
from film 
group by release_year;

select release_year, count(*)
from film 
group by release_year;

-- print the count for each rental duration in the film table 
select rental_duration, count(*)
from film 
group by rental_duration
order by rental_duration desc;

select rental_duration, count(*) as cnt
from film 
group by rental_duration
order by cnt desc;

-- we can group by multiple columns 
select rental_duration, rental_rate, count(*)
from film 
group by rental_duration, rental_rate;

select rental_duration, rental_rate
from film;

-- Below query will give an error because for each group of release_year
-- there would be multiple film_id
select release_year, film_id, count(film_id)
from film 
group by release_year;

select film_id, release_year, count(*)
from film 
group by film_id;

---------------
-- having 
---------------
-- show the rental durations where the count of rental_duration is greater than 200 
select rental_duration, count(*) as cnt
from film 
group by rental_duration
having cnt > 200;

select rental_duration
from film 
group by rental_duration
having count(*) > 200;



-- Retrieve the total revenue earned by each film category but 
-- only include categories where the total revenue is greater than 1000 
-- film_category, category

-- payment -> rental -> inventory -> film_category -> category

select * from category;
select * from film_category;
select * from rental;
select * from payment;
select * from inventory;


select category.name, sum(amount) as revenue
from payment p
join rental using (rental_id)
join inventory using (inventory_id)
join film_category using (film_id)
join category using (category_id)
group by category.name
having revenue > 1000;


-- find actors who have appeared in atleast 2 films together 
-- display just the actor ids

select * from actor;
select * from film_actor;

select f1.actor_id, f2.actor_id, count(*) as no_film
from film_actor f1
join film_actor f2
on f1.film_id = f2.film_id and f1.actor_id < f2.actor_id
group by f1.actor_id, f2.actor_id
having no_film >= 2;

-- H/W
-- same as above but also print actor names 
