USE DB;
set SQL_SAFE_UPDATES = 0;
update users set passwords = hex(aes_encrypt(passwords, 'secret_key!'));
select cast(aes_decrypt(unhex(passwords), 'secret_key!') as char) from users;