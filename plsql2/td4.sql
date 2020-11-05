-- Td 4 : Haikel Fazzani
SET SERVEROUTPUT ON


-- Exercice 1 :
SET SERVEROUTPUT ON
            
CREATE OR REPLACE PROCEDURE manager_of_emp(emp_id EMPLOYEES.EMPLOYEE_ID%TYPE) IS
    nom EMPLOYEES.FIRST_NAME%TYPE; 
    prenom EMPLOYEES.LAST_NAME%TYPE; 
    
    nom_mang EMPLOYEES.FIRST_NAME%TYPE; 
    pren_manag EMPLOYEES.LAST_NAME%TYPE; 
BEGIN
    SELECT e1.FIRST_NAME ,e1.last_name , e2.first_name , e2.last_name 
    INTO nom , prenom , nom_mang , pren_manag
    FROM employees e1 left outer join employees e2
    ON e1.manager_id = e2.EMPLOYEE_ID
    WHERE e1.EMPLOYEE_ID = emp_id
    ORDER BY e1.EMPLOYEE_ID;
    
    IF nom_mang IS NULL OR pren_manag IS NULL THEN
        DBMS_OUTPUT.PUT_LINE(' --> Ce employee n a pas un manager');
    ELSE
        DBMS_OUTPUT.PUT_LINE(
            'Nom employee : ' || nom || chr(10) || 
            'Prenom employee : ' || prenom || chr(10) || 
            'Nom Manager : ' || nom_mang || chr(10) || 
            'Prenom Manager : ' || pren_manag || chr(10) 
        );
    END IF;
END;
/

EXECUTE manager_of_emp(107);
EXECUTE manager_of_emp(100);
    
    
-- Exercice 2 :
SELECT * FROM JOB_HISTORY;
CREATE OR REPLACE PROCEDURE afficher_historique(emp_id EMPLOYEES.EMPLOYEE_ID%TYPE) IS
    date_debut JOB_HISTORY.START_DATE%TYPE;
    date_fin JOB_HISTORY.END_DATE%TYPE;
    dept_id JOB_HISTORY.DEPARTMENT_ID%TYPE;
BEGIN
    SELECT START_DATE , END_DATE , DEPARTMENT_ID INTO date_debut , date_fin ,dept_id
    FROM JOB_HISTORY WHERE EMPLOYEE_ID = emp_id;
    DBMS_OUTPUT.PUT_LINE(
        ' --> La date de debut est : ' || date_debut || chr(10) ||
        ' --> Date de fin est : ' || date_fin || chr(10) ||
        ' -- > Departement id est : ' || dept_id);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/
EXECUTE afficher_historique(100);
EXECUTE afficher_historique(102);


-- Exercice 3 :
CREATE OR REPLACE FUNCTION MAX_DEPT RETURN NUMBER IS
    max_dep NUMBER;
BEGIN
    SELECT * INTO max_dep FROM(SELECT COUNT(*) FROM EMPLOYEES GROUP BY DEPARTMENT_ID ORDER BY COUNT(*) DESC) 
    WHERE ROWNUM < 2;
    RETURN max_dep;
END;
/
CREATE OR REPLACE FUNCTION NUMBER_EMPLO(dept_id_input EMPLOYEES.DEPARTMENT_ID%TYPE) RETURN NUMBER IS
    num_emp NUMBER; 
BEGIN
    SELECT COUNT(*) INTO num_emp FROM EMPLOYEES WHERE DEPARTMENT_ID = dept_id_input;
    return num_emp;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/
DECLARE
    max_dep number;
    num_emp number;
BEGIN
    num_emp := NUMBER_EMPLO(90);
    max_dep := MAX_DEPT;
    if num_emp > max_dep THEN
        DBMS_OUTPUT.PUT_LINE('ce département est qui contient le plus d employes');
    else
        DBMS_OUTPUT.PUT_LINE('ce département ne contient pas le plus d employes');
    END IF;
END;
/


-- Exercice 4 :
SET SERVEROUTPUT ON
CREATE OR REPLACE PROCEDURE my_insert (
    id_job JOBS.JOB_ID%TYPE , 
    tit_job JOBS.JOB_TITLE%TYPE , 
    min_sal JOBS.MIN_SALARY%TYPE , 
    max_sal JOBS.MAX_SALARY%TYPE 
) IS
    sal_exception EXCEPTION;
BEGIN
    IF min_sal > max_sal THEN
        RAISE sal_exception;
    ELSE
        INSERT INTO JOBS VALUES(id_job,tit_job,min_sal,max_sal);
    END IF;
    EXCEPTION
        WHEN sal_exception THEN
            DBMS_OUTPUT.PUT_LINE(' --> Erreur d insertion');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

EXECUTE my_insert('Ouvrier3' ,'Programmer' ,40000,2000);
