templates contains queries for moodle 1 and moodle 2.  In many cases they are 
the identical.

query_builder.py will build a set of queries using the site specific variables
you define in the site_variables.ini file.

1. Copy the site_variables.ini.dist to a new file site_variables.ini.
2. Edit site_variables.ini
3. Run ./query_builder.py on the command line.
4. Open the my_queries folder to see a list of all the queries

Alternatively, simply open you favorite text editor perform a find and replace 
on all the .sql files in either moodle1 or moodle2 using the find and replace 
parameters in the site_variables.ini.dist file.

