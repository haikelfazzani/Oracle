 -- Partie 1: Interagir avec le serveur Oracle
 -- Etudiant : Haikel Fazzani
 
 -- Question 1 , 2 , 3 : 
SET SERVEROUTPUT ON

CREATE TABLE NEW_EMP AS
(SELECT DEPARTMENT_ID , DEPARTMENT_NAME FROM DEPARTMENTS WHERE  1 = 2);

ALTER TABLE NEW_EMP ADD (
    MANAGER_ID NUMBER(6),
    LOCATION_ID NUMBER(4)
);

DESC NEW_EMP;

CREATE OR REPLACE FUNCTION get_max_depatment 
RETURN DEPARTMENTS.department_id%TYPE is
        max_deptno DEPARTMENTS.department_id%TYPE;
    BEGIN
        SELECT MAX(DEPARTMENT_ID) INTO max_deptno
        FROM DEPARTMENTS;
        RETURN max_deptno;
    END;
    /

CREATE OR REPLACE PROCEDURE update_loction_id(num_dept NUMBER) IS
BEGIN
    UPDATE NEW_EMP SET LOCATION_ID = 3000 WHERE 
    DEPARTMENT_ID = num_dept;
END;
/
    
VARIABLE dept_id NUMBER;
DECLARE
    max_deptno DEPARTMENTS.department_id%TYPE := get_max_depatment;
    dept_name DEPARTMENTS.DEPARTMENT_NAME%TYPE := 'Education';
BEGIN
    DBMS_OUTPUT.PUT_LINE('The maxmimum depatment id is : ' || max_deptno);
    max_deptno := max_deptno + 10;
    :dept_id := max_deptno;
    
    INSERT INTO NEW_EMP VALUES(:dept_id, dept_name ,NULL,NULL);
    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Ligne ajoute : ' || TO_CHAR(SQL%ROWCOUNT));
    END IF;
    
    update_loction_id(:dept_id);
    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Ligne modifier : ' || TO_CHAR(SQL%ROWCOUNT));
    END IF;
    
    DELETE FROM NEW_EMP WHERE DEPARTMENT_ID = :dept_id;
    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Ligne supprime : ' || TO_CHAR(SQL%ROWCOUNT));
    END IF;
END;
/

SELECT * FROM NEW_EMP;
