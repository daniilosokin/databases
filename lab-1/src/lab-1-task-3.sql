/* ======================= ЗАДАНИЕ 1 ======================= */
SELECT 
    name 
FROM 
    exam_session.subject;

/* ======================= ЗАДАНИЕ 2 ======================= */
SELECT
    COUNT(student_id) AS student_count 
FROM
    exam_session.student;

/* ======================= ЗАДАНИЕ 3 ======================= */
SELECT
    * 
FROM 
    exam_session.student
WHERE
    surname LIKE "Ива%";

/* ======================= ЗАДАНИЕ 4 ======================= */
SELECT
    * 
FROM
    exam_session.student 
WHERE
    birthdate > '2000-06-30';

/* ======================= ЗАДАНИЕ 5 ======================= */
SELECT 
    student.* 
FROM 
    exam_session.student
JOIN 
    exam_session.grade 
    ON grade.student_id = student.student_id
JOIN 
    exam_session.subject 
    ON grade.subject_id = subject.subject_id
WHERE 
    grade.grade = 5 
    AND subject.subject_id = 1;

/* ======================= ЗАДАНИЕ 6 ======================= */
SELECT 
    student.* 
FROM 
    exam_session.student
JOIN 
    exam_session.grade 
    ON grade.student_id = student.student_id
JOIN 
    exam_session.subject
    ON grade.subject_id = subject.subject_id
WHERE
    term = 1 
    AND grade IN (4, 5)
GROUP BY
    student_id
HAVING 
    COUNT(*) = (
        SELECT 
            COUNT(*) 
        FROM 
            exam_session.subject 
        WHERE 
            term = 1
    )
 ORDER BY
    surname ASC;