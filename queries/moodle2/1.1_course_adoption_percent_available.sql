SET @TOTAL = NUM_COURSES;
SELECT count(*) AS 'made available',
  @TOTAL AS 'total courses', 
  CAST( count(*) / @TOTAL AS DECIMAL(2,2)) AS 'percent available' 
FROM DB_PREFIXcourse
 WHERE TERM_FIELD like TERM_EXPRESSION
 AND visible = 1