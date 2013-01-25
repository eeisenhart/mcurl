# Average number of threads per forum (Course) 
#
# Returns the average number of forum threads per forum in courses
# for a given term.

SELECT
	COUNT(DISTINCT d.id) AS Threads,
	COUNT(DISTINCT f.id) AS Forums,
	COUNT(DISTINCT d.id) / COUNT(DISTINCT f.id) AS 'Threads per forum'
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
	c.TERM_FIELD LIKE 'TERM_EXPRESSION'
