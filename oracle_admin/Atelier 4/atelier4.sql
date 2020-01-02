-- ********* Partie 1 *********:
-- Question 1 :
CREATE USER TINTIN IDENTIFIED BY TITI;

-- Question 2 :
connect TINTIN/TITI;

-- Question 3 :
GRANT connect to TINTIN;

-- Question 4 :
GRANT CREATE SESSION TO TINTIN; -- connecter autant TINTIN

-- Question 5 :
CREATE TABLESPACE TBSP DATAFILE 'C:\oracle\DATA01.dbf' size 5m;
CREATE TEMPORARY TABLESPACE TBSTEMP TEMPFILE 'C:\oracle\TEMP01.dbf' size 20m; 
create user tweety IDENTIFIED by PSTWEETY
default TABLESPACE TBSP 
QUOTA 5m on TBSP
TEMPORARY TABLESPACE TBSTEMP;

select * from dba_users where username='TWEETY';
select * from dba_ts_quotas;

-- Question 6 :
select * from dba_users where username='TINTIN';

-- Question 7 :
create profile CLERK LIMIT connect_time 500 SESSIONS_PER_USER 2;
alter USER TWEETY profile CLERK;
CREATE USER SIMPSON IDENTIFIED by SIMPSON;

-- Question 8 :
SELECT * FROM DBA_PROFILES;
SELECT USERNAME, PROFILE FROM DBA_USERS where username='TWEETY'; 
SELECT USERNAME, PROFILE FROM DBA_USERS where username='SIMPSON'; 

-- Question 9 : Afficher les ressources du profil CLERK, en utilisaant la vue dba_profile.
SELECT resource_name, resource_type FROM dba_profiles where profile='CLERK';

-- Question 10 :
ALTER USER TINTIN IDENTIFIED BY TOTO;

-- Question 11 :
SELECT * FROM dba_users where username='TINTIN' ;
ALTER USER TINTIN DEFAULT TABLESPACE users;

-- Question 12 : Afficher pour chaque utilisateur le nom du privilège système qu’il a reçu
desc dba_sys_privs;
SELECT * FROM dba_sys_privs;

-- Question 13 :
SELECT * FROM SYS.dba_sys_privs where grantee='TINTIN';
-- Question 14 : Afficher la liste des codes des différents privilèges
select * from system_privilege_map;

-- Question 15 :Lister tous les privileges objets (code et nom des privileges objets)
select * from SYS.user_tab_privs;

-- Question 16 : Afficher pour chaque utilisateur le nom du privilèges objet reçus
select * from SYS.dba_tab_privs;

-- Question 17 : Afficher les différents rôles de la base
select granted_role from dba_role_privs GROUP by granted_role;

-- Question 18 : Afficher pour chaque utilisateur le nom du rôle reçu
SELECT * FROM USER_SYS_PRIVS;
select * from USER_ROLE_PRIVS ;

-- Question 19 : Afficher les rôles actifs 
select * from session_roles;

-- Question 20 : Afficher la liste des utilisateurs , ainsi que leur tablespaces par défaut 
SELECT username,default_tablespace FROM dba_users;

