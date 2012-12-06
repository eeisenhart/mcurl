# Average number of threads per forum (Collab) 
#
# Returns the average number of forum threads per forum 
# in collab sites
# 
# NOTE: This query is not really useful for anyone else,  
# because we tag collab sites using a specialized table  
# called ucla_siteindicator and registrar courses with 
# ucla_request_classes

SELECT
	COUNT(DISTINCT d.id) AS Posters,
	COUNT(DISTINCT f.id) AS Forums,
	COUNT(DISTINCT d.id) / COUNT(DISTINCT f.id) AS 'Posters per forum'
FROM 
	DB_PREFIX_forum f
JOIN 
	DB_PREFIX_course c ON (
		c.id = f.course
	)	
LEFT JOIN 
	DB_PREFIX_forum_discussions d ON (
		d.forum = f.id
	)
WHERE 
	c.id NOT IN (
		SELECT	courseid
		FROM	DB_PREFIX_ucla_request_classes		
	)