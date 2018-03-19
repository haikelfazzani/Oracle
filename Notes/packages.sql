-- Package Specification
CREATE or REPLACE PACKAGE pkg1
    IS | AS
    PROCEDURE pro1
        (no in number, name out varchar2);
    FUNCTION fun1
        (no in number)
        RETURN varchar2;
    END;                    
/

-- Package Body
CREATE or REPLACE PACKAGE BODY pkg1
IS
    PROCEDURE pro1(no in number,info our varchar2)
        IS
        BEGIN
            SELECT * INTO temp FROM emp1 WHERE eno = no;
        END;
    
    FUNCTION fun1(no in number) return varchar2
        IS
        name varchar2(20);
        BEGIN
            SELECT ename INTO name FROM emp1 WHERE eno = no;
            RETURN name;
        END;
END;
/

-- Pl/SQL Program calling Package
DECLARE
    no number := &no;
    name varchar2(20);
BEGIN
    pkg1.pro1(no,info);
    dbms_output.put_line('Procedure Result');
    dbms_output.put_line(info.eno||'     '||
                         info.ename||'   '||
                         info.edept||'   '||
                         info.esalary||' '||);
    dbms_output.put_line('Function Result');                         
    name := pkg1.fun1(no);
    dbms_output.put_line(name);
END;    
/
