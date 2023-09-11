
/*1. Написать скрипт, добавляющий в созданную БД vk 2-3 новые таблицы 
(с перечнем полей, указанием индексов и внешних ключей) (CREATE TABLE)
  2. Заполнить 2 таблицы БД vk данными (по 10 записей в каждой таблице) (INSERT)*/

/*Справочник городов*/
DROP TABLE IF EXISTS cities;

CREATE TABLE cities (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  name varchar(50) DEFAULT NULL,
  PRIMARY KEY (id)
) COMMENT='города';

INSERT INTO cities (name) VALUES
	 ('South Jeffereyshire'),
	 ('Adriannaport'),
	 ('Spencerfort'),
	 ('North Nettieton'),
	 ('South Woodrowmouth'),
	 ('Padbergtown'),
	 ('Port Rupertville'),
	 ('Howeside'),
	 ('Loweborough'),
	 ('New Nellaside');

/*------------------------------*/
	
/*Альбомы*/	
DROP TABLE IF EXISTS photo_albums;

CREATE TABLE photo_albums(
	id SERIAL,
    media_id BIGINT UNSIGNED NOT NULL,
    user_id BIGINT UNSIGNED NOT NULL,
    title VARCHAR(255),
    created_at DATETIME DEFAULT NOW(),
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (media_id) REFERENCES media(id)
) COMMENT='фотоальбомы';

/*--------------------------------*/

/*Подписки на пользователей*/
DROP TABLE IF EXISTS user_subscriptions;

CREATE TABLE user_subscriptions(
    user_id BIGINT UNSIGNED NOT NULL,
    user_id_subscription BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    close_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (user_id_subscription) REFERENCES users(id)
) COMMENT='подписки на пользователей';

/*Подписки на сообщества*/
DROP TABLE IF EXISTS community_subscriptions;
CREATE TABLE subscriptions_communities(
    user_id BIGINT UNSIGNED NOT NULL,
    community_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    close_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (communities_id) REFERENCES communities(id)
) COMMENT='подписки на сообщества';


/*Вставка данных в справочник Тип медиа*/
INSERT INTO media_types (name,created_at) VALUES
('photo','2023-01-18 03:54:01'),
('video','2023-01-19 04:24:11'),
('audio','2023-01-20 04:54:01'),
('text','2023-01-19 04:54:01')
;

/*Вставка данных в таблицу Медиа*/
INSERT INTO media (id,media_type_id,user_id,body,filename,`size`,metadata,created_at,updated_at) VALUES 
(1,1,1,'Debitis neque est ratione. Quia quod ab ut sit et neque quam. Illum suscipit voluptas est amet dolores sit perspiciatis cumque. Eos est et veritatis non esse.','nisi.jpg',914587,NULL,'1983-12-22 21:47:23.000','2019-06-19 18:11:58.000')
,(2,2,2,'Nihil quasi doloremque rerum velit non libero. Non veritatis perspiciatis autem. Expedita rerum nihil aliquam.','sint.jpg',86964,NULL,'2011-09-12 11:05:53.000','2019-06-19 18:11:58.000')
,(3,3,3,'Nesciunt aut sint nam dolor facilis ut est. Odit dolores assumenda dolore.','ipsum.jpg',689891921,NULL,'2008-05-10 05:19:10.000','2019-06-19 18:11:58.000')
,(4,4,4,'Aliquid facere dignissimos quidem quo et beatae. Non qui dolore velit. Nemo non asperiores architecto corporis ratione.','velit.jpg',767,NULL,'1981-11-28 00:43:00.000','2019-06-19 18:11:58.000')
,(5,1,5,'Id quos rerum delectus quas porro eos. Qui in accusantium nihil et possimus. Qui doloribus dolores a deserunt illo.','ducimus.jpg',663,NULL,'2005-01-31 02:53:19.000','2019-06-19 18:11:58.000')
,(6,2,6,'Ipsa odit ut sed et. Eos vero aut veritatis doloribus ipsam et at repellendus. Fugiat sequi sint aliquam nostrum voluptate. Omnis quaerat consequatur cum.','mollitia.jpg',66726632,NULL,'1970-10-07 22:45:18.000','2019-06-19 18:11:58.000')
,(7,3,7,'Placeat aut consequatur unde sed qui voluptatum. Harum ut quasi reprehenderit nostrum et. Facilis magnam consectetur ea suscipit accusantium.','enim.jpg',213578,NULL,'2015-06-20 15:21:47.000','2019-06-19 18:11:58.000')
,(8,4,8,'Quod assumenda impedit aut odio consequatur aut quisquam. In officia mollitia nobis. Non accusantium ut tempore.','iure.jpg',0,NULL,'1996-05-24 05:33:17.000','2019-06-19 18:11:58.000')
,(9,1,9,'Nemo eum et placeat non et repellat consequuntur. Rem vitae rerum sed aut numquam voluptatum quia. Magni itaque rerum laboriosam saepe molestias a.','voluptas.jpg',8488,NULL,'1973-03-06 04:36:40.000','2019-06-19 18:11:58.000')
,(10,1,10,'Alias qui dolores tempore est. Molestiae necessitatibus debitis nihil qui. Et molestiae voluptatem doloribus tempore enim veritatis tenetur. Consequatur qui non debitis voluptas et in soluta.','aut.jpg',96,NULL,'2001-09-09 22:19:46.000','2019-06-19 18:11:58.000')
,(11,1,2,'Debitis neque est ratione. Quia quod ab ut sit et neque quam. Illum suscipit voluptas est amet dolores sit perspiciatis cumque. Eos est et veritatis non esse.','toto.jpg',914587,NULL,'1983-12-22 21:47:23.000','2019-06-19 18:11:58.000')
,(12,1,3,'Debitis neque est ratione. Quia quod ab ut sit et neque quam. Illum suscipit voluptas est amet dolores sit perspiciatis cumque. Eos est et veritatis non esse.','popo.jpg',914587,NULL,'1983-12-22 21:47:23.000','2019-06-19 18:11:58.000')
,(13,1,4,'Debitis neque est ratione. Quia quod ab ut sit et neque quam. Illum suscipit voluptas est amet dolores sit perspiciatis cumque. Eos est et veritatis non esse.','nisi.jpg',914587,NULL,'1983-12-22 21:47:23.000','2019-06-19 18:11:58.000')
,(14,1,6,'Debitis neque est ratione. Quia quod ab ut sit et neque quam. Illum suscipit voluptas est amet dolores sit perspiciatis cumque. Eos est et veritatis non esse.','koko.jpg',914587,NULL,'1983-12-22 21:47:23.000','2019-06-19 18:11:58.000')
,(15,1,7,'Debitis neque est ratione. Quia quod ab ut sit et neque quam. Illum suscipit voluptas est amet dolores sit perspiciatis cumque. Eos est et veritatis non esse.','koko.jpg',914587,NULL,'1983-12-22 21:47:23.000','2019-06-19 18:11:58.000')
,(16,1,8,'Debitis neque est ratione. Quia quod ab ut sit et neque quam. Illum suscipit voluptas est amet dolores sit perspiciatis cumque. Eos est et veritatis non esse.','koko5.jpg',914587,NULL,'1983-12-22 21:47:23.000','2019-06-19 18:11:58.000')
;

