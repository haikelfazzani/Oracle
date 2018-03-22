-- Oracle doesn't provide such IIF Function. Instead, try using one of the following alternatives:

-- DECODE Funciton:

SELECT DECODE(EMP_ID, 1, 'True', 'False') from Employee

CASE Function:
SELECT CASE WHEN EMP_ID = 1 THEN 'True' ELSE 'False' END from Employee

-- Two other alternatives:

-- a combination of NULLIF and NVL2. You can only use this if emp_id is NOT NULL, which it is in your case:

select nvl2(nullif(emp_id,1),'False','True') from employee;

select case emp_id when 1 then 'True' else 'False' end from employee;
