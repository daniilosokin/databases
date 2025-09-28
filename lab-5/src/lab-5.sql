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
END//

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
END//

DELIMITER ;

/* =========================== ЗАДАНИЕ 4 ============================ */
DELIMITER //

CREATE PROCEDURE 
    filtered_data()
BEGIN
    SELECT 
        concat_fields(first_name, last_name) as full_name,
        serial_number,
        model_title,
        arithmetic_operation(start_time, end_time) as duration
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