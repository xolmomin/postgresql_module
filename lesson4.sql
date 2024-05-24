DROP TABLE IF EXISTS t_product;
DROP TABLE IF EXISTS t_category;


-- ManyToOne
CREATE TABLE IF NOT EXISTS t_category
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);


CREATE TABLE t_product
(
    id          SERIAL,
    name        VARCHAR(255) NOT NULL,
    price       INTEGER DEFAULT 0,
    category_id INTEGER
        CONSTRAINT fk_customer REFERENCES t_category (id)
);


-- OneToOne
CREATE TABLE IF NOT EXISTS t_category
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);


CREATE TABLE t_product
(
    id          SERIAL,
    name        VARCHAR(255) NOT NULL,
    price       INTEGER DEFAULT 0,
    category_id INTEGER
        CONSTRAINT fk_customer REFERENCES t_category (id) UNIQUE
);


-- ManyToMany
CREATE TABLE IF NOT EXISTS t_course
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);


CREATE TABLE t_student
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE t_course_student
(
    id        SERIAL PRIMARY KEY,
    course_id INTEGER
        CONSTRAINT fk_course REFERENCES t_course (id) on delete CASCADE ,
    user_id   INTEGER
        CONSTRAINT fk_user REFERENCES t_student (id)
);



SELECT film_id, title, length, rating
FROM film f
WHERE length > (
    SELECT AVG(length)
    FROM film
    WHERE rating = f.rating
);

select rating, avg(length) from film group by rating;

select * from film where title ilike '%ab%';
select exists(select film_id from film where title ilike '%ab%');

-- 2020-2024 filmdagi last_update

select random() * (now() -  timestamp '2020-01-01') + timestamp '2020-01-01';

update film set created_at=timestamp '2020-01-01' + (random() * (now() -  timestamp '2020-01-01')) where True;

update film set last_update=now() - interval '5 year' where true;


select last_update from film;

alter table film add column created_at timestamp default now();


update payment set payment_date=timestamp '2020-01-01' + (random() * (now() -  timestamp '2020-01-01')) where True;

select * from t_student;

update t_student set name = 'shokirbek' where id=3  returning *;
delete from t_student where id=1;
-- 2020-now



-- 1.task
-- payment
-- 2020 1500
-- 2021 1765

-- 2.task
-- 2020, 02 oyda, 56 ta tolov
-- 2020, 06 oyda, 81 ta tolov

-- 3.task(payment)
-- eng kop qaysi oyda tolov bolgan va jami nechta

-- 4.task(actor, payment)
-- film(release_year) update [2020-now]
-- eng kop tolov bolgan top 2ta yildagi
-- (osha yildagi eng kop actorlar rol oynagan kinoni nomi, actor soni)

-- 2021
-- kino1 23
-- kino2 23
-- kino3 23
-- kino5 23
-- kino4 23

-- 5.task(actor)
-- eng uzun ismli actorlarni top 10tasi qaysi kinoda oynagan

-- 6.task (payment)
-- eng kop tolov bolgan yildagi, eng kop tolov bolgan oy da,
-- tolovlar qaysi sanaga togri kelishi va hafta kunini chiqaring
-- 2024, 01, 18, 6

-- 7.task (payment)
-- otgan oydagi 9:00 - 18:00 oraliqdagi va
-- (5kunlik ish kunida) eng kop tolov bolgan hafta kunini chiqaring
-- tolovlar qaysi sanaga togri kelishi va hafta kunini chiqaring

-- 8.task(customer, country)
-- haridorlarga ega bolgan top 10ta davlatni chiqaring, haridorlar soni bilan
-- Spain, 35ta

-- 9.task
-- haridorlarni tolovlar soni, actorlarni rol oynagan kinolar soniga teng bolganlarni chiqarish
-- haridor fullname, actor fullname

-- when,case, if, then, array, jsonb
