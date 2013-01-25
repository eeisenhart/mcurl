SET @TOTAL = NUM_COURSES;
 -- SET @TOTAL = (select count(*) from DB_PREFIX_course where TERM_FIELD like 'TERM_EXPRESSION');

SELECT 
    COUNT(*) AS 'Visible course sections',
    @TOTAL AS 'Total course sections',
    ROUND(COUNT(*) / @TOTAL * 100) AS 'Percent of total'
FROM
    DB_PREFIX_course
WHERE
    TERM_FIELD LIKE 'TERM_EXPRESSION'
        AND visible = 1
