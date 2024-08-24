
use sakila;
-- for every film, print the language of that film 
select film.title, language.name
from film
join language
on film.language_id = language.language_id;

-- alias
select f.title, l.name
from film f
join language l
on f.language_id = l.language_id;

-- write sql query to display first name, last name and email of all customers who rented a movie
select c.first_name, c.last_name, c.email, r.rental_id, r.rental_date
from customer c
join rental r
on c.customer_id = r.customer_id;

select count(*) from rental;

-- Same as above but provide film name as well 
select c.first_name, c.last_name, f.title
from customer c
join rental r
on c.customer_id = r.customer_id
join inventory i
on r.inventory_id = i.inventory_id
join film f
on i.film_id = f.film_id;

-- Retrieve a list of film titles along with their corresponding category names for all films 
select f.title, c.name
from film f
join film_category fc
on f.film_id = fc.film_id
join category c
on fc.category_id = c.category_id;

-- display the staff first name, last name and the address of the store they are currently working in 
select s.first_name, s.last_name, a.address as store_address
from staff s
join store st
on s.store_id = st.store_id
join address a 
on st.address_id = a.address_id;

---------------------
-- SELF JOINS 
---------------------
-- find customers that have the same first name and last name
select * 
from customer c1
join customer c2
on c1.last_name = c2.last_name and c1.customer_id != c2.customer_id and c1.customer_id < c2.customer_id;

-- display list of customers who have rented film in horror category. Include first name, last name, email and film title
select c.first_name, c.last_name, c.email, f.title, ct.name
from customer c 
join rental r
on c.customer_id = r.rental_id
join inventory i
on r.inventory_id = i.inventory_id
join film_category fc
on i.film_id = fc.film_id
join category ct
on fc.category_id = ct.category_id and ct.name = "Horror"
join film f 
on i.film_id = f.film_id;

