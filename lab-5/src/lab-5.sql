/* =========================== ЗАДАНИЕ 1 ============================ */
DELIMITER //

CREATE PROCEDURE 
    linked_records()
BEGIN
    SELECT 
        bicycle_id,
        serial_number,
        model_title
    FROM 
        bicycles
    JOIN 
        models 
        ON bicycles.model_id = models.model_id;
END;//

DELIMITER ;

/* =========================== ЗАДАНИЕ 2 ============================ */
DELIMITER //

CREATE FUNCTION
    concat_fields(lhs VARCHAR(99), rhs VARCHAR(99))
RETURNS 
    VARCHAR(200)
DETERMINISTIC
BEGIN
    RETURN CONCAT(lhs, ' ', rhs);
END;//

DELIMITER ;

/* =========================== ЗАДАНИЕ 3 ============================ */
DELIMITER //

CREATE FUNCTION
    arithmetic_operation(start_time DATETIME, end_time DATETIME)
RETURNS 
    INT
DETERMINISTIC
BEGIN
    RETURN TIMESTAMPDIFF(HOUR, start_time, end_time);
END;//

DELIMITER ;

/* =========================== ЗАДАНИЕ 4 ============================ */
DELIMITER //

CREATE PROCEDURE 
    filtered_data()
BEGIN
    SELECT 
        concat_fields(first_name, last_name) AS full_name,
        serial_number,
        model_title,
        arithmetic_operation(start_time, end_time) AS duration
    FROM 
        rental
    JOIN
        customers
        ON rental.customer_id = customers.customer_id
    JOIN 
        bicycles 
        ON rental.bicycle_id = bicycles.bicycle_id
    JOIN 
        models 
        ON bicycles.model_id = models.model_id
    WHERE 
        arithmetic_operation(start_time, end_time) > 3;
END;//

DELIMITER ;

/* =========================== ЗАДАНИЕ 5 ============================ */
DELIMITER //

CREATE PROCEDURE 
    aggregated_with_cursor()
BEGIN
    DECLARE current_duration INT;
    DECLARE min_duration INT DEFAULT NULL;
    DECLARE max_duration INT DEFAULT NULL;
    DECLARE total_duration BIGINT DEFAULT 0;
    DECLARE rental_count INT DEFAULT 0;
    DECLARE finished INT DEFAULT 0;
    
    DECLARE cursor_rental_duration CURSOR FOR 
        SELECT 
            TIMESTAMPDIFF(HOUR, start_time, end_time) AS duration 
        FROM
            rental
        WHERE
            end_time IS NOT NULL;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;

    OPEN cursor_rental_duration;
    
    read_loop: LOOP
        FETCH cursor_rental_duration 
        INTO current_duration;
        
        IF finished = 1 THEN
            LEAVE read_loop;
        END IF;
          
        IF rental_count = 0 THEN
            SET min_duration = current_duration;
            SET max_duration = current_duration;
        END IF;
        
        IF current_duration < min_duration THEN
            SET min_duration = current_duration;
        END IF;
        
        IF current_duration > max_duration THEN
            SET max_duration = current_duration;
        END IF;
        
        SET total_duration = total_duration + current_duration;
        SET rental_count = rental_count + 1;
    END LOOP;
    
    CLOSE cursor_rental_duration;

    SELECT
        min_duration AS min,
        max_duration AS max,
        total_duration / rental_count AS avg;
END;//

DELIMITER ;

/* =========================== ЗАДАНИЕ 6 ============================ */
DELIMITER //

CREATE PROCEDURE 
    aggregated_without_cursor()
BEGIN
    SELECT 
        MIN(TIMESTAMPDIFF(HOUR, start_time, end_time)) AS min,
        MAX(TIMESTAMPDIFF(HOUR, start_time, end_time)) AS max,
        AVG(TIMESTAMPDIFF(HOUR, start_time, end_time)) AS avg
    FROM 
        rental
    WHERE 
        end_time IS NOT NULL;
END;//

DELIMITER ;