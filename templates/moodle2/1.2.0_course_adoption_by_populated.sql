SET @TOTAL = NUM_COURSES;

SELECT 
    COUNT(*) AS 'Course Count by Populated',
    @TOTAL AS 'Course Total',
    ROUND(COUNT(*) / @TOTAL * 100) AS 'Course Percent'
FROM
    (SELECT 
        COUNT(*)
    FROM
        DB_PREFIX_course c
    JOIN DB_PREFIX_course_modules cm ON (cm.course = c.id)
    WHERE
        c.TERM_FIELD LIKE 'TERM_EXPRESSION'
            AND c.visible = 1
    GROUP BY c.shortname
    HAVING COUNT(*) > 1) AS cc
