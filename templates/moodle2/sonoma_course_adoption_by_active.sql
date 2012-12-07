SELECT
    DEPT_QUERY as 'Department',
    COUNT(DEPT_QUERY) as 'Course Count with Activity'
FROM
    (SELECT
        DB_PREFIX_course.TERM_FIELD TERM_FIELD, COUNT(DB_PREFIX_log.id) CC
    FROM
        DB_PREFIX_log
    INNER JOIN DB_PREFIX_course ON (DB_PREFIX_log.course = DB_PREFIX_course.id)
    WHERE
        DB_PREFIX_course.TERM_FIELD LIKE 'TERM_EXPRESSION'
    GROUP BY DB_PREFIX_course.TERM_FIELD
    HAVING CC > 50) CNT
GROUP BY
    DEPT_QUERY
