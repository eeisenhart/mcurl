SELECT 
	count(*) AS number_courses_enrollment_size_301_3000
FROM 
	(SELECT DB_PREFIX_course.shortname, COUNT(DB_PREFIX_role_assignments.id) CC 
	FROM 
	DB_PREFIX_role_assignments INNER JOIN DB_PREFIX_context 
	ON ( DB_PREFIX_role_assignments.contextid = DB_PREFIX_context.id) INNER JOIN DB_PREFIX_course 
	ON ( DB_PREFIX_context.instanceid = DB_PREFIX_course.id) INNER JOIN DB_PREFIX_role 
	ON ( DB_PREFIX_role_assignments.roleid = DB_PREFIX_role.id) 
WHERE DB_PREFIX_course.TERM_FIELD LIKE 'TERM_EXPRESSION' AND DB_PREFIX_role.shortname = 'STUDENT_ROLE' 
GROUP BY DB_PREFIX_course.shortname 
HAVING CC between 301 and 3000) CNT;