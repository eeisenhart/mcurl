SET @TOTAL = NUM_FACULTY;

SELECT 
    COUNT(DISTINCT (ue.userid)) AS 'Faculty Count',
    @TOTAL AS 'Faculty Total',
    CAST(COUNT(DISTINCT (ue.userid)) / @TOTAL AS DECIMAL (2 , 2 )) AS 'Faculty Percent'
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
    c.TERMFIELD LIKE 'TERM_EXPRESSION'
        AND c.visible = 1
        AND ue.status = 0
        AND r.shortname = 'FACULTY_ROLE'
        AND ct.contextlevel = 50
