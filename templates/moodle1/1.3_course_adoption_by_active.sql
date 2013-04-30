SET @TOTAL = NUM_COURSES;
<<<<<<< HEAD

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
    HAVING CC > 50) CNT
=======
set @NUMLOG = LOG_ENTRIES_STUDENT;
 -- SET @TOTAL = (select count(*) from DB_PREFIX_course where TERM_FIELD like 'TERM_EXPRESSION');


-- create helper table
create temporary table mcurl_users  as
SELECT DB_PREFIX_course.id, COUNT(DB_PREFIX_role_assignments.id) usercount
        FROM
        DB_PREFIX_role_assignments INNER JOIN DB_PREFIX_context
        ON ( DB_PREFIX_role_assignments.contextid = DB_PREFIX_context.id) INNER JOIN DB_PREFIX_course
        ON ( DB_PREFIX_context.instanceid = DB_PREFIX_course.id) INNER JOIN DB_PREFIX_role
        ON ( DB_PREFIX_role_assignments.roleid = DB_PREFIX_role.id)
WHERE
    DB_PREFIX_course.TERM_FIELD LIKE 'TERM_EXPRESSION'
AND DB_PREFIX_role.shortname = 'STUDENT_ROLE'
GROUP BY DB_PREFIX_course.id ;


SELECT
    COUNT(DISTINCT CNT.shortname) AS 'Visible course sections with content and activity',
    @TOTAL AS 'Total course sections',
    ROUND(COUNT(DISTINCT CNT.shortname) / @TOTAL * 100,1) AS 'Percent of total'
 -- Get courses that are visible and have activity this term
FROM
    (SELECT
        c.shortname, COUNT(ml.id) CC, mcurl_users.usercount UC
    FROM
        DB_PREFIX_log ml
    JOIN DB_PREFIX_course c ON (ml.course = c.id)
    JOIN mcurl_users  ON (ml.course = mcurl_users.id)
    WHERE
        c.TERM_FIELD LIKE 'TERM_EXPRESSION'
        AND c.visible = 1
        -- only count activity during the specified term.
        AND ml.time > unix_timestamp('TERM_START_DATE')
        AND ml.time < unix_timestamp('TERM_END_DATE')

    GROUP BY c.shortname
    HAVING ((CC/UC)>@NUMLOG) ) CNT
 -- Join with courses that are visible and have content
JOIN
    (SELECT
        c.shortname, COUNT(c.shortname)
    FROM
        DB_PREFIX_course c
    JOIN DB_PREFIX_course_modules cm ON (cm.course = c.id)
    WHERE
        c.TERM_FIELD LIKE 'TERM_EXPRESSION'
        AND c.visible = 1
    GROUP BY c.shortname
    HAVING COUNT(*) > DEFAULT_NUM_MODULES) CC
ON (CNT.shortname = CC.shortname); 
>>>>>>> 7942d1bbef77d5b50c06b9c251841af8b8789393
