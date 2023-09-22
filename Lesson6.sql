USE vk;

/*1.  Написать функцию, которая удаляет всю информацию об указанном пользователе из БД vk.
Пользователь задается по id. Удалить нужно все сообщения, лайки, медиа записи, профиль и запись из таблицы users.
Функция должна возвращать номер пользователя.*/

DROP FUNCTION IF EXISTS vk.f_user_info_delete;

DELIMITER $$
CREATE function vk.f_user_info_delete(p_user_id BIGINT UNSIGNED)
RETURNS INT READS SQL DATA
BEGIN
  -- объявим переменные
  DECLARE res_user_id INT;
   
	-- Удаление профиля пользователя и обновление профилей пользователей, если он использует медиа удаляемого пользователя
	DELETE FROM profiles  WHERE user_id = p_user_id;
	
	UPDATE profiles set photo_id = null
	WHERE user_id <> p_user_id 
	AND photo_id IN (SELECT id FROM media WHERE user_id = p_user_id);
  
 	-- Удаление лайков
 	DELETE FROM likes WHERE user_id = p_user_id;
	
 	DELETE FROM likes
 	WHERE media_id IN (SELECT id FROM media WHERE user_id = p_user_id);
	-- Удаление медиа
 	DELETE FROM media WHERE user_id = p_user_id;
 	-- Удаление сообщений
  	DELETE FROM messages WHERE from_user_id = p_user_id OR to_user_id = p_user_id;
 	-- Удаление друзей
 	DELETE FROM friend_requests  WHERE initiator_user_id = p_user_id OR target_user_id = p_user_id;
 	-- Удаление сообществ 
	DELETE FROM users_communities WHERE user_id = p_user_id;
	-- Удаление пользователей
	DELETE FROM users WHERE id = p_user_id;
	
	SET res_user_id = p_user_id;
 RETURN res_user_id;
END

$$
DELIMITER ;

/*2. Предыдущую задачу решить с помощью процедуры 
 * и обернуть используемые команды в транзакцию внутри процедуры.*/

DROP procedure IF EXISTS vk.p_user_info_delete;

DELIMITER $$

CREATE procedure vk.p_user_info_delete(p_user_id BIGINT UNSIGNED, OUT tran_result varchar(200))
BEGIN
  -- объявим переменные
  DECLARE _rollback BOOL DEFAULT 0;
  DECLARE code varchar(100);
  DECLARE error_string varchar(100);
  DECLARE CONTINUE HANDLER FOR sqlexception
  
   BEGIN
    	SET _rollback = 1;
	GET stacked DIAGNOSTICS CONDITION 1
          code = RETURNED_SQLSTATE, error_string = MESSAGE_TEXT;
    	SET tran_result := CONCAT('Error occured. Code: ', code, '. Text: ', error_string);
    END;
 -- Открываем транзакцию
   START TRANSACTION;
  -- Удаление профиля пользователя и обновление профилей пользователей, если он использует медиа удаляемого пользователя
	DELETE FROM profiles  WHERE user_id = p_user_id;
	
	UPDATE profiles set photo_id = null
	WHERE user_id <> p_user_id
	AND photo_id IN (SELECT id FROM media WHERE user_id = p_user_id);
  
 	-- Удаление лайков
 	DELETE FROM likes WHERE user_id = p_user_id;
	
 	DELETE FROM likes
 	WHERE media_id IN (SELECT id FROM media WHERE user_id = p_user_id);
	-- Удаление медиа
 	DELETE FROM media WHERE user_id = p_user_id;
	-- Удаление сообщений
  	DELETE FROM messages WHERE from_user_id = p_user_id OR to_user_id = p_user_id;
 	-- Удаление друзей
 	DELETE FROM friend_requests  WHERE initiator_user_id = p_user_id OR target_user_id = p_user_id;
 	-- Удаление сообществ 
	DELETE FROM users_communities WHERE user_id = p_user_id;
	-- Удаление пользователей
	DELETE FROM users WHERE id = p_user_id;

	-- Если есть ошибки, то делаем откат изменений
	IF _rollback THEN
	   ROLLBACK;
	ELSE
		SET tran_result := 'ok';
	    COMMIT;
	 END IF;
END

$$
DELIMITER ;


#############################################
-- Вызов процедуры 
CALL p_user_info_delete(2,@tran_result);

-- смотрим результат
SELECT @tran_result;


-- Вызов функции
SELECT vk.f_user_info_delete(3);
##############################################
/*3*. Написать триггер, который проверяет новое появляющееся сообщество.
 Длина названия сообщества (поле name) должна быть не менее 5 символов. 
 Если требование не выполнено, то выбрасывать исключение с пояснением.*/

-- Триггер для проверки ввода наименования сообщества
DROP TRIGGER IF EXISTS TR_COMMUNITIES;

DELIMITER $$

CREATE TRIGGER TR_COMMUNITIES
BEFORE INSERT
ON communities FOR EACH ROW
BEGIN
    IF length (new.name) > 5 THEN
        SIGNAL SQLSTATE '45000' 
		SET MESSAGE_TEXT = 'Наименование сообщества не должно быть больше 5 символов!';
    END IF;
END$$

DELIMITER ;
###############################################
-- Тестирование триггера--
INSERT INTO communities (name)
VALUES('One more');

INSERT INTO communities (name)
VALUES('Super');
################################################