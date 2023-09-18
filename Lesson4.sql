/*1. Подсчитать количество групп (сообществ), в которые вступил каждый пользователь.*/
SELECT
	u.id
	,CONCAT(u.firstname,' ',u.lastname) AS username
	,COUNT(c.community_id) AS count_likes
FROM users u
LEFT JOIN users_communities c ON
	u.id = c.user_id
GROUP BY u.id
ORDER BY 3,2;

/*2. Подсчитать количество пользователей в каждом сообществе.*/
SELECT
	c.name,
	COUNT(uc.user_id) AS count_likes
FROM communities c
LEFT JOIN users_communities uc ON
	uc.community_id = c.id
GROUP BY c.name
ORDER BY c.name;

/*3. Пусть задан некоторый пользователь. 
Из всех пользователей соц. сети найдите человека, который больше всех общался с выбранным пользователем (написал ему сообщений).*/
SELECT
	to_user_id
	,from_user_id
	,CONCAT(u.firstname, ' ', u.lastname) AS fullname
	,COUNT(*) AS count_message
FROM messages m
JOIN users u ON
	u.id = m.from_user_id
where to_user_id = 1
GROUP BY from_user_id
ORDER BY count_message DESC
LIMIT 1;

/*4* Подсчитать общее количество лайков, которые получили пользователи младше 18 лет*/
SELECT COUNT(*) AS count_likes
FROM likes l
JOIN media m ON l.media_id = m.id
JOIN profiles p ON p.user_id = m.user_id
WHERE  YEAR(CURDATE()) - YEAR(birthday) < 18;

/*5* Определить кто больше поставил лайков (всего): мужчины или женщины.*/
SELECT
	gender
	,COUNT(*) count_likes
FROM likes
JOIN profiles
ON likes.user_id = profiles.user_id
GROUP BY gender
ORDER BY count_likes DESC
LIMIT 1;



