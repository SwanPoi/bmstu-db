/*
1 запрос 
Вывести имена и фамилии судей по имени David и названия номинаций, которые они судят
*/
SELECT DISTINCT J.first_name, J.last_name, N.nomination_name 
FROM judges as J 
JOIN judging ON J.id = judging.judge_id
JOIN nominations AS N ON judging.nomination_id = N.id
WHERE J.first_name = 'David';

/*
2 запрос
Вывести имена и фамилии судей, которые получают от 1000 до 2000
*/
SELECT DISTINCT J.first_name, J.last_name, J.salary
FROM judges as J 
WHERE J.salary BETWEEN 1000 AND 2000;

/*
3 запрос
Вывести имена и фамилии судей, которые судят номинации с участием саблей
*/
SELECT DISTINCT J.first_name, J.last_name, N.nomination_name 
FROM judges as J 
JOIN judging ON J.id = judging.judge_id
JOIN nominations AS N ON judging.nomination_id = N.id
WHERE N.nomination_name LIKE 'Saber%';

/*
4 запрос
Вывести бойцов, которые тренируются в клубах из городов, начинающихся на Port
*/
SELECT DISTINCT *
FROM fighters
WHERE club_id IN (SELECT Id 
                  FROM clubs
                  WHERE town LIKE 'Port%');

/*
5 запрос
Вывести список судей по имени David и их зарплаты, 
если существуют судьи по имени David с зарплатой от 3000 до 5000,
судящие на данном турнире номинации
*/
SELECT DISTINCT J.first_name, J.last_name, J.salary
FROM judges as J 
WHERE EXISTS (SELECT DISTINCT J.first_name, J.last_name, N.nomination_name 
              FROM judges as J 
              JOIN judging ON J.id = judging.judge_id
              JOIN nominations AS N ON judging.nomination_id = N.id
              WHERE J.first_name = 'David' AND J.salary BETWEEN 3000 AND 5000)
              AND J.first_name = 'David';

/*
6 запрос
Вывести судей, чей опыт больше опыта всех судей, получающих от 1000 до 2000
*/
SELECT * 
FROM judges
WHERE experience > ALL (SELECT experience
                        FROM judges
                        WHERE salary BETWEEN 1000 AND 2000);

/*
7 запрос
Вывести среднюю, минимальную и максимальную зарплату судей, имеющих опыт более 9 лет
*/
SELECT AVG(salary) as average_salary, MIN(salary) AS min_salary, MAX(salary) AS max_salary
FROM judges
WHERE experience > 9;

/*
8 запрос
Для каждого судьи вывести имя, фамилию, категорию, его зарплату и среднюю зарплату судей с такой же категорией
*/
SELECT first_name, last_name, category, salary, (SELECT AVG(salary)
                                       FROM judges AS J2
                                       WHERE J1.category=J2.category) AS avg_category_salary
FROM judges AS J1;

/*
9 запрос
Для каждого судьи вывести его разрешения исходя из категории
*/
SELECT first_name, last_name, category, 
       CASE category
            WHEN 3 THEN 'Can be only corner judge'
            WHEN 2 THEN 'Can be the main on the area'
            WHEN 1 THEN 'Can be the main on the tournament'
            ELSE 'Unknown category'
        END AS permission
FROM judges;

/*
10 запрос
Для каждого судьи вывести характеристику его зарплаты
*/
SELECT first_name, last_name, salary, 
       CASE
            WHEN salary < 3000 THEN 'Low salary'
            WHEN salary < 7000 THEN 'Normal salary'
            ELSE 'Too expensive'
        END AS salary_estimation
FROM judges;

/*
11 запрос
Добавление таблицы с id бойцов, чье число предупреждений больше среднего значения
*/
SELECT fighter_id, warnings
INTO most_dangerous_fighters
FROM tournament
where warnings > (SELECT AVG(warnings) FROM tournament);

/*
12 запрос
Для каждого клуба вывести, сколько человек старше 9 лет занимаются в нем
*/
SELECT id, club_name, C.count_fighters
FROM clubs JOIN (SELECT club_id, COUNT(*) AS count_fighters
                 FROM fighters
                 WHERE age > 9
				 GROUP BY club_id
                ) 
                 AS C ON clubs.id = C.club_id;

