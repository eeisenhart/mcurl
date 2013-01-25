# Average number of posters per forum (Course) 
#
# Returns the average number of forum users per forum in courses
# for a given term.

SELECT
	COUNT(DISTINCT p.userid) AS Posters,
	COUNT(DISTINCT f.id) AS Forums,
	COUNT(DISTINCT p.userid) / COUNT(DISTINCT f.id) AS 'Posters per forum'
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
LEFT JOIN 
	DB_PREFIX_forum_posts p ON (
		p.discussion = d.id
	)
WHERE 
	c.TERM_FIELD LIKE 'TERM_EXPRESSION'
