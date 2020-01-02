/***************** Partie 2 ************/
/* Question 1 : */

-- 1 : De créer l’utilisateur SCOTT et de lui donner les rôles CONNECT et RESOURCE
CREATE USER SCOTT IDENTIFIED BY SCOTT;
GRANT CONNECT,RESOURCE TO SCOTT;
-- 2 : De donner à SCOTT les privilèges nécessaires pour créer un profil et un utilisateur
GRANT CREATE USER, CREATE PROFILE TO SCOTT;

-- 3 : De créer le nouveau profil (profil_10j) par SCOTT.
connect SCOTT/SCOTT;
CREATE PROFILE app_user LIMIT
    PASSWORD_LIFE_TIME 10
    PASSWORD_GRACE_TIME 5
    CONNECT_TIME DEFAULT
    SESSIONS_PER_USER 20;

-- 4 : De créer un nouvel utilisateur, toujours par SCOTT, en lui assignant ce profil
create user haikel identified by haikel;
alter user haikel profile app_user;

-- 5 : De modifier le profil de telle sorte qu’il n’y ait au maximum, que 5 sessions ouvertes pour cet utilisateur
alter profile app_user limit SESSIONS_PER_USER 5;



/* Question 2 : SCOTT voudrait connaître les privilèges systèmes dont il dispose. */

-- 1 Quelle commande doit-il saisir ?
SELECT * FROM dba_sys_privs WHERE grantee = 'SCOTT';

-- 2 Quels sont les privilèges systèmes dont il dispose ?
SELECT privilege FROM dba_sys_privs WHERE grantee = 'SCOTT';


/* Question 3 : */
/*
SCOTT a décidé de donner quelques privilèges sur ses tables pour ses stagiaires. Il
souhaite regrouper ces privilèges dans un rôle. Ces privilèges sont : La consultation
des tables EMP, DEPT et SALGRADE ; avec la possibilité de modifier les données des
colonnes LOSAL et HISAL de la table SALGRADE et LOC de la table DEPT.    
    ? Quels sont les commandes saisies par SCOTT pour qu’il crée ce rôle et donne
    les privilèges qu’il regroupe à son nouvel utilisateur.
*/

-- 1 : non , il faut que l'admin donne les priviléges de create role
        -- connect as admin et give privelege de create role to SCOTT or alter 
        grant create role to scott with ADMIN OPTION;
        connect system/system
        grant create role to SCOTT;
-- 2 : 
create table emp(town varchar2(50));
create table DEPT(ll VARCHAR2(50), LOC varchar2(50));
create table SALGRADE(LOSAL varchar2(50) , HISAL varchar2(50));


create role mestag IDENTIFIED by mestag;
grant insert on SCOTT.dept to mestag;
grant insert on SCOTT.salgrade to mestag;
grant insert on SCOTT.emp to mestag;
grant update (LOSAL, HISAL) on SCOTT.salgrade to mestag;
grant update (LOC) on SCOTT.DEPT to mestag;

grant mestag to haikel;

select * from user_tab_privs;























