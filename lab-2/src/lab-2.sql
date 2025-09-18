-- Задание №1

SELECT `title`, `description` FROM `film`
	WHERE `title` LIKE '%tin%';

-- Задание №2

SELECT DISTINCT `first_name` FROM `actor`
	ORDER BY `first_name` ASC;

-- Задание №3

SELECT `first_name`, `last_name`, `country` FROM `customer`
	RIGHT JOIN `address` ON `address`.`address_id` = `customer`.`address_id`
	RIGHT JOIN `city` ON `city`.`city_id` = `address`.`city_id`
	RIGHT JOIN `country` ON `country`.`country_id` = `city`.`country_id`
	WHERE `country` LIKE 'Germany' OR `country` LIKE 'Italy' OR `country` LIKE 'Spain';

-- Задание №4

SELECT `title`, `name` AS category FROM `film`
	RIGHT JOIN `film_actor` ON `film_actor`.`film_id` = `film`.`film_id`
	RIGHT JOIN `actor` ON `actor`.`actor_id` = `film_actor`.`actor_id`
	RIGHT JOIN `film_category` ON `film_category`.`film_id` = `film`.`film_id`
	RIGHT JOIN `category` ON `category`.`category_id` = `film_category`.`category_id`
    WHERE `first_name` LIKE 'FRED' AND `last_name` LIKE 'COSTNER';
    
-- Задание №5

SELECT `name` AS category, SUM(`amount`) AS payment_amount FROM `payment`
	LEFT JOIN `rental` ON `rental`.`rental_id` = `payment`.`rental_id`
    LEFT JOIN `inventory` ON `inventory`.`inventory_id` = `rental`.`inventory_id`
    LEFT JOIN `film_category` ON `film_category`.`film_id` = `inventory`.`film_id`
    LEFT JOIN `category` ON `category`.`category_id` = `film_category`.`category_id`
    GROUP BY `name`
    ORDER BY payment_amount DESC LIMIT 10;
    
-- Задание №6

SELECT `customer`.`first_name`, `customer`.`last_name`, count(`rental`.`rental_id`) AS films_count FROM `customer`
	RIGHT JOIN `rental` ON `rental`.`customer_id` = `customer`.`customer_id`
	RIGHT JOIN `inventory` ON `inventory`.`inventory_id` = `rental`.`inventory_id`
    RIGHT JOIN `film_actor` ON `film_actor`.`film_id` = `inventory`.`film_id`
    RIGHT JOIN `actor` ON `actor`.`actor_id` = `film_actor`.`actor_id`
    WHERE `actor`.`first_name` = 'RUSSELL' AND `actor`.`last_name` = 'CLOSE'
    GROUP BY `customer`.`customer_id`
    ORDER BY films_count DESC LIMIT 5 OFFSET 5;
    

    
