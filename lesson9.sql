-- homework
-- Section 10. Transactions
-- https://www.postgresqltutorial.com/postgresql-views/
-- https://www.postgresqltutorial.com/postgresql-indexes/
-- https://www.postgresql.org/docs/current/app-psql.html#APP-PSQL-PATTERNS

-- 1. [table yaratish kk] users(id, first_name, last_name, telegram_id, created_at)
-- tableda telegram id lari bir hil bo'lganlarni eng birinchisi qoldirib qolganiga null yozish kk

-- 2. har bir actorning ismi uzunligining yarmiga teng bolgan ismli actorlar soni bilan chiqarish
-- Botirjon, 8ta(uzunligi 4ta teng bolgan ismlar soni)


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


select count(*)
from staff;


select *
from staff
order by random()
limit 1;

create index staff_username_idx on staff (username);
create index staff_username_idx on staff using btree (username);
create index staff_username_idx on staff using hash (username);
-- collision
-- collision

-- hashtable -> 1
-- btree - > logn


-- hash('jhfgsdjhfgsd') ->
-- hash('gb24g762') ->


select *
from staff
where username = 'cc8a18576e'; -- 6mln 3000ms no-index
select *
from staff
where username = 'cc8a18576e';
-- 6mln 50 index

-- a9cb5551202d55acdb5b8622db6f02f35cc3b5c16a15e6b2597449b101d78825 2^256


-- DTL
-- generic series + index + transaction, Section 12. Managing Tables


ALTER TABLE users
    drop column balance;
ALTER TABLE users
    add column balance integer default 0 not null check (balance >= 0);


BEGIN;
update users
set balance=balance - 70
where id = 1;
update users
set balance=balance + 70
where id = 2;
update users
set balance=balance - 70
where id = 2;
update users
set balance=balance + 70
where id = 3;

COMMIT;


select *
from users;

insert into users(first_name, balance)
values ('user1', 100),
       ('user2', 200);

insert into users(first_name, balance)
values ('user2', 200);


create table t_table
(
    name    varchar(255) not null,
    balance numeric      not null
);

insert into t_table(name, balance)
select 'botir', 100
from generate_series(1, 100);


update t_table set balance = random() * 100::integer where True;
alter table t_table add column id serial primary key;

-- t_table
-- name, balance
-- botir, 100

/*
100 ta qoshilgandan keyin


balance har hil son bilan ozgartirish kk
id qoshish kk

*/


-- t_product,(name, price) t_productimage (image)
-- 3ta product, har hil ntadan image

-- 1.task
-- productni imagelar soni juft bolganlarni narxini 2barobarga oshiring

-- 2.task
-- eng qimmat 3ta productni narxidan 1 ayiring

-- 3.task
-- product narxining birinchi raqami juft bolsa imagelarini  bo'sh '' string bilan almashtiring

-- 4.task
-- productni narxini productimagelar soniga oshiramiz


-- pl/pgpsql
