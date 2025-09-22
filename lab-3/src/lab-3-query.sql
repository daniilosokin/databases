/* =========================== ЗАПРОС 1 ============================ */
SELECT model_title,
       COUNT(models.model_id) AS count
  FROM bicycles
	   JOIN models
		 ON models.model_id = bicycles.model_id
 GROUP BY models.model_id;
 
/* =========================== ЗАПРОС 2 ============================ */
SELECT DISTINCT point_id,
       point_title
  FROM rental
       JOIN rental_points
         ON rental_points.point_id = rental.pick_point_id
	   JOIN bicycles
		 ON bicycles.bicycle_id = rental.bicycle_id
	   JOIN models
         ON models.model_id = bicycles.model_id
 WHERE model_title LIKE 'Bianchi Oltre'
 ORDER BY point_title;
 
/* =========================== ЗАПРОС 3 ============================ */
SELECT model_title,
       SUM(TIMESTAMPDIFF(HOUR, start_time, end_time)) AS duration
  FROM bicycles
	   JOIN models
		 ON models.model_id = bicycles.model_id
	   JOIN rental
		 ON rental.bicycle_id = bicycles.bicycle_id
 WHERE end_time IS NOT NULL
 GROUP BY model_title
 ORDER BY duration;
 
/* =========================== ЗАПРОС 4 ============================ */
SELECT point_title,
       COUNT(return_point_id) AS count
  FROM rental_points
       LEFT JOIN rental
         ON rental.return_point_id = rental_points.point_id
 GROUP BY point_id;
 
/* =========================== ЗАПРОС 5 ============================ */
  WITH customer_rental_counts AS 
       (SELECT customer_id, 
               COUNT(bicycle_id) AS rental_count 
          FROM rental
		 GROUP BY customer_id)
SELECT first_name,
       last_name,
       rental_count AS count
  FROM customers
       JOIN customer_rental_counts
       ON customer_rental_counts.customer_id = customers.customer_id
 WHERE rental_count = 
       (SELECT MAX(rental_count) 
          FROM customer_rental_counts);
          
/* =========================== ЗАПРОС 6 ============================ */
WITH customer_rental_avg AS
	 (SELECT customer_id, 
             AVG(TIMESTAMPDIFF(HOUR, start_time, end_time)) AS rental_avg
        FROM rental
       WHERE end_time IS NOT NULL
	   GROUP BY customer_id)
SELECT first_name,
       last_name,
       rental_avg AS avg
  FROM customers
	   JOIN customer_rental_avg
		 ON customer_rental_avg.customer_id = customers.customer_id
 WHERE rental_avg > 3
 GROUP BY customers.customer_id;