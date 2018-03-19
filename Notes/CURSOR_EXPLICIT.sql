v_sql := 'select id, name from students';
open cur for v_sql;
for rec in cur loop
    -- do anything
end loop;
Or you can do this

cursor cur is select id, name from students;
open cur;
for rec in cur loop
        -- do anything
end loop;
Or you can do this

for rec in (select id, name from students) loop
    -- do anything
end loop
