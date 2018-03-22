-- Substution variable
SET ECHO OFF
SET VERIFY OFF
set serveroutput on
ACCEPT user_input PROMPT 'Numéro de departement que vous voulez modifier: ' 
DECLARE
    user_input STUDENT.ID_ST%TYPE;
begin 
    UPDATE student SET NOM='sam' WHERE id_st=&user_input;
    if(sql%FOUND) then
        DBMS_OUTPUT.PUT_LINE('Row Affected');
    end if;
end; 
/
