# Top ten courses that use most disk space for a given term
#
# Returns the top top sites that use the most disk space

SELECT 
    COUNT(*)
FROM
    DB_PREFIX_course c
JOIN 
	DB_PREFIX_course_modules AS cm ON (
		cm.course = c.id
    )
JOIN 
	DB_PREFIX_context ctx ON (
		cm.id = ctx.instanceid AND
		ctx.contextlevel = 70
    )
JOIN DB_PREFIX_files f ON (
    	f.contextid = ctx.id
	) 
WHERE
    c.TERM_FIELD LIKE 'TERM_EXPRESSION'
GROUP BY c.id
ORDER BY course_size DESC
LIMIT 10