# Block Instances For Course Sites
#
# Returns blocks and number of instances added to courses 
# for a given term.

SELECT
	bi.blockname, 
	COUNT(bi.id) as num
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
    c.TERM_FIELD LIKE 'TERM_EXPRESSION'	
GROUP BY bi.id
ORDER BY bi.blockname
