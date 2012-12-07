SELECT 
    DEPT_QUERY as 'Department',
    COUNT(DISTINCT (ue.userid)) AS 'Faculty Count'
FROM
    DB_PREFIX_user_enrolments ue
        JOIN
    DB_PREFIX_enrol e ON (ue.enrolid = e.id)
        JOIN
    DB_PREFIX_course c ON (c.id = e.courseid)
        JOIN
    DB_PREFIX_context ct ON (ct.instanceid = c.id)
        JOIN
    DB_PREFIX_role_assignments ra ON (ra.contextid = ct.id
        AND ue.userid = ra.userid)
        JOIN
    DB_PREFIX_role r ON (ra.roleid = r.id)
WHERE
    c.TERM_FIELD LIKE 'TERM_EXPRESSION'
        AND c.visible = 1
        AND ue.status = 0
        AND ra.shortname = 'FACULTY_ROLE'
        AND ct.contextlevel = 50
GROUP BY
    DEPT_QUERY
    