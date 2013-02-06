SET @TOTAL = NUM_COURSES;

SELECT 
    COUNT(*) AS 'Course Count by Availability',
    @TOTAL AS 'Course Total',
    ROUND(COUNT(*) / @TOTAL * 100) AS 'Course Percent'
FROM
    DB_PREFIX_course
WHERE
    TERM_FIELD LIKE 'TERM_EXPRESSION'
        AND visible = 1
