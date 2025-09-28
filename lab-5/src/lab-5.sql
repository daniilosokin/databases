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