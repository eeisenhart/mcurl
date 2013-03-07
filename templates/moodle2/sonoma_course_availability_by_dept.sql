-- Course Counts And Availability By Department
-- ===============================================

SELECT
    substring_index(c.idnumber,'-',1) as 'Department',
    count(*) as 'Course Count by Dept',
    sum(visible) as 'Available'
FROM
    DB_PREFIX_course c
WHERE TERM_FIELD LIKE 'TERM_EXPRESSION'
  and substring_index(c.idnumber,'-',1) != 'M'
--        AND visible = 1
GROUP BY
    substring_index(c.TERM_FIELD,'-',1);
