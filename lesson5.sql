-- 1.task
-- payment
-- 2020 1500
-- 2021 1765
select extract(year from payment_date) yil, count(amount)
from payment
group by yil
order by yil;

-- 2.task
-- 2020, 02 oyda, 56 ta tolov
-- 2020, 06 oyda, 81 ta tolov
select extract(year from payment_date) yil, extract(month from payment_date) oy, count(amount)
from payment
group by yil, oy
order by yil, oy;

-- 3.task(payment)
-- eng kop qaysi oyda tolov bolgan va jami nechta
select to_char(payment_date, 'Month') oy, count(amount) count_payment
from payment
group by oy
order by count_payment desc
limit 1;

select oy, count_payment
from (select to_char(payment_date, 'Month') oy, count(amount) count_payment from payment group by oy) as tb1;
-- ?


-- 4.task(actor, payment)
-- film(release_year) update [2020-now]
-- eng kop tolov bolgan top 2ta yildagi
-- (osha yildagi eng kop actorlar rol oynagan kinoni nomi, actor soni)

update film
set release_year= random() * (extract(year from current_date) - 2020) + 2020
where True;
select extract(year from payment_date) year_
from payment
group by year_
order by sum(amount) desc
limit 2;


select f.title, f.release_year, count(fa.actor_id) over (partition by release_year)
from film f
         join film_actor fa using (film_id)
where f.release_year in
      (select extract(year from payment_date) year_
       from payment
       group by year_
       order by sum(amount) desc
       limit 2)
group by f.title, f.release_year;

-- ?


-- 5.task(actor)
-- eng uzun ismli actorlarni top 10tasi qaysi kinoda oynagan
select actor.actor_id
from actor
order by length(first_name || ' ' || actor.last_name) desc
limit 10;



select a.first_name || ' ' || a.last_name, array_agg(f.title), count(f.title)
from actor a
         join film_actor fa using (actor_id)
         join film f using (film_id)
where a.actor_id in (select actor.actor_id
                     from actor
                     order by length(first_name || ' ' || actor.last_name) desc
                     limit 10)
group by a.first_name || ' ' || a.last_name;

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

select t1.customer_fullname, t2.actor_fullname, counter
from (select c.first_name || ' ' || c.last_name customer_fullname, count(payment_id) counter
      from payment p
               join customer c using (customer_id)
      group by customer_fullname) as t1
         join
     (select a.first_name || ' ' || a.last_name actor_fullname, count(film_id) counter
      from actor a
               join film_actor fa using (actor_id)
      group by actor_fullname) t2 using (counter);

-- when,case, then, array, jsonb


select (array ['123', 'hello'])[1];
select to_char(current_date, 'Month');

select staff_id, amount
from payment;


-- 0. task
-- staff, summa
-- 1,    150
-- 2,    250
-- null, 400

-- 1)
select staff_id, sum(amount)
from payment
group by staff_id


union
select null, sum(amount)
from payment;

-- 2)

select staff_id, sum(amount)
from payment
group by
    grouping sets ( (staff_id), ()
    );



-- 1.task

-- 1)
select customer_id, null, sum(amount)
from payment
group by customer_id
union

select customer_id, staff_id, sum(amount)
from payment
group by customer_id, staff_id
union

select null, staff_id, sum(amount)
from payment
group by staff_id

union
select null, null, sum(amount)
from payment;

-- 2)

select customer_id, staff_id, sum(amount)
from payment
group by
    grouping sets (
        (customer_id),
        (customer_id, staff_id),
        (staff_id),
        ()
    );


-- 1. group by
-- 2. grouping set

--     subprice
-- resources
-- https://www.postgresql.org/docs/7.4/functions-formatting.html
-- array_agg, string_agg
-- {
--
-- }
--
--
-- select c.name, string_agg(fc.film_id::varchar, ','), string_agg(f.title, ', ')
-- from category c
--          join film_category fc using (category_id)
--          join film f using (film_id)
-- group by c.name;
--
--

select generate_series from generate_series(1, 10);
-- md5, sha256


select md5(generate_series::text) from generate_series(1, 10);

-- admin, moderator, teacher, assistant, student
create table if not exists users
(
    id   SERIAL primary key,
    type varchar(25) --
);