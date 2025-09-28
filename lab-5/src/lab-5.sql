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
    DECLARE is_done          BOOL DEFAULT FALSE;
    DECLARE min_duration     INT  DEFAULT NULL;
    DECLARE max_duration     INT  DEFAULT NULL;
    DECLARE total_duration   INT  DEFAULT 0;
    DECLARE count_records    INT  DEFAULT 0;
    DECLARE current_duration INT;
    
    DECLARE duration_cursor CURSOR
    FOR
        SELECT 
            TIMESTAMPDIFF(MINUTE, start_time, end_time) AS duration
        FROM 
            rental
        WHERE 
            end_time IS NOT NULL;
            
    DECLARE CONTINUE HANDLER 
    FOR 
        NOT FOUND 
    SET 
        is_done = TRUE;
    
    OPEN 
        duration_cursor;
        
    read_loop: LOOP
        FETCH 
            duration_cursor 
        INTO 
            current_duration;
            
        IF 
            is_done 
            THEN
                LEAVE read_loop;
        END IF;
        
        IF 
            min_duration IS NULL 
            OR current_duration < min_duration 
            THEN SET 
                min_duration = current_duration;
        END IF;
        
        IF 
            max_duration IS NULL
            OR current_duration > max_duration
            THEN SET 
                max_duration = current_duration;
        END IF;
        
        SET total_duration = total_duration + current_duration;
        SET count_records  = count_records  + 1;
    END LOOP;
    
    CLOSE 
        duration_cursor;
    SELECT 
        min_duration AS min,
        max_duration AS max,
        IF(count_records > 0, total_duration / count_records, NULL) AS avg;
END; //

DELIMITER ;