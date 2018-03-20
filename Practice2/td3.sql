-- Td 3 : Haikel Fazzani
SET SERVEROUTPUT ON

-- Exercice 1 :
```
CREATE OR REPLACE PROCEDURE AFFICHER_DEPART IS
    CURSOR curs IS SELECT DEPARTMENT_NAME , MANAGER_ID FROM DEPARTMENTS;
    nom_depart DEPARTMENTS.DEPARTMENT_NAME%TYPE;
    manag_id DEPARTMENTS.MANAGER_ID%TYPE;
BEGIN
    OPEN curs;
    LOOP 
        FETCH curs INTO nom_depart , manag_id;
        EXIT WHEN curs%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Numero de departement : ' || nom_depart || ' | gere par : ' || manag_id);
    END LOOP;
    CLOSE curs;
END;
/
EXECUTE AFFICHER_DEPART;
```

-- Exercice 2 :
CREATE OR REPLACE PROCEDURE CHECK_SALARY(salaire EMPLOYEES.SALARY%TYPE) IS
BEGIN
    IF salaire < 6000 THEN
        DBMS_OUTPUT.PUT_LINE(' ==> Ce employe n ecessite une augmentation salaire');
    END IF;
END;
/
CREATE OR REPLACE PROCEDURE AFFICHER_EMP IS
    CURSOR curs IS SELECT first_name , hire_date , salary FROM EMPLOYEES 
    WHERE HIRE_DATE > '01/01/1994';
    names EMPLOYEES.FIRST_NAME%TYPE;
    hire EMPLOYEES.HIRE_DATE%TYPE;
    salaire EMPLOYEES.SALARY%TYPE;
BEGIN
    OPEN curs;
        LOOP FETCH curs INTO names , hire , salaire;
        EXIT WHEN curs%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Nom d employee : ' || names || 
        ' Date d embauche : ' || hire || ' Salaire est : ' || salaire);
        CHECK_SALARY(salaire);
    END LOOP;
    CLOSE curs;
END;
/
EXECUTE AFFICHER_EMP;


-- Exercice 3 :
--CREATE TABLE High_salaries AS (SELECT * FROM EMPLOYEES WHERE EMPLOYEE_ID = 1);
CREATE OR REPLACE PROCEDURE HIGH_SALARY IS
    CURSOR curs IS SELECT * FROM (
        SELECT * FROM EMPLOYEES ORDER BY SALARY DESC
    ) WHERE ROWNUM < &user_input+1;
    emp EMPLOYEES%ROWTYPE;
BEGIN
    OPEN curs;
    LOOP FETCH curs into emp;
    EXIT WHEN curs%NOTFOUND;
        INSERT INTO High_salaries VALUES(emp.EMPLOYEE_ID , emp.FIRST_Name ,
        emp.LAST_NAME , emp.EMAIL ,emp.PHONE_NUMBER, emp.HIRE_DATE , emp.JOB_ID,
        emp.SALARY , emp.COMMISSION_PCT , emp.MANAGER_ID , emp.DEPARTMENT_ID);
        if sql%FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Ligne ajoute : ' || to_char(sql%rowcount));
        END IF;
    END LOOP;
END;
/
EXECUTE HIGH_SALARY;
 
    --CREATE TABLE High_salaries AS (
        --SELECT * FROM (SELECT * FROM EMPLOYEES ORDER BY SALARY DESC)
       -- WHERE ROWNUM < &user_input
    --);

SELECT * FROM EMPLOYEES;
SELECT * FROM High_salaries;


-- Exercice 4 :
SET SERVEROUTPUT ON
DECLARE
    CURSOR curs IS SELECT DEPARTMENT_ID , DEPARTMENT_NAME
    FROM DEPARTMENTS WHERE DEPARTMENT_ID < 100
    ORDER BY DEPARTMENT_ID;
    
    CURSOR curs_emp(dept_id EMPLOYEES.DEPARTMENT_ID%TYPE) 
    IS SELECT LAST_NAME ,HIRE_DATE , JOB_ID
    FROM EMPLOYEES WHERE EMPLOYEE_ID < 120 AND DEPARTMENT_ID = dept_id;
    
BEGIN

    IF curs%ISOPEN THEN
        DBMS_OUTPUT.PUT_LINE('Cursor is open');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Cursor is not open');
    END IF;
    
    FOR crs IN curs LOOP
        FOR c_emp IN curs_emp(crs.DEPARTMENT_ID) LOOP
            DBMS_OUTPUT.PUT_LINE(
                'Nom employee : ' || c_emp.LAST_NAME || chr(10) ||
                'Date embauche employee : ' || c_emp.HIRE_DATE || chr(10) ||
                'Job id employee : ' || c_emp.JOB_ID || chr(10)
            );
        END LOOP;
    END LOOP;
END;
/
