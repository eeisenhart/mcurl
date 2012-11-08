SET @TOTAL = NUM_COURSES;

SELECT 
    COUNT(*) AS 'Course Count by Availability',
    @TOTAL AS 'Course Total',
    CAST(COUNT(*) / @TOTAL AS DECIMAL (2 , 2 )) AS 'Course Percent'
FROM
    DB_PREFIX_course
WHERE
    TERM_FIELD LIKE 'TERM_EXPRESSION'
        AND visible = 1
