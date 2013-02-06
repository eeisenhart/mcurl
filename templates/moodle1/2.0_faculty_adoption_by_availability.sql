SET @TOTAL = NUM_FACULTY;

SELECT
     COUNT(DISTINCT (ra.userid)) AS 'Faculty Count',
     @TOTAL AS 'Faculty Total',
     CAST(COUNT(DISTINCT (ra.userid)) / @TOTAL AS DECIMAL (2 , 2 )) AS
'Faculty Percent'
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
