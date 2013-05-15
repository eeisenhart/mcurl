SELECT
    DEPT_QUERY as 'Department',
    COUNT(DEPT_QUERY) as 'Course Count with Activity'
FROM
    (SELECT
        c.TERM_FIELD, COUNT(DB_PREFIX_log.id) CC
    FROM
        DB_PREFIX_log
    INNER JOIN DB_PREFIX_course c ON (DB_PREFIX_log.course = c.id)
    WHERE
        c.TERM_FIELD LIKE 'TERM_EXPRESSION'
    GROUP BY c.TERM_FIELD
    HAVING CC > 50) CNT
GROUP BY
    DEPT_QUERY
