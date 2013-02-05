SET @TOTAL = NUM_FACULTY;

SELECT
     COUNT(DISTINCT (ue.userid)) AS 'Instructors teaching at least 1 visible course section',
     @TOTAL AS 'Total number of instructors',
     ROUND(COUNT(DISTINCT (ue.userid)) / @TOTAL * 100,1) AS 'Percent of total'
FROM
     DB_PREFIX_course  c
         JOIN
     DB_PREFIX_context ct ON (c.id = ct.instanceid)
         JOIN
     DB_PREFIX_role_assignments ra ON (ra.contextid = ct.id)
         JOIN
     DB_PREFIX_role r ON (ra.roleid = r.id)
WHERE
     c.TERM_FIELD LIKE 'TERM_EXPRESSION'
         AND c.visible = 1
         AND r.shortname = 'FACULTY_ROLE'
         AND ct.contextlevel = 50
