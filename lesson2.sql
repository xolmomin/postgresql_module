-- HOMEWORK
-- 0. https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-data-types/
-- 1. psql commands
-- 2. Section 1. Querying Data
-- 3. Section 2. Filtering Data
-- 4. insert, select, update, delete


-- DDL - create, alter, drop, truncate - (db, table, index, constraint, scheme, role)
-- DML - insert, update, delete, select
-- DQL - select
-- DTL - commit, rollback, savepoint
-- DCL - grant, revoke

-- select * from product;

-- Product.all()
-- Product.objects.all()
-- select(Product)
-- python ORM(sqlalchemy, djangorm)


-- data types, DDL + DML + DQL, join


-- PRIMARY KEY = NOT NULL + UNIQUE

-- 1 bit 1
-- 2 byte - 16 bit - 2^16 SMALLINT -32768 to +32767
-- 4 byte - 32 bit - 2^32 INT
-- 8 byte - 64 bit - 2^64 BIGINT -9,223,372,036,854,775,808

select gen_random_uuid();
CREATE TABLE different
(
    id                SERIAL PRIMARY KEY,
    number1           SMALLINT,
    number2           INTEGER DEFAULT 2, -- 2^32
    number3           BIGINT,

    number_real       REAL,
    number_real_1     DECIMAL,
    number_real_2     DOUBLE PRECISION,
    number_real_3     NUMERIC,

    uuid              UUID    DEFAULT gen_random_uuid(),
    has_object        BOOLEAN,

    word2             VARCHAR(25),
    word3             CHARACTER VARYING(25),

    word4             CHAR(25),
    word5             CHARACTER(25),

    text1             TEXT,
    text2             VARCHAR,

    phones            VARCHAR(25)[],
    properties_binary JSONB,
    properties        JSON,
    time              TIMESTAMP,
    time_with_tzzone  TIMESTAMPTZ,
    birth_date        DATE,
    registered_at     TIME,
    range             INTERVAL
);

-- , time, time_with_tzzone, birth_date, registered_at, range

INSERT INTO different(time, time_with_tzzone, birth_date, registered_at, range)
VALUES (now()::timestamp, now(), '2000-02-15', '18:00', '2 days ago');

-- INSERT INTO different(has_object, word2, word3, word4, word5, text1, text2, phones, properties_binary, properties)
-- VALUES ('y', '12435678', '123', '1', '','hello world', '1625376215', ARRAY['123', '123432'], '{"key":  "VALUE"}', '{"key":  "VALUE"}' );

-- CHECK
-- year 1990-2024

SELECT CURRENT_DATE - INTERVAL '5 day';
SELECT NOW();
SELECT NOW() + interval '2 months 20 minutes';
SELECT NOW() - interval '2 months 20 minutes';

-- SQL(sqlite(AUTOINCREMENT), postgresql(SERIAL), mysql(AUTOINCREMENT), oracle)
-- SERIAL,
-- CAST
SELECT CURRENT_TIME(1);

SELECT CURRENT_DATE;
SELECT CURRENT_TIME;
SELECT EXTRACT(YEAR FROM CURRENT_DATE);
SELECT EXTRACT(MONTH FROM CURRENT_DATE);
SELECT EXTRACT(DAY FROM CURRENT_DATE)::VARCHAR || ' -12321';
SELECT (EXTRACT(DAY FROM CURRENT_DATE)::VARCHAR)::INTEGER + 2;

SELECT CAST(EXTRACT(YEAR FROM NOW()) AS VARCHAR) + 2;

SET TIME ZONE 'UTC';
SHOW TIMEZONE;
SELECT NOW();
SELECT CURRENT_TIMESTAMP;
SELECT TIMEOFDAY();
-- UTC-5

-- datetime, date, time
-- 2016-06-22 19:10:25,  2016-06-22, 19:10:25
-- TIMESTAMP, DATE, TIME
-- TIMESTAMPTZ, DATE, TIME

SELECT CURRENT_TIMESTAMP;
SELECT EXTRACT(YEAR FROM AGE(birth_date)) from different WHERE birth_date IS NOT NULL;


-- CURRENT_TIMESTAMP, NOW(), TIMEOFDAY(), AGE(), EXTRACT()


-- advanced

-- data structure, stack array
-- id, slug, uuid
-- honor-x7b

-- https://www.olx.uz/d/obyavlenie/v-nalichii-song-plus-dm-i-champion-edition-150km-flagship-dts-rohat-ID3EzNH.html?reason=hp%7Cpromoted
-- https://olcha.uz/ru/product/view/6235
-- https://olcha.uz/ru/product/view/honor-x7b
-- https://app.pdp.uz/academic/academic/time-table/17
-- https://app.pdp.uz/academic/academic/time-table/9afb3994-3a29-450f-8349-a5b827d6599b/3e6ea6b7-e1f7-4d5c-a2f6-c95b67e636be



-- DDL - create, alter, drop, truncate - (database, table, index, view, constraint, scheme, role)
-- DML - insert, update, delete
-- DQL - select

-- DDL

CREATE TABLE IF NOT EXISTS lesson_2(
    id SERIAL PRIMARY KEY ,
    name VARCHAR(55) NOT NULL
);


ALTER TABLE lesson_2 rename to p22_user;

ALTER TABLE p22_user RENAME COLUMN name to first_name;
UPDATE p22_user SET nomi='Botirov' WHERE id=3;
ALTER TABLE p22_user ADD COLUMN last_name VARCHAR(55);
ALTER TABLE p22_user ADD COLUMN full_name VARCHAR(155);
ALTER TABLE p22_user DROP COLUMN description;
ALTER TABLE lesson_2 ADD COLUMN balance INTEGER DEFAULT 0;
UPDATE p22_user SET  full_name = first_name || ' ' || nomi WHERE TRUE;

SELECT random(); -- 0 1
SELECT * FROM lesson_2;
SELECT cast(random() * 90 + 10 as INTEGER);
UPDATE lesson_2 SET balance = cast(random() * 90 + 10 as INTEGER) WHERE True;


UPDATE lesson_2 SET balance = NULL where id =2;
TRUNCATE lesson_2 RESTART IDENTITY ;
TRUNCATE lesson_2 ;
DELETE FROM lesson_2 WHERE true;

INSERT INTO lesson_2 VALUES (1, 'data');
INSERT INTO lesson_2(name) VALUES ('lesson 3');
DROP TABLE IF EXISTS lesson_2;



-- TO CSV
COPY p22_user(id, first_name, last_name)
TO '/tmp/p22_user.csv'
DELIMITER ','
CSV HEADER;


-- FROM CSV
COPY p22_user(id, first_name, last_name)
FROM '/tmp/botir.csv'
DELIMITER ','
CSV HEADER;


-- product
-- name
-- price
-- description
-- created_at

