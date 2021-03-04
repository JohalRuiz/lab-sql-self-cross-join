-- Lab | SQL Self and cross join

use sakila;

-- 1. Get all pairs of actors that worked together.
SELECT * FROM actor;
SELECT * FROM film_actor;

SELECT fa1.film_id, fa1.actor_id, a1.last_name, a2.last_name, fa2.actor_id FROM film_actor fa1
JOIN actor a1
ON fa1.actor_id = a1.actor_id
JOIN film_actor fa2
ON fa1.film_id = fa2.film_id
AND fa1.actor_id <> fa2.actor_id
JOIN actor a2
ON fa2.actor_id = a2.actor_id;

-- 2. Get all pairs of customers that have rented the same film more than 3 times.
SELECT * FROM rental;

SELECT distinct(i.film_id), r1.rental_id, r1.customer_id, r2.customer_id, count(r2.customer_id)
FROM rental r1 
JOIN inventory i 
ON r1.inventory_id = i.inventory_id
JOIN film f 
ON i.film_id = f.film_id
JOIN rental r2
ON r1.inventory_id = r2.inventory_id
AND r1.customer_id <> r2.customer_id
GROUP BY i.film_id, r1.customer_id
HAVING count(r2.customer_id) > 3
ORDER BY count(r2.customer_id) ASC
;

-- 3. Get all possible pairs of actors and films.
select * from actor;
select * from film_actor;
select * from film;

select * from (
  select distinct actor_id from actor
) sub1
cross join (
  select distinct film_id, title from film
) sub2
order by actor_id, film_id;

