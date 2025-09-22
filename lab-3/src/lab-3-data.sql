/* ====================== ЗАПОЛНЕНИЕ ТАБЛИЦ ======================= */
INSERT INTO bike_rental.model (model_title) 
VALUES ('Stels'),
       ('Format'),
       ('Bianchi Oltre'),
       ('Forward'),
       ('Merida');
    
INSERT INTO bike_rental.bicycles (model_id, serial_number) 
VALUES (1, 2245), (1, 1981), (1, 1987), (1, 1959), (1, 2203),
       (2, 12478), (2, 12749), (2, 12479),
	   (3, 103), (3, 504),
       (4, 96661),
       (5, 15416), (5, 58547), (5, 7485), (5, 36584);
    
INSERT INTO bike_rental.customers (passport, phone, first_name, last_name) 
VALUES ('36 20 154169', '+7 987 111 5533', 'Игорь', 'Рюрикович'),
       ('50 11 798456', '+7 927 999 7172', 'Василий', 'Чапаев'),
       ('18 14 251985', '+7 937 888 7172', 'Эдмунд', 'Шклярский'),
       ('44 99 325741', '+44 955 777 1234', 'Дэвид', 'Гилмор'),
       ('03 02 358516', '+7 987 963 4185', 'Ильдар', 'Сибгатулин'),
       ('01 07 251471', '+7 917 000 1337', 'Валерий', 'Ульянов'),
       ('15 22 999554', '+1 555 000 7797', 'Стив', 'Перри');
    
INSERT INTO bike_rental.rental_points (point_title, lat, lot, notes)
VALUES ('Крути педали', 135.154566, 140.299987 , NULL),
       ('Веломир', 38.125666, 74.668741, NULL),
       ('eXtreme', 88.444687, 65.644135, NULL),
       ('Прокат на Куйбышева', 122.574987, '87.987745', NULL);
    
INSERT INTO bike_rental.rental (bicycle_id, pick_point_id, customer_id, start_time) 
VALUES (1, 1, 1, '2025-09-03 10:05:00'),
       (2, 1, 3, '2025-09-05 09:15:00'),
       (3, 4, 6, '2025-09-14 10:15:00'),
       (4, 3, 5, '2025-09-04 08:25:00'),
       (7, 2, 2, '2025-09-11 12:30:00'),
       (11, 1, 7, '2025-09-08 10:20:00'),
       (14, 4, 4, '2025-09-11 19:00:00');

/* ==================== РЕДАКТИРОВАНИЕ ЗАПИСЕЙ ==================== */
UPDATE bike_rental.rental
   SET end_time = '2025-09-11 21:00:00', 
       return_point_id = 4
 WHERE bicycle_id = 14
   AND end_time IS NULL
   AND return_point_id IS NULL;

UPDATE bike_rental.rental
   SET end_time = '2025-09-10 18:33:00', 
       return_point_id = 4
 WHERE bicycle_id = 11 
   AND end_time IS NULL 
   AND return_point_id IS NULL;

UPDATE bike_rental.model
   SET model_title = 'Stern'
 WHERE model_id = 1;

/* ======================= УДАЛЕНИЕ ЗАПИСЕЙ ======================= */
DELETE FROM bike_rental.rental
 WHERE customer_id = 7;

DELETE FROM bike_rental.customers
 WHERE customer_id = 7;

DELETE FROM bike_rental.rental;