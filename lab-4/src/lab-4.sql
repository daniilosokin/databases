/* =========================== ЗАДАНИЕ 1 ============================ */
CREATE VIEW non_updated_view AS
     SELECT model_title,
            COUNT(bicycle_id) AS count
       FROM models
            LEFT JOIN bicycles
		    ON bicycles.model_id = models.model_id
      GROUP BY model_title;
      
/* =========================== ЗАДАНИЕ 2 ============================ */
CREATE VIEW updated_view AS
     SELECT point_id,
            point_title
       FROM rental_points;
