SET @TOTAL = NUM_COURSES;
 -- SET @TOTAL = (select count(*) from DB_PREFIX_course where TERM_FIELD like 'TERM_EXPRESSION');

SELECT 
    COUNT(*) AS 'Course Count by Availability',
    @TOTAL AS 'Course Total',
    CAST(COUNT(*) / @TOTAL AS DECIMAL (2 , 2 )) AS 'Course Percent'
FROM
    DB_PREFIX_course
WHERE
    TERM_FIELD LIKE 'TERM_EXPRESSION'
        AND visible = 1
