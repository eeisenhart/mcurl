SET @TOTAL = NUM_COURSES;
 -- SET @TOTAL = (select count(*) from DB_PREFIX_course where TERM_FIELD like 'TERM_EXPRESSION');

SELECT 
    COUNT(DISTINCT CNT.shortname) AS 'Visible course sections with content and activity',
    @TOTAL AS 'Total course sections',
    ROUND(COUNT(DISTINCT CNT.shortname) / @TOTAL * 100,1) AS 'Percent of total'
 -- Get courses that are visible and have activity this term
FROM
    (SELECT 
        c.shortname, COUNT(ml.id) CC
    FROM
        DB_PREFIX_log ml
    JOIN mdl_course c ON (ml.course = c.id)
    WHERE
        c.TERM_FIELD LIKE 'TERM_EXPRESSION'
        AND c.visible = 1
        -- only count activity during the specified term.
        AND ml.time > unix_timestamp('TERM_START_DATE')
        AND ml.time < unix_timestamp('TERM_END_DATE')
        
    GROUP BY c.shortname
    HAVING CC > 50) CNT
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
ON (CNT.shortname = CC.shortname)
