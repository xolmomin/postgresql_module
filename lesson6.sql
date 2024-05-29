select generate_series
from generate_series(1, 10);
-- md5, sha256


select md5(generate_series::text)
from generate_series(1, 10);

-- admin, moderator, teacher, assistant, student
create table if not exists users
(
    id   SERIAL primary key,
    type varchar(25) --
);



SELECT title,
       length,
       CASE
           WHEN length > 0 AND length <= 50 THEN 'Short'
           WHEN length > 50 AND length <= 120 THEN 'Medium'
           WHEN length > 120 THEN 'Long' END duration
FROM film
ORDER BY title;

SELECT title,
       rating,
       CASE rating
           WHEN 'G' THEN 'General Audiences'
           WHEN 'PG' THEN 'Parental Guidance Suggested'
           WHEN 'PG-13' THEN 'Parents Strongly Cautioned'
           WHEN 'R' THEN 'Restricted'
           WHEN 'NC-17' THEN 'Adults Only'
           END rating_description
FROM film
ORDER BY title;

-- task1 payment
-- eng kop har hil tolov qilgan customerlarni top 5tasini ismini chiqaring,
-- va necha hil tolov qilganligini ham

select c.first_name || ' ' || c.last_name fullname, customer_id, count(distinct amount) amount_count
from payment
         join public.customer c using (customer_id)
group by fullname, customer_id
order by amount_count desc
limit 13;

-- task2
-- shaharlar soni 5tadan kop bolgan davlatlar (ko'p shaharli),
-- aks holda esa (kam shaharli) deb chiqarish kk
-- davlat nomi, kop shaharli


-- task3
-- student (uuid,first_name,balance > 0) 2ta dona student qoshish kk

create table student
(
    id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    first_name VARCHAR(255) NOT NULL,
    balance    INTEGER      not null check (balance > 0)
);

insert into student(first_name, balance)
VALUES ('Botirjon', 150000);
insert into student(first_name, balance)
VALUES ('Tohir', 0);
select *
from student;


select c.country,
       count(city.city_id) city_count,
       case when count(city.city_id) > 5 then 'ko''p shaharli' else 'kam shaharli' end
from city
         join country c using (country_id)
group by c.country
order by city_count desc;


select coalesce(null, 123, null, 232, 32);
select left('hello', 2);
select right('hello', 2);


CREATE TABLE members
(
    id         serial PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name  VARCHAR(50) NOT NULL,
    gender     SMALLINT    NOT NULL -- 1: male, 2 female
);

INSERT INTO members (first_name, last_name, gender)
VALUES ('John', 'Doe', 1),
       ('David', 'Dave', 1),
       ('Bush', 'Lily', 2)
RETURNING *;

SELECT (
           SUM(CASE WHEN gender = 2 THEN 1 ELSE 0 END) * 1. / SUM(CASE WHEN gender = 1 THEN 1 ELSE 0 END)
           ) * 100 AS "Female/Male ratio"
FROM members;

select count(gender) filter ( where gender = 2 )
from members;


SELECT count(gender) filter ( where gender = 2 ) * 1. / count(gender) filter ( where gender = 1 ) * 100
FROM members;
delete
from members
where gender = 2;
select NULLIF(
               SUM(CASE WHEN gender = 2 THEN 1 ELSE 0 END),
               0
       )
from members;


-- admin, moderator, teacher, assistant, student
create table if not exists users
(
    id         SERIAL primary key,
    first_name varchar(25) not null,
    type       user_roles default 'student'
);


insert into users(first_name)
values ('Sarvar');
insert into users(first_name, type)
values ('Botir', 'teacher');

select *
from users;

SELECT (
           SUM(CASE WHEN gender = 2 THEN 1 ELSE 0 END) * 1. / SUM(CASE WHEN gender = 1 THEN 1 ELSE 0 END)
           ) * 100 AS "Female/Male ratio"
FROM members;



create table top_student
(
    id         serial primary key,
    first_name varchar(55) not null,
    score      integer check ( score > 70 )
);

create type user_roles as enum ('admin', 'moderator', 'teacher', 'assistant', 'student');

create domain top_student_score integer check ( value > 70);


create table top_student
(
    id         serial primary key,
    first_name varchar(55)       not null,
    score      top_student_score not null
);
insert into top_student(first_name, score)
select md5(generate_series::text) first_name, cast(random() * 30 + 71 as integer) score from generate_series(1, 100);



create table custom_film
(
    film_id          SERIAL primary key,
    title            varchar(255)                not null,
    description      text,
    release_year     year,
    language_id      smallint                    not null,
    rental_duration  smallint      default 3     not null,
    rental_rate      numeric(4, 2) default 4.99  not null,
    length           smallint,
    replacement_cost numeric(5, 2) default 19.99 not null,
    rating           mpaa_rating   default 'G'::mpaa_rating,
    last_update      timestamp     default now() not null,
    special_features text[],
    created_at       timestamp     default now()
);

select *
from custom_film;
--


select cast(random() * 15 + 5 as integer);


select left(md5(generate_series::text), cast(random() * 15 + 5 as integer)) from generate_series(1, 10);

select film_id,
       title, -- 5 - 20
       description, -- 20-
       release_year, -- 2000-now
       language_id, -- 1-10
       rental_duration, -- 5 - 25
       rental_rate, -- 1-5 float
       length, -- 25-200
       replacement_cost, -- 5-35
       rating, -- enum type dan random olish
       last_update, -- 2020-now
       special_features, -- array ichida 2-tan - 8tagacha
       created_at -- 2000-now
from film;

-- DTL
-- custom data type, enum, psql commands, generic series + index + transaction, Section 12. Managing Tables

-- high load (5mln + timing + analyze)


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