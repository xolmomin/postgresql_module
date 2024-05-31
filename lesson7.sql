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

Create table If Not Exists Products
(
    product_id int,
    store1     int,
    store2     int,
    store3     int
);
insert into Products (product_id, store1, store2, store3)
values ('0', '95', '100', '105');
insert into Products (product_id, store1, store2, store3)
values ('1', '70', null, '80');



select product_id, 'store1' as store, store1 as price
from Products
where store1 is not null
union
select product_id, 'store2' as store, store2 as price
from Products
where store2 is not null
union
select product_id, 'store3' as store, store3 as price
from Products
where store3 is not null;


create table custom_product
(
    product_id integer,
    store      varchar(25),
    price      integer
);


-- v1
select distinct product_id,
                (select price
                 from custom_product
                 where store = 'store1'
                   and custom_product.product_id = c.product_id) as store1,
                (select price
                 from custom_product
                 where store = 'store2'
                   and custom_product.product_id = c.product_id) as store2,
                (select price
                 from custom_product
                 where store = 'store3'
                   and custom_product.product_id = c.product_id) as store3
from custom_product c;


-- v2
select a.product_id, a.price store1, b.price store2, c.price store3
from (select price, product_id
      from custom_product
      where store = 'store1') a
         left join
     (select price, product_id
      from custom_product
      where store = 'store2') b on b.product_id = a.product_id
         left join
     (select price, product_id
      from custom_product
      where store = 'store3') c on c.product_id = a.product_id;



select (array_agg(address_id))[cast(random() * ARRAY_LENGTH(array_agg(address_id), 1) + 1 as integer)]
from address;

-- staff


insert into staff (first_name, last_name, address_id, email, store_id, active, username, password)
select md5(generate_series::text)           first_name,
       md5(generate_series::text)           last_name,
       coalesce((select array_agg(address_id) from address)[generate_series %
                                                            array_length((select array_agg(address_id) from address), 1)],
                (select max(address_id) from address))
                                            address_id,
       md5(generate_series::text)           email,
       generate_series % (2 ^ 15)::integer  store_id,
       (generate_series & 1) :: boolean     active,
       left(md5(generate_series::text), 10) username,
       md5(generate_series::text)           password
from generate_series(1, 5000000);


select 2 * 2 * 2;
select 2 ^ 15;

select *
from staff
where username='b6966cde1f';
-- index + full text search
