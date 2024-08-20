-- insert query 

INSERT INTO film (title, description, release_year, language_id, rental_duration,rental_rate, 
length, replacement_cost, rating, special_features)
VALUES 
('The Dark Knight', 'Batman fights the Joker', 2008, 1, 3, 4.99, 152, 19.99,'PG-13', 'Trailers'),
('The Dark Knight Rises', 'Batman fights Bane', 2012, 1, 3, 4.99, 165, 19.99,'PG-13', 'Trailers'),
('The Dark Knight Returns', 'Batman fights Superman', 2016, 1, 3, 4.99, 152,19.99, 'PG-13', 'Trailers');

INSERT INTO film
VALUES 
(default, 'The Dark Knight', 'Batman fights the Joker', 2008, 1, 
NULL, 3, 4.99,152, 19.99, 'PG-13', 'Trailers', default);

-- SELECT 
select version();

select * from film;

select title, description, rental_duration from film;

-- print movie title and description along with the length (in hours)
select title, description, length / 60 as length_hours from film;


CREATE TABLE film_copy (
  film_id SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  title VARCHAR(128) NOT NULL,
  description TEXT DEFAULT NULL,
  release_year YEAR DEFAULT NULL,
  language_id TINYINT UNSIGNED NOT NULL,
  original_language_id TINYINT UNSIGNED DEFAULT NULL,
  rental_duration TINYINT UNSIGNED NOT NULL DEFAULT 3,
  rental_rate DECIMAL(4,2) NOT NULL DEFAULT 4.99,
  length SMALLINT UNSIGNED DEFAULT NULL,
  replacement_cost DECIMAL(5,2) NOT NULL DEFAULT 19.99,
  rating ENUM('G','PG','PG-13','R','NC-17') DEFAULT 'G',
  special_features SET('Trailers','Commentaries','Deleted Scenes','Behind the Scenes') DEFAULT NULL,
  last_update TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY  (film_id),
  KEY idx_title_1 (title),
  KEY idx_fk_language_id_1 (language_id),
  KEY idx_fk_original_language_id_1 (original_language_id),
  CONSTRAINT fk_film_language_1 FOREIGN KEY (language_id) REFERENCES language (language_id) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT fk_film_language_original_1 FOREIGN KEY (original_language_id) REFERENCES language (language_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

select * from film_copy;

-- adding data using a combo of insert and select 
insert into film_copy (film_id, title, description, release_year, language_id, original_language_id, rental_duration, rental_rate, length, 
replacement_cost, rating, special_features, last_update) select film_id, title, description, release_year, language_id, original_language_id, 
rental_duration, rental_rate, length, replacement_cost, rating, special_features, last_update from film;

-- DISTINCT
select distinct title from film;

select distinct rating, release_year from film;

-- select title, description, distinct rating, release_year from film; --> Doesn't work

select distinct original_language_id from film;

explain select * from film;

-- Where
select * from film where release_year = 2006;

select title, release_year from film where release_year = 2006;

select title, release_year from film where release_year > 2006;

select distinct title, release_year from film where release_year > 2006;


-- multiple conditions 
select * from film where release_year = 2006 and rating = 'PG-13';

-- print all the movies that were NOT released in 2006
select * from film where release_year != 2006;
select * from film where release_year <> 2006;

select * from film where release_year > 2006 and (rating = 'PG-13' or rental_duration = 3);

-- print all the movies that are released in 2006, 2008, 2009, 2010, 2011, 2012
select * from film where release_year = 2006 or release_year = 2008 or release_year = 2009;

-- IN 
select * from film where release_year IN (2006, 2008, 2009, 2010, 2011, 2012);

-- print all the movies that are release between 2006 and 2012
select * from film where release_year >= 2006 and release_year <= 2012;

-- BETWEEN 
select * from film where release_year between 2006 and 2012;


-- ORDER BY
-- output sorted by length
select * from film order by length;

select * from film order by length desc;

select * from film order by length asc;

select * from film where release_year = 2006 order by length;

-- you can give multiple cols in order by 
select title, description, length, replacement_cost from film order by length asc, replacement_cost desc;

-- find distinct release_year and rating where length is 185, 181 or 176 and order this by replacement_cost
select distinct release_year, ratingfrom film where length in (185, 181, 176) order by replacement_cost;


-- Expression #1 of ORDER BY clause is not in SELECT list, references column 'sakila.film.replacement_cost' which is not in SELECT list; this is incompatible with DISTINCT	0.00028 sec





