# Courses per Term
#
# Returns the number of courses on system for given term

SELECT 
    COUNT(*)
FROM
    DB_PREFIX_course c
WHERE
    c.TERM_FIELD LIKE 'TERM_EXPRESSION'
