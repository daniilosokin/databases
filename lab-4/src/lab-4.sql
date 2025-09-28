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

/* =========================== ЗАДАНИЕ 3 ============================ */
CREATE VIEW inserted_view AS
     SELECT *
       FROM bicycles
	  WHERE model_id = 9
 WITH LOCAL CHECK OPTION;

/* =========================== ЗАДАНИЕ 4 ============================ */
  CREATE VIEW cascaded_view AS
       SELECT *
         FROM inserted_view
        WHERE serial_number LIKE '%002%'
WITH CASCADED CHECK OPTION;

/* =========================== ЗАДАНИЕ 5 ============================ */
DELIMITER //
	CREATE TRIGGER current_time_trigger
			BEFORE INSERT
		        ON rental
	           FOR EACH ROW
	         BEGIN
				    IF NEW.start_time IS NULL THEN
                       SET NEW.start_time = CURDATE();
		           END IF;
			   END ; //
DELIMITER ;

/* =========================== ЗАДАНИЕ 6 ============================ */
DELIMITER //
	CREATE TRIGGER rental_point_verify_trigger
			BEFORE INSERT
		        ON rental
	           FOR EACH ROW
	         BEGIN
				     IF NEW.pick_point_id NOT IN 
                        (SELECT point_id 
                           FROM rental_points) 
				   THEN
                        SIGNAL SQLSTATE '45000' 
                        SET MESSAGE_TEXT = 'ОШИБКА: указана не существующая точка выдачи';
		            END IF;
			   END ; //
DELIMITER ;

/* =========================== ЗАДАНИЕ 7 ============================ */
DELIMITER //
	CREATE TRIGGER rental_delete_log_trigger 
			BEFORE DELETE 
                ON rental
		       FOR EACH ROW
	         BEGIN
				   INSERT INTO logs (username, timestamp, data) 
				    VALUE (USER(), CURDATE(), CONCAT_WS(',',
                                                        OLD.bicycle_id, 
                                                        OLD.pick_point_id, 
                                                        OLD.customer_id,
														OLD.start_time,
														COALESCE(OLD.end_time, 'NULL'),
                                                        COALESCE(OLD.return_point_id, 'NULL')));
	           END ; //
DELIMITER ;

