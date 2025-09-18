-- Вывод всех предметов.
SELECT `name` from `exam_session`.`subject`;

-- Вывод количества студентов.
SELECT count(`student_id`) as `student_count` FROM `exam_session`.`student`;

-- Вывод студентов, чья фамилия начинается на «Ива».
SELECT * FROM `exam_session`.`student`
	WHERE `surname` LIKE "Ива%";

-- Вывод студентов, родившихся позже указанной даты.
SELECT * FROM `exam_session`.`student` 
	WHERE `birthdate` > '2000-06-30';

-- Вывод студентов, получивших оценки 5 по указанному предмету.
SELECT `student`.* FROM `exam_session`.`student`
	JOIN `exam_session`.`grade` ON `grade`.`student_id` = `student`.`student_id`
	JOIN `exam_session`.`subject` ON `grade`.`subject_id` = `subject`.`subject_id`
	WHERE `grade`.`grade` = 5 and `subject`.`subject_id` = 1;

-- Вывод студентов, получивших оценки только 4 и 5 
-- по всем предметам в указанном семестре,
-- упорядочить по фамилии
SELECT `student`.* FROM `exam_session`.`student`
	JOIN `exam_session`.`grade` ON `grade`.`student_id` = `student`.`student_id`
	JOIN `exam_session`.`subject` ON `grade`.`subject_id` = `subject`.`subject_id`
	WHERE `term` = 1 AND (`grade` = 4 or `grade` = 5)
	GROUP BY `student_id`
	HAVING COUNT(*) = (
		SELECT COUNT(*) 
			FROM `exam_session`.`subject` 
			WHERE `term` = 1
	)
	ORDER BY `surname` ASC;
