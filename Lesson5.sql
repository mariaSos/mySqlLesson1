/*1. Создайте представление с произвольным SELECT-запросом из прошлых уроков [CREATE VIEW]*/
CREATE OR REPLACE VIEW v_users_communities_count as
SELECT id,
	   COUNT(user_id) AS cnt,
	   communities.name
FROM users_communities 
RIGHT JOIN communities ON users_communities.community_id = communities.id
GROUP BY communities.id;

/*2. Выведите данные, используя написанное представление [SELECT]*/
SELECT id, cnt, name
FROM vk.v_users_communities_count;

/*3. Удалите представление [DROP VIEW]*/
DROP VIEW IF EXISTS v_users_communities_count;

/*4.* Сколько новостей (записей в таблице media) у каждого пользователя? Вывести поля: news_count (количество новостей),
   user_id (номер пользователя), user_email (email пользователя). Попробовать решить с помощью CTE или с помощью обычного JOIN.*/
WITH cte AS
(
SELECT COUNT(*) AS news_count,
	   user_id
FROM media m
GROUP BY user_id
)

SELECT user_id,
	   u.email,
	   news_count
FROM users u
JOIN cte ON u.id = cte.user_id
ORDER BY news_count DESC;

#--------------------------------------------------
SELECT user_id,
	   u.email,
	   COUNT(*) AS news_count
FROM users u
JOIN media m ON u.id = m.user_id
GROUP BY user_id, u.email
ORDER BY news_count DESC;