/*
13 запрос

*/


/*
14 запрос
Сгруппировать судей по категории и опыту
*/
SELECT category, experience, COUNT(*) AS count_judges
FROM judges
GROUP BY category, experience
ORDER BY category, experience;

/*
15 запрос
Сгруппировать судей, имеющих опыта больше среднего, по категории и опыту
*/
SELECT category, experience, COUNT(*) AS count_judges
FROM judges
GROUP BY category, experience
having experience > (SELECT AVG(experience) FROM judges)
ORDER BY category, experience;

/*
16 запрос
Вставка одного клуба
*/
INSERT INTO clubs (club_name, found_date, branch_count, town)
VALUES ('Orsi', '2016-11-05', 1, 'Moscow');

/*
17 запрос
Вставка клубов с числом отделений, равному максимальному числу отделений
*/
INSERT INTO clubs (branch_count, club_name, found_date, town)
SELECT (SELECT MAX(branch_count) FROM clubs), club_name, found_date, town
FROM clubs
WHERE town LIKE 'Lake%';

/*
18 запрос
Добавление двух филиалов клубам, имеющим название Slavs
*/
UPDATE clubs
SET branch_count = branch_count + 2
WHERE club_name = 'Slavs';

/*
19 запрос
Добавление минимального числа филиалов клубам с максимальным числом филиалов
*/
UPDATE clubs
SET branch_count = branch_count + (SELECT MIN(branch_count) FROM clubs) 
WHERE branch_count = (SELECT MAX(branch_count) FROM clubs);

/*
20 запрос
Удаление ранее добавленных клубов с идентификатором больше 1000
*/
DELETE FROM clubs
WHERE id > 1000

/*
21 запрос
Удаление клубов с таким же числом филиалов, что и у клубов из города North Christinemouth
*/
DELETE FROM clubs
WHERE branch_count in (SELECT branch_count
                       FROM clubs 
                       WHERE town='North Christinemouth');

/*
22 запрос
Сгруппировать судей, имеющих опыта больше среднего, по категории и опыту
Выбрать максимальное число судей в группе
*/
WITH CTE AS (
    SELECT category, experience, COUNT(*) AS count_judges
    FROM judges
    GROUP BY category, experience
    having experience > (SELECT AVG(experience) FROM judges)
    ORDER BY category, experience
)
SELECT MAX(count_judges)
FROM CTE;

/*
23 запрос
Строится таблица тренеров
*/
DROP TABLE IF EXISTS coaches;

CREATE TABLE coaches 
(
    id SERIAL PRIMARY KEY,
    coach_id INT,
    name VARCHAR(30)
);

INSERT INTO coaches(coach_id, name) VALUES 
(null, 'Ivan'),
(1, 'Vlad'), --2
(2, 'Mark'), --3
(1, 'Alex'), --4
(6, 'Kirill'), --5
(2, 'Stas'), --6
(4, 'Fred');--7


WITH RECURSIVE CoachTree(id, name, coach_id, level) AS 
(
    SELECT id, name, coach_id, 1
    FROM coaches
    WHERE coach_id IS null
    UNION ALL
    SELECT c.id, c.name, c.coach_id, s.level + 1
    FROM coaches as c
    join CoachTree as s ON c.coach_id = s.id
)
SELECT *
FROM CoachTree
WHERE level > 2;

/*
24 запрос
Для каждого судьи вывести минимальную, максимальную и среднюю зарплаты для судей с такой же категорией
*/
SELECT first_name, last_name, category, salary,
       MIN(salary) OVER(PARTITION BY category) AS min_salary,
       MAX(salary) OVER(PARTITION BY category) AS max_salary,
       AVG(salary) OVER(PARTITION BY category) AS avg_salary
FROM judges;

/*
25 запрос
Вывести список уникальных номинаций по полу и весу
*/
SELECT nomination_name, gender, weight_category
FROM nominations;

WITH unique_nominations AS
(
	SELECT nomination_name, gender, weight_category,
	ROW_NUMBER() OVER(PARTITION BY nomination_name, gender, weight_category) AS new_index
	FROM nominations
)
SELECT * FROM unique_nominations
WHERE new_index = 1;