CREATE TABLE t_course
(
    id    SERIAL,
    name  VARCHAR(255) UNIQUE NOT NULL,
    price DECIMAL(5, 2)       NOT NULL
);


-- t_course (name, price)

-- insert qilinadi
-- python, 500_000
-- java, 400_000


-- insert qilinadi
-- php, 600_000
-- java, 500_000


-- insert qilinadi agar bor bolsa ustiga qoshish (eski summaga qoshvorish kk)
-- php, 100_000
-- java, 200_000
-- go, 200_000

-- insert qilinadi agar eski summadan katta bolsa yangisini olish kk,
-- agar kichik bolsa eskiga qoshish, teng bolsa eskisi qolsin
-- php, 100_000
-- java, 800_000
-- go, 200_000


-- CREATE TABLE action_film
-- (
--     film_id SERIAL PRIMARY KEY ,
--
-- );


SELECT *
from action_film;

CREATE TABLE action_film
AS
SELECT film_id,
       title,
       release_year,
       length,
       rating
FROM film
         INNER JOIN film_category USING (film_id)
WHERE category_id = 1;

CREATE TABLE new_table_actor AS
    TABLE actor
    WITH NO DATA;

CREATE TEMPORARY TABLE new_table_actor_2 AS
    TABLE actor;



CREATE TEMPORARY TABLE IF NOT EXISTS action_film_temp(id, name)
AS
SELECT film_id,
       title,
       release_year,
       length,
       rating
FROM film
         INNER JOIN film_category USING (film_id)
WHERE category_id = 1;


select *
from action_film_temp;

ALTER TABLE action_film
    drop column film_id;

ALTER TABLE action_film
    add column film_id SERIAL PRIMARY KEY;

drop sequence test_p22_id_seq;

CREATE SEQUENCE if not exists test_p22_id_seq;


select pg_get_serial_sequence('t_student', 'id');
select currval(pg_get_serial_sequence('t_student', 'id'));


select nextval('test_p22_id_seq');
select nextval('t_student_id_seq');
select currval('t_student_id_seq');

select currval('test_p22_id_seq');

-- CREATE TABLE table_name (
--     id integer NOT NULL DEFAULT nextval('table_name_id_seq')
-- );
--
-- ALTER SEQUENCE table_name_id_seq
-- OWNED BY table_name.id;

--

create view film_category_info as
select f.title, c.name
from film f
         join film_category fc using (film_id)
         join category c using (category_id);


create materialized view film_category_info_material as
select f.title, c.name
from film f
         join film_category fc using (film_id)
         join category c using (category_id);


REFRESH MATERIALIZED VIEW film_category_info_material;

select *
from film_category_info_material;


-- CREATE MATERIALIZED VIEW [IF NOT EXISTS] view_name
-- AS
-- query
-- WITH [NO] DATA;


-- normalization

select *
from actor_info;

-- scheme
-- kitoblar
-- Animation: Anaconda Confessions, Children: Language Cowboy, Classics: Color Philadelphia, Westward Seabiscuit, Comedy: Vertigo Northwest, Documentaryyyy123: Academy Dinosaur, Family: King Evolution, Splash Gump, Foreign: Mulholland Beast, Games: Bulworth Commandments, Human Graffiti, Horror: Elephant Trojan, Lady Stage, Rules Human, Music: Wizard Coldblooded, New: Angels Life, Oklahoma Jumanji, Sci-Fi: Cheaper Clyde, Sports: Gleaming Jawbreaker


-- t_course
-- task-1
-- 1-10
-- n

-- insert into film(film_id, title) values  (DEFAULT, '123');
-- task-2 (insert qilishda yoq bolgan id larga qoshish kk)
-- php
-- react
-- vuejs


-- task-3
-- eng oxirgi qoshilgan data idsi seq_id ga tegnlash kk
-- setval() function orqali qilinadi
select id
from t_course;
select (select currval('t_course_id_seq')) - (select count(id) from t_course);

select nextval('t_course_id_seq');
select currval('t_course_id_seq');

insert into t_course(name)  values ('flutter');

-- DDL - create, alter, drop
-- DML -
-- DQL
select * from t_course;

select setval('t_course_id_seq', 7);

-- task-4 (insertda 1talik, table idsi nechchiga kelgan bolsa shungacha korsin)
-- agar id lardan birortasi ochirilgan bolsa, o'sha id bilan qoshish kk


select pg_get_serial_sequence('t_student', 'id');
select currval(pg_get_serial_sequence('t_student', 'id'));


select nextval('test_p22_id_seq');
select nextval('t_student_id_seq');
select currval('t_student_id_seq');



-- backup, cron
-- pgcron

-- pl/pgsql



