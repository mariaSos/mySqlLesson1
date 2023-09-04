--1.Создайте таблицу с мобильными телефонами, используя графический интерфейс.
--Необходимые поля таблицы: product_name (название товара), manufacturer (производитель), 
--product_count (количество), price (цена). Заполните БД произвольными данными.
create database mylessons;

create table PRODUCT
( PRODUCT_NAME        VARCHAR(50),
  MANUFACTURER        VARCHAR(50),
  PRODUCT_COUNT       int,
  PRICE Decimal (8,2)
);
---------------------------------------------------------------------
insert into product (PRODUCT_NAME,MANUFACTURER,PRODUCT_COUNT,PRICE ) values ('Meizu M6','Meizu',5,25000.50);
insert into product (PRODUCT_NAME,MANUFACTURER,PRODUCT_COUNT,PRICE ) values ('Meizu M8','Meizu',9,12000);
insert into product (PRODUCT_NAME,MANUFACTURER,PRODUCT_COUNT,PRICE ) values ('Samsung Galaxy A52','Samsung',15,21000.50);
insert into product (PRODUCT_NAME,MANUFACTURER,PRODUCT_COUNT,PRICE ) values ('Samsung Galaxy A8s','Samsung',18,23000);
insert into product (PRODUCT_NAME,MANUFACTURER,PRODUCT_COUNT,PRICE ) values ('iPhone 8','Apple',10,50000);
insert into product (PRODUCT_NAME,MANUFACTURER,PRODUCT_COUNT,PRICE ) values ('iPhone 11','Apple',17,120000);
insert into product (PRODUCT_NAME,MANUFACTURER,PRODUCT_COUNT,PRICE ) values ('Philips','Apple',17,120000);
------------------------------------------------------------------------
--2.Напишите SELECT-запрос, который выводит название товара, 
--производителя и цену для товаров, количество которых превышает 2
select product_name, manufacturer, price  from product where product_count > 2;
--3.Выведите SELECT-запросом весь ассортимент товаров марки “Samsung”
select * from product where manufacturer =  'Samsung';

--4. С помощью SELECT-запроса с оператором LIKE / REGEXP найти:
--4.1 Товары, в которых есть упоминание "Iphone"
select * from product where product_name  like  'iPhone%';
select * from product where product_name  regexp  'iPhone';
--4.2 Товары, в которых есть упоминание "Samsung"
select * from product where product_name  regexp  'Samsung';
--4.3 Товары, в названии которых есть ЦИФРЫ
select * from product where product_name  regexp  '[0-9]';
--4.4 Товары, в названии которых есть ЦИФРА "8"
select * from product where product_name  regexp  '8';