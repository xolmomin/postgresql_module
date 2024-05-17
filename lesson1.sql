-- category, product


CREATE TABLE IF NOT EXISTS category
(
    id   SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS product
(
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(55) NOT NULL,
    price       DECIMAL     NOT NULL,
    description TEXT
);


INSERT INTO product(name, price, description)
VALUES ('Olma', 25000, 'Zor tovar');
INSERT INTO product(name, price)
VALUES ('Nok', 20000);

INSERT INTO product(name, price)
VALUES ('Banan', 25000),
       ('Gilos', 20000),
       ('Uzum', 15000);


select name || ' (' || price || ')' as mahsulot
from product;
select name || ' (' || price || ')' mahsulot
from product;

-- select name, price from product order by price desc, name desc , id;

-- select * from product as pro;
-- select pro.* from product pro;
-- select pro.name, pro.price from product_product_product pro;

select *
from product
where name like 'Olma';

select *
from product
where name ilike '%o%'
    and length(name) >= 4
    and description is not null
   or name ilike '%nok%'
order by price;


-- count, sum, avg,
select count() from product;

select * from product;
-- select id, name, price from product where id in (1, 3, 5, 7, 9);


-- select * from product where name ilike;

-- select distinct price from product;
-- product(id,name,description,category_id,price) [created_at]

-- docker image ls
-- docker rm -f container_id
-- docker rmi image_id

-- systemctl status postgresql
-- docker exec -i postgres_container pg_restore -U postgres -v -d dvdrental < dvdrental.tar

-- pg_restore -U postgres -d dvdrental dvdrental.tar
-- INT -> SERIAL
-- NOT NULL + UNIQUE = PRIMARY KEY
-- DROP TABLE IF EXISTS category;

-- None, NULL, nan, nil


-- HOMEWORK
-- 0. https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-data-types/
-- 1. psql commands
-- 2. Section 1. Querying Data
-- 3. Section 2. Filtering Data
-- 4. insert, select, update, delete
--



select * from product order by id  desc ;
update product set name='Shaftoli', description =' zor tovar' where id=1;
delete from product where id=1;

--     docker cp
--     docker exec -it name sh
--     su postgres
--     psql

-- CRUD - Create(insert), Read(select), Update(update), Delete(delete)


-- docker rm -f postgres_container
-- docker run --name postgres_container -e POSTGRES_PASSWORD=1 -p 5432:5432 -d postgres:alpine












select count(distinct customer_id) from payment;
-- avg, min, max, sum, count

select category_id, count(film_id) from film_category group by category_id;
select category_id, film_id from film_category;


select *
from actor
limit 5 offset 10;

select *
from actor
limit 10;
select payment_id, customer_id, amount
from payment
where amount between 5 and 8;
-- where amount > 5 and amount < 8;

--
-- sql(postgresql, sqlite, mysql, oracle)