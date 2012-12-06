# Sites with Custom Theme
#
# Returns the number of sites that are overriding the default theme.
# We have a custom theme that allows certain sites to add custom logos
# to the page banner.

SELECT 
    COUNT(*)
FROM
    DB_PREFIX_course c,
	DB_PREFIX_config config
WHERE
    c.theme != '' AND
	config.name = 'theme' AND
	config.value != c.theme