/*Добавления cities_id в таблицу Профили*/
ALTER  TABLE profiles
ADD COLUMN cities_id BIGINT UNSIGNED NOT NULL;

/*Вставка данных в таблицу Профили*/
INSERT INTO profiles (user_id,gender,birthday,photo_id,created_at,cities_id) VALUES 
('1','f','1976-11-08','1','1970-01-18 03:54:01',1),
('2','f','2011-12-20','11','1994-11-06 23:56:10',5),
('3','m','1994-06-15','12','1975-11-27 02:27:11',8),
('4','f','1979-11-07','13','1994-04-12 04:31:49',7),
('5','f','1976-04-19','5','1976-07-05 02:25:30',10),
('6','f','1983-09-07','14','1981-06-20 15:54:43',2),
('7','m','2014-07-31','15','1997-06-21 07:52:05',3),
('8','f','1975-03-26','16','2008-08-18 18:23:25',9),
('9','f','1982-11-01','9','2014-09-29 01:22:26',2),
('10','m','1977-05-14','10','1980-03-17 18:17:45',1)
;


/*4.* Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных 
(поле is_active = true). При необходимости предварительно добавить такое поле 
в таблицу profiles со значением по умолчанию = false (или 0) (ALTER TABLE + UPDATE)*/

/*Добавим поле is_active*/ 
ALTER TABLE vk.profiles 
ADD COLUMN is_active BIT DEFAULT 1;

/*Сделать несовершеннолетних пользователей неактивными*/
UPDATE profiles
SET is_active = 0
WHERE (birthday + INTERVAL 18 YEAR) > NOW();

/*Выбор неактивных пользователей*/
SELECT *
FROM profiles
WHERE is_active = 0
ORDER BY birthday;

/* 5.* Написать скрипт, удаляющий сообщения «из будущего» (дата позже сегодняшней) (DELETE) */

/*Вставить записи в таблицу Сообщения*/
INSERT INTO messages (from_user_id,to_user_id,body,created_at) VALUES 
('1','1','Hello','2022-01-18 03:54:01'),
('2','10','Hello','2022-11-06 23:56:10'),
('3','2','Hello','2022-11-27 02:27:11'),
('4','3','Hello','2022-04-12 04:31:49'),
('5','5','Hello','2020-07-05 02:25:30'),
('6','4','Hello','2022-06-20 15:54:43'),
('7','5','Hello','2021-06-21 07:52:05'),
('8','6','Hello','2022-08-18 18:23:25'),
('9','9','Hello','2014-09-29 01:22:26'),
('1','10','Hello','2019-03-17 18:17:45')
;

/*Отметим несколько сообщений будующей датой*/
UPDATE messages
SET created_at = NOW() + INTERVAL from_user_id MONTH 
WHERE from_user_id IN (1,6,10);

DELETE FROM messages
WHERE created_at > NOW();
/*Альтернативный вариант с добавление поля*/

/*Добавим поле is_deleted*/ 
ALTER TABLE messages 
ADD COLUMN is_deleted BIT DEFAULT 0;

/*Пометим, как удаленные сообщения "из будущего"*/
UPDATE messages
SET is_deleted = 1
WHERE created_at > NOW();

/*Проверям результат*/
SELECT *
FROM messages
WHERE is_deleted = 1;