desc dba_data_files;

select file_name, tablespace_name , bytes from dba_data_files;


SELECT * FROM V$TABLESPACE;

/* Atelier 2 : Exercice 3 */
-- question 1
CREATE TEMPORARY TABLESPACE MonTemp TEMPFILE 'C:\oracle\temp01' size 5m;

-- question 2
SELECT * FROM database_properties WHERE property_value like '%TEMP%';
-- question 3
ALTER DATABASE DEFAULT TEMPORARY TABLESPACE MONTEMP;


/* Atelier 2 : Exercice 4 */
SELECT * FROM dba_data_files;
-- question 1
drop table etudiant;
CREATE TABLE Etudiant(num_etud VARCHAR2(100), moyenne_etud NUMBER) TABLESPACE TBL02;

BEGIN
    FOR i IN 1..100 LOOP 
        INSERT INTO ETUDIANT VALUES('n' || i , i);    
    END LOOP;
COMMIT;
END;
/

SELECT owner,table_name,tablespace_name FROM DBA_TABLES WHERE tablespace_name = 'TBL02';

-- question 2
SELECT segment_name, segment_type, bytes/1024/1024 as TAILLE_EN_MO FROM dba_extents 
where segment_name = 'ETUDIANT' and tablespace_name = 'TBL02';

-- question 3
SELECT tablespace_name, sum(bytes)/1024/1024 as TAILLE_MO FROM dba_extents 
group by tablespace_name;


select * from DBA_DATA_FILES;
select * from DBA_TABLESPACES;

