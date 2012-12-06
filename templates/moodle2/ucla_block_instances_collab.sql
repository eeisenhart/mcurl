# Block Instances For Collab Sites
#
# Returns blocks and number of instances added to collab sites 
# 
# NOTE: This query is not really useful for anyone else,  
# because we tag collab sites using a specialized table  
# called ucla_siteindicator and registrar courses with 
# ucla_request_classes

SELECT
	bi.blockname, 
	COUNT(bi.blockname) as num
FROM 
	DB_PREFIX_course c
JOIN 
	DB_PREFIX_context ct ON (
		ct.contextlevel = 50 AND
		ct.instanceid = c.id
	)	
JOIN 
	DB_PREFIX_block_instances bi ON (
		bi.parentcontextid = ct.id
	)
WHERE
	c.id NOT IN (
		SELECT	courseid
		FROM	DB_PREFIX_ucla_request_classes		
	)
GROUP BY bi.blockname
ORDER BY bi.blockname
