-- DTL
-- generic series + index + transaction, Section 12. Managing Tables

-- homework
-- Section 10. Transactions
-- https://www.postgresqltutorial.com/postgresql-views/
-- https://www.postgresqltutorial.com/postgresql-indexes/
-- https://www.postgresql.org/docs/current/app-psql.html#APP-PSQL-PATTERNS

-- 1. [table yaratish kk] users(id, first_name, last_name, telegram_id, created_at)
-- tableda telegram id lari bir hil bo'lganlarni eng birinchisi qoldirib qolganiga null yozish kk

-- 2. har bir actorning ismi uzunligining yarmiga teng bolgan ismli actorlar soni bilan chiqarish
-- Botirjon, 8ta(uzunligi 4ta teng bolgan ismlar soni)

-- random toldirish custom film table ni
-- select film_id,
--        title, -- 5 - 20
--        description, -- 20-
--        release_year, -- 2000-now
--        language_id, -- 1-10
--        rental_duration, -- 5 - 25
--        rental_rate, -- 1-5 float
--        length, -- 25-200
--        replacement_cost, -- 5-35
--        rating, -- enum type dan random olish
--        last_update, -- 2020-now
--        special_features, -- array ichida 2-tan - 8tagacha
--        created_at -- 2000-now
-- from film;

-- index + full text search


-- 1741, 1693

-- 341, 2021, 160
-- 341, 2022, 82
-- null, 2021, 210
-- null, 2022, 201
-- null, null, umumiy summa

-- har bir customer yiliga qancha payment amalga oshirgan
-- har bir yildagi payment summasi
-- umumiy paymentlar summasi

-- select customer_id, extract(year from payment_date) payment_year, sum(amount)
-- from payment
-- group by rollup (payment_year, customer_id)
-- order by customer_id, payment_year;


WITH cte_rental AS (SELECT staff_id,
                           COUNT(rental_id) rental_count
                    FROM rental
                    GROUP BY staff_id),
     cte_rental1 AS (SELECT staff_id,
                            COUNT(rental_id) rental_count
                     FROM rental
                     GROUP BY staff_id),
     cte_rental2 AS (SELECT staff_id,
                            COUNT(rental_id) rental_count
                     FROM rental
                     GROUP BY staff_id)

SELECT s.staff_id,
       first_name,
       last_name,
       rental_count
FROM staff s
         INNER JOIN cte_rental USING (staff_id);


SELECT s.staff_id,
       first_name,
       last_name,
       rental_count
FROM staff s
         INNER JOIN (SELECT staff_id,
                            COUNT(rental_id) rental_count
                     FROM rental
                     GROUP BY staff_id) as t USING (staff_id);

CREATE TABLE employees
(
    employee_id SERIAL PRIMARY KEY,
    full_name   VARCHAR NOT NULL,
    manager_id  INT
);

INSERT INTO employees (employee_id, full_name, manager_id)
VALUES (21, 'Botir', 13);

INSERT INTO employees (employee_id, full_name, manager_id)
VALUES (1, 'Michael North', NULL),
       (2, 'Megan Berry', 1),
       (3, 'Sarah Berry', 1),
       (4, 'Zoe Black', 1),
       (5, 'Tim James', 1),
       (6, 'Bella Tucker', 2),
       (7, 'Ryan Metcalfe', 2),
       (8, 'Max Mills', 2),
       (9, 'Benjamin Glover', 2),
       (10, 'Carolyn Henderson', 3),
       (11, 'Nicola Kelly', 3),
       (12, 'Alexandra Climo', 3),
       (13, 'Dominic King', 3),
       (14, 'Leonard Gray', 4),
       (15, 'Eric Rampling', 4),
       (16, 'Piers Paige', 7),
       (17, 'Ryan Henderson', 7),
       (18, 'Frank Tucker', 8),
       (19, 'Nathan Ferguson', 8),
       (20, 'Kevin Rampling', 8);

WITH RECURSIVE subordinates AS (SELECT employee_id,
                                       manager_id,
                                       full_name
                                FROM employees
                                WHERE employee_id = 3

                                UNION

                                SELECT e.employee_id,
                                       e.manager_id,
                                       e.full_name
                                FROM employees e
                                         INNER JOIN subordinates s ON s.employee_id = e.manager_id)

SELECT *
FROM subordinates;



-- 0-task
-- olcha.uz ni category va product, review lari table ni yozish


-- 1-task
-- t_category(name, parent_id)
-- t_product(name, price, category_id)
-- 1ta kategoriyaga tegishli categoriyalarni chiqarish


-- 2-task
-- 1ta categoryga tegishli productlar sonini chiqarish


-- 3-task
-- eng kop productga ega bolgan category ni chiqaring

-- resource
-- https://www.postgresqltutorial.com/postgresql-window-function/






