SET @TOTAL = NUM_COURSES;
 -- SET @TOTAL = (select count(*) from DB_PREFIX_course where TERM_FIELD like 'TERM_EXPRESSION');

SELECT 
    COUNT(*) AS 'Visible course sections with content',
    @TOTAL AS 'Total course sections',
    ROUND(COUNT(*) / @TOTAL * 100,1) AS 'Percent of total'
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
    HAVING COUNT(*) > DEFAULT_NUM_MODULES) AS cc
