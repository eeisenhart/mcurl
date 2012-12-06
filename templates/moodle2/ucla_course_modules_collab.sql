# Course Modules For Collab Sites
#
# Returns course modules and number of instances added to 
# collab sites. 
# 
# NOTE: This query is not really useful for anyone else,  
# because we tag collab sites using a specialized table  
# called ucla_siteindicator and registrar courses with 
# ucla_request_classes

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
	c.id NOT IN (
		SELECT	courseid
		FROM	DB_PREFIX_ucla_request_classes		
	)
GROUP BY m.id
ORDER BY m.name
