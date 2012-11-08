SET @TOTAL = NUM_COURSES;

SELECT 
    COUNT(*) as 'Course Count with Activity',
	@TOTAL AS 'Course Total',
    CAST( COUNT(*) / @TOTAL AS DECIMAL(2,2)) AS 'Course Percent'
FROM
    (SELECT 
        DB_PREFIX_course.shortname, COUNT(DB_PREFIX_log.id) CC
    FROM
        DB_PREFIX_log
    INNER JOIN DB_PREFIX_course ON (DB_PREFIX_log.course = DB_PREFIX_course.id)
    WHERE
        DB_PREFIX_course.TERM_FIELD LIKE 'TERM_EXPRESSION'
    GROUP BY DB_PREFIX_course.shortname
    HAVING CC > 50) CNT;