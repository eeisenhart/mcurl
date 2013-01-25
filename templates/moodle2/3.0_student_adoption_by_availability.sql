SET @TOTAL = NUM_STUDENTS;

SELECT 
    COUNT(DISTINCT (ue.userid)) AS 'Students enrolled in more than 1 visible course',
    @TOTAL AS 'Total number of students',
    ROUND(COUNT(DISTINCT (ue.userid)) / @TOTAL * 100) AS 'Percent of total'
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
        AND r.shortname = 'STUDENT_ROLE'
        AND ct.contextlevel = 50
