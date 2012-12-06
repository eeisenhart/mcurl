# Course Modules For Course Sites
#
# Returns course modules and number of instances added to courses 
# for a given term.

SELECT
	m.name, 
	COUNT(cm.id) as num
FROM 
	DB_PREFIX_course c
JOIN 
	DB_PREFIX_course_modules cm ON (
		cm.course = c.id
	)	
JOIN 
	DB_PREFIX_modules m ON (
		m.id = cm.module
	)
WHERE
    c.TERM_FIELD LIKE 'TERM_EXPRESSION'	
GROUP BY m.id
ORDER BY m.name
