-- Delete a column
ALTER TABLE table_name
  DROP COLUMN column_name;

-- Add a simple column 
ALTER TABLE table_name
  ADD column_name column-definition;


-- Add a multiple column
ALTER TABLE table_name
  ADD (column_1 column-definition,
       column_2 column-definition,
       ...
       column_n column_definition);

-- Mpdify a multiple column 
ALTER TABLE table_name
  MODIFY (column_1 column_type,
          column_2 column_type,
          ...
          column_n column_type);
