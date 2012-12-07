SELECT 
    DEPT_QUERY as 'Department',
    COUNT(DEPT_QUERY) AS 'Course Count by Availability'
FROM
    DB_PREFIX_course
WHERE
    TERM_FIELD LIKE 'TERM_EXPRESSION'
        AND visible = 1
GROUP BY
    DEPT_QUERY
