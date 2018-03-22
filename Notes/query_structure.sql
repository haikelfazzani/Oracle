SELECT COL1 , SUM(COL2)
FROM TABLE_NAME
WHERE [CONDITION]
GROUP BY COL1 ,COL2
HAVING SUM(COL2) > 14000
ORDER BY COL1 ,COL2;