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