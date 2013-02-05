create temporary table 'course_summary' (
	'id' INT UNSIGNED NOT NULL AUTO_INCREMENT, 
	'course_id' BIGINT(10),
	'shortname' VARCHAR(255),
    'category_name' VARCHAR(255),
	'active' INT UNSIGNED,
	'content' INT UNSIGNED,
	'activity' INT UNSIGNED,
	PRIMARY KEY('course_id'),
	UNIQUE('shortname')
)


