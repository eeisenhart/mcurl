# Inactive Course Sites
#
# Returns the number of inactive courses on system for given term
# Inactive is defined as a course that has not had a single visit
# since the 1st week of the start of the term.
#
# Do not include guest users (should be userid 1)

SET @TIMESTAMP = unix_timestamp('TERM_START_DATE');

SELECT
	COUNT(c.id)
FROM 
	DB_PREFIX_course c
WHERE 
	c.TERM_FIELD LIKE 'TERM_EXPRESSION' AND 
	c.id NOT IN (
		SELECT	l.course
		FROM	DB_PREFIX_log l 
		WHERE	l.userid > 1 AND 
				l.time > (@TIMESTAMP + 604800)
	)
