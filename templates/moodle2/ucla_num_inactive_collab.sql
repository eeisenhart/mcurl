# Inactive Collaboration Sites
#
# Returns the number of inactive collab sites on system.
# Inactive is defined as a site that has not had a single 
# visit in the last 6 months.
#
# Do not include guest users (should be userid 1)
#
# NOTE: This query is not really useful for anyone else,  
# because we tag collab sites using a specialized table  
# called ucla_siteindicator and registrar courses with 
# ucla_request_classes

SELECT
	COUNT(c.id)
FROM 
	DB_PREFIX_course c	
WHERE 
	c.id NOT IN (
		SELECT	courseid
		FROM	DB_PREFIX_ucla_request_classes		
	) AND
	c.id NOT IN	(
		SELECT	course
		FROM	DB_PREFIX_log l 
		WHERE	userid > 1 AND 
				time > (UNIX_TIMESTAMP(NOW()) - 15778458)
	)