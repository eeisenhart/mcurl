SELECT count(*) AS 'made available',
  NUM_COURSES AS 'total courses', 
  CAST( count(*) / NUM_COURSES AS DECIMAL(2,2)) AS 'percent available' 
FROM DB_PREFIXcourse
 WHERE TERM_FIELD like TERM_EXPRESSION
 AND visible = 1