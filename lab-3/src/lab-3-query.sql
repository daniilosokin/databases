/* =========================== ЗАПРОС 1 ============================ */
SELECT model_title,
       COUNT(model.model_id) AS count
  FROM bicycles
	   JOIN model
		 ON model.model_id = bicycles.model_id
 GROUP BY model.model_id;
 
/* =========================== ЗАПРОС 2 ============================ */
SELECT DISTINCT point_id,
       point_title
  FROM rental
       JOIN rental_points
         ON rental_points.pick_point_id = rental.point_id
	   JOIN bicycles
		 ON bicycles.bicycle_id = rental.bicycle_id
	   JOIN model
         ON model.model_id = bicycles.model_id
 WHERE model_title LIKE 'Bianchi Oltre'
 ORDER BY point_title;
 
/* =========================== ЗАПРОС 3 ============================ */
SELECT model_title,
       SUM(TIMESTAMPDIFF(HOUR, start_time, end_time)) AS duration
  FROM bicycles
	   JOIN model
		 ON model.model_id = bicycles.model_id
	   JOIN rental
		 ON rental.bicycle_id = bicycles.bicycle_id
 WHERE end_time IS NOT NULL
 GROUP BY model_title
 ORDER BY duration;
 
 /* =========================== ЗАПРОС 4 ============================ */
SELECT point_title,
       COUNT(return_point_id) as count
  FROM rental_points
       LEFT JOIN rental
         ON rental.return_point_id = rental_points.point_id
 GROUP BY point_id;