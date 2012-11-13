MCURL - Not Minecraft URL Launcher

The templates folder contains queries for moodle 1 and moodle 2.  In many cases 
they are the identical.

The python script 'query_builder.py' will build a set of queries using the site
specific variables you define in the site_variables.ini file.  The idea is,
every site will have a "unique" installation, these variables can be stored in
this file and will be used to build the common queries.

1. Copy the site_variables.ini.dist to a new file site_variables.ini.
2. Edit site_variables.ini
3. Run ./query_builder.py on the command line.
4. Open the my_queries folder to see a list of all the queries.
5. Manually run the queries or set them to run on a schedule.

This script takes an optional argument specifiying the ini settings file used
to create the queries.  This is useful for multiple terms or moodle instances.

Alternatively, simply open you favorite text editor perform a find and replace 
on all the .sql files in either moodle1 or moodle2 using the find and replace 
parameters in the site_variables.ini.dist file.

