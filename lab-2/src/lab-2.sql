/* ======================= TASK 1 ======================= */
SELECT title, 
       description 
  FROM film
 WHERE title LIKE '%tin%';

/* ======================= TASK 2 ======================= */
SELECT DISTINCT first_name 
  FROM actor
 ORDER BY first_name ASC;

/* ======================= TASK 3 ======================= */
SELECT first_name, 
       last_name, 
	   country 
  FROM customer
	   JOIN address 
		 ON address.address_id = customer.address_id
       JOIN city    
	     ON city.city_id = address.city_id
	   JOIN country 
	     ON country.country_id = city.country_id
 WHERE country LIKE 'Germany' 
	OR country LIKE 'Italy' 
    OR country LIKE 'Spain';

/* ======================= TASK 4 ======================= */
SELECT title, 
       name AS category 
  FROM film
       JOIN film_actor    
	     ON film_actor.film_id = film.film_id
       JOIN actor
	     ON actor.actor_id = film_actor.actor_id
       JOIN film_category 
         ON film_category.film_id = film.film_id
       JOIN category
	     ON category.category_id = film_category.category_id
 WHERE first_name LIKE 'FRED' 
   AND last_name  LIKE 'COSTNER';
    
/* ======================= TASK 5 ======================= */
SELECT name        AS category, 
	   SUM(amount) AS payment_amount 
  FROM payment
       JOIN rental        
         ON rental.rental_id = payment.rental_id
       JOIN inventory     
	     ON inventory.inventory_id = rental.inventory_id
       JOIN film_category 
	     ON film_category.film_id = inventory.film_id
	   JOIN category      
	     ON category.category_id = film_category.category_id
 GROUP BY name
 ORDER BY payment_amount DESC LIMIT 10;

/* ======================= TASK 6 ======================= */
SELECT customer.first_name, 
       customer.last_name, 
       COUNT(rental.rental_id) AS films_count 
  FROM customer
       JOIN rental     
	     ON rental.customer_id = customer.customer_id
       JOIN inventory  
	     ON inventory.inventory_id = rental.inventory_id
       JOIN film_actor 
	     ON film_actor.film_id = inventory.film_id
       JOIN actor      
	     ON actor.actor_id = film_actor.actor_id
 WHERE actor.first_name = 'RUSSELL' 
   AND actor.last_name  = 'CLOSE'
 GROUP BY customer.customer_id
 ORDER BY films_count DESC LIMIT 5 OFFSET 5;

/* ======================= TASK 7 ======================= */
WITH films_revenue AS 
     (SELECT film.film_id, 
             SUM(amount) AS revenue 
	    FROM film
	         JOIN inventory 
               ON inventory.film_id = film.film_id
	         JOIN rental    
               ON rental.inventory_id = inventory.inventory_id
			 JOIN payment 
               ON payment.rental_id = rental.rental_id
	   GROUP BY film.film_id)
SELECT title, 
       first_name, 
	   last_name 
  FROM film
       JOIN film_actor 
         ON film_actor.film_id = film.film_id
       JOIN actor 
         ON actor.actor_id = film_actor.actor_id
 WHERE film.film_id IN 
	   (SELECT film_id 
          FROM films_revenue
	     WHERE revenue = (SELECT MIN(revenue) 
                            FROM films_revenue));

/* ======================= TASK 8 ======================= */
  WITH film_actor_counts AS 
       (SELECT film_id, 
               COUNT(actor_id) AS actor_count 
          FROM film_actor
		 GROUP BY film_id)
SELECT actor_count AS actors, 
       COUNT(film_id) AS films 
  FROM film_actor_counts
 WHERE actor_count = (SELECT MIN(actor_count) AS min_count 
                        FROM film_actor_counts)
 GROUP BY actor_count;