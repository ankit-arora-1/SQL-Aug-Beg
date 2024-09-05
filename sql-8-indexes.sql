

use sakila;

-- how to see existing indexes
show index from actor;
show index from film;

-- no usage of index
explain select * from actor;

-- using last name index 
explain select * from actor where last_name = "TORN";

-- where with first name but no index so all rows scanned 
explain select * from actor where first_name = "DAN";

-- primary index used because we are sorting this 
explain select * from actor order by actor_id;

-- no index used in this even though using primary index would have given the value 
explain select * from actor order by actor_id, first_name;

-- uses only primary index  
explain select * from actor where last_name = "TORN" and actor_id = 102;

-- uses index for last_name and then does a scan for first name 
explain select * from actor where last_name = "TORN" and first_name = "abc";

-- creating an index 
create index idx_last_name_email on customer (last_name, email);

-- uses index 
explain select * from customer where last_name = "SMITH";

-- doesn't use index even though part of composite index because it is the second one 
explain select * from customer where email = "MARY.SMITH@sakilacustomer.org";

-- uses index because composite columns 
explain select * from customer where last_name = "smith" and email = "MARY.SMITH@sakilacustomer.org";

-- doesn't use index because of ordering but actually does as mysql optimizes this and uses last_name first 
explain select * from customer where email = "MARY.SMITH@sakilacustomer.org" and last_name = "smith";


-- creating index on subset of string 
create index idx_email_subset on customer (email(7));

explain select * from customer where email = "MARY.SMITH@sakilacustomer.org";
