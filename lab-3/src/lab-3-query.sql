/* =========================== ЗАПРОС 1 ============================ */
SELECT model_title,
       COUNT(model.model_id) as count
  FROM bicycles
	   JOIN model
		 ON bicycles.model_id = model.model_id
 GROUP BY model.model_id;
 
/* =========================== ЗАПРОС 2 ============================ */
SELECT DISTINCT point_id,
       point_title
  FROM rental
       JOIN rental_points
         ON rental.pick_point_id = rental_points.point_id
	   JOIN bicycles
		 ON rental.bicycle_id = bicycles.bicycle_id
	   JOIN model
         ON bicycles.model_id = model.model_id
 WHERE model_title LIKE 'Bianchi Oltre'
 ORDER BY point_title;