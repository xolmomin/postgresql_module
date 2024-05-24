-- HOMEWORK
-- 0. https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-data-types/
-- 1. psql commands
-- Section 1. Querying Data
-- Section 2. Filtering Data
-- Section 3. Joining Multiple Tables
-- Section 11. Import & Export Data
-- Section 13. PostgreSQL Constraints
-- Section 14. PostgreSQL Data Types in Depth
-- Section 16. PostgreSQL Utilities



select *
from city c
         join country ct on ct.country_id = c.country_id;


select *
from city c
         join country ct USING (country_id);

SELECT *
FROM city
         NATURAL JOIN country;

-- last_update, country_id

select *
from city c
         INNER join country ct on ct.country_id = c.country_id;

-- select a.actor_id, a.first_name from actor a join;


-- O2O - OneToOne
-- O2M - OneToMany
-- M2O - ManyToOne
-- M2M - ManyToMany


-- mysql, oracle, sqlite
-- data.sql

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

DROP TABLE t_product;
CREATE TABLE t_product
(
    id          SERIAL,
    name        VARCHAR(255) NOT NULL,
    price       INTEGER DEFAULT 0,
    category_id INTEGER REFERENCES t_category (id) -- M2O
);


INSERT INTO t_category(name)
VALUES ('meva');
INSERT INTO t_product(name, category_id)
VALUES ('olma', 8);
INSERT INTO t_product(name, category_id)
VALUES ('olma', 8);

CREATE TABLE t_product
(
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(255) NOT NULL,
    price       INTEGER DEFAULT 0,
    category_id INTEGER,
    CONSTRAINT fk_category_product
        FOREIGN KEY (category_id)
            REFERENCES t_category (id)
);

select *
from t_product p
         left join t_category c on c.id = p.category_id;
DROP table t_product;
CREATE TABLE t_product
(
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(255) NOT NULL,
    price       INTEGER DEFAULT 0,
    category_id INTEGER
);

create table t_user
(
    id     serial primary key,
    name   varchar(255) not null default 2,
    tlg_id bigint unique,
    age    integer check ( age > 10 )
);
select random() * 5 + 15;

update t_user
set age=random() * 5 + 15
where age is null;

alter table t_user
    alter column age set not null;
alter table t_user
    drop column age;

alter table t_user
    add column birth_date date check ( extract(year from birth_date) > 2000 and extract(year from birth_date) < 2022);

alter table t_user
    add column birth_date date check ( extract(year from birth_date) between 2000 and 2022);

alter table t_user
    add column birth_date date check ( extract(year from birth_date) between 2000 and extract(year from current_date) - 2);


alter table t_user
    drop column birth_date;
alter table t_user
    drop constraint t_user_birth_date_check;
alter table t_user
    add check ( extract(year from birth_date) between 2000 and extract(year from current_date) - 2);

alter table t_user
    add constraint cheklov_birthdate_uchun check ( extract(year from birth_date) between 2000 and extract(year from current_date) - 2);


-- NOT NULL - o

select f.title, c.city
from film f
         join city c on c.city_id = f.film_id;


-- keys - fk, uk, pk


DROP TABLE IF EXISTS t_product;
DROP TABLE IF EXISTS t_category;

CREATE TABLE IF NOT EXISTS t_category
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);


CREATE TABLE t_product
(
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(255) NOT NULL,
    price       INTEGER DEFAULT 0,
    category_id INTEGER DEFAULT 2,
    CONSTRAINT fk_category_product
        FOREIGN KEY (category_id)
            REFERENCES t_category (id)
            ON DELETE CASCADE
);

delete from t_category where id =3;


select *
from customer;


-- Linda Williams,Spain
-- filmnomi, tili

select f.title, c.name
from film f
         join film_category fc on fc.film_id = f.film_id
         join category c on c.category_id = fc.category_id;


-- HOMEWORK
-- 0. https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-data-types/
-- 1. psql commands
-- Section 1. Querying Data
-- Section 2. Filtering Data
-- Section 3. Joining Multiple Tables
-- Section 11. Import & Export Data
-- Section 13. PostgreSQL Constraints
-- Section 14. PostgreSQL Data Types in Depth
-- Section 16. PostgreSQL Utilities

-- HOMEWORK
-- 1ta category nechta kino bor
-- 1ta filmda nechta actor rol oynagan
-- eng kop rol oynagan top 5ta actor ismi, va nechta kinoda rol oynaganligi
-- eng kop tolov qilgan top 3ta customerni ism, familyasi va qancha tolov qilganligi

