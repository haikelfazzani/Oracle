cursor v_sql is select id, name from students;
for rec in v_sql 
loop
    -- do anything
end loop;
---------------------------------------------------------

v_sql := 'select id, name from students';
open cur for v_sql;
for rec in cur loop
    -- do anything
end loop;
---------------------------------------------------------

cursor cur is select id, name from students;
open cur;
for rec in cur loop
        -- do anything
end loop;
---------------------------------------------------------

for rec in (select id, name from students) loop
    -- do anything
end loop
