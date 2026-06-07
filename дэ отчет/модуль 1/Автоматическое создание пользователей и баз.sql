DELIMITER $$
CREATE DEFINER=`root`@`%` PROCEDURE `create_ten_users`()
BEGIN
declare i int default 1;
declare database_name varchar(20);
declare user_name varchar(20);
declare password_user varchar(20);

while i < 11 do
set database_name = concat('DB', i);
set user_name = concat('user', i);
set password_user = substring(replace(uuid(), '-', ''), 1, 5);

set @sql = concat('create database if not exists `', database_name, '`');
prepare s from @sql; execute s; deallocate prepare s;

set @sql = concat('create user if not exists ''', user_name, '''@''%'' identified by ''', password_user, '''');
prepare s from @sql; execute s; deallocate prepare s;

set @sql = concat('grant all privileges on `', database_name, '`.* to ''', user_name, '''@''%'' with grant option');
prepare s from @sql; execute s; deallocate prepare s;

insert into Users(username, passwords) values (user_name, password_user);

set i = i + 1;
end while;
END$$
DELIMITER ;
