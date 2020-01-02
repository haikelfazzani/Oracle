/* SYSTEM */
desc dba_tablespaces;
select tablespace_name from dba_tablespaces;

desc dba_ts_quotas;

/* Question 4 */
select tablespace_name, BYTES from dba_ts_quotas where username='HR' and tablespace_name='USERS';

/* Question 5 */
desc dba_data_files;
SELECT file_name FROM dba_data_files where tablespace_name='USERS';

/* Question 6 */
desc dba_segments;
select segment_name,SEGMENT_TYPE from dba_segments where tablespace_name='USERS';

/* Question 7 */
desc user_users;
SELECT DEFAULT_TABLESPACE, TEMPORARY_TABLESPACE from user_users;

desc database_properties;
select PROPERTY_NAME, PROPERTY_VALUE from database_properties;

select PROPERTY_VALUE from database_properties where PROPERTY_NAME 
IN ('DEFAULT_TEMP_TABLESPACE','DEFAULT_PERMANENT_TABLESPACE');

/* Exercice 2 */
/* Question 1 */

CREATE TABLESPACE TBL01
DATAFILE 
'C:\oraclexe\app\oracle\oradata\XE\fd01tbl01.dbf' size 10M,
'C:\oraclexe\app\oracle\oradata\XE\fd02tbl01.dbf' size 10M;

/* Question 2 */
CREATE TABLESPACE TBL02
DATAFILE 
'C:\oraclexe\app\oracle\oradata\XE\fd01tbl02.dbf' size 10M,
'C:\oraclexe\app\oracle\oradata\XE\tablespaces\fd02tbl02.dbf' size 10M,
'C:\oraclexe\app\oracle\oradata\XE\tablespaces\fd03bl02.dbf' size 5M;

SELECT file_name FROM dba_data_files where tablespace_name='USERS';

/**/
ALTER DATABASE TBL02
DATAFILE
'C:\Users\haike\Desktop\oracle_admin\FD03BL02.DBF' RESIZE 10M;

select file_name from dba_data_files where tablespace_name='TBL02';

/* Question 7 */
ALTER TABLESPACE TBL01
ADD DATAFILE
'C:\Users\haike\Desktop\oracle_admin\FD04BL02.DBF' SIZE 2M AUTOEXTEND ON  NEXT 1M MAXSIZE 4M;


/* Question 8 */
ALTER TABLESPACE TBL02 READ ONLY;
ALTER TABLESPACE TBL02 READ WRITE;

/* Question 9 */

SELECT tablespace_name, count(*) from dba_data_files group by tablespace_name;


/* HR */
desc user_tablespaces;
select * from user_tablespaces;
