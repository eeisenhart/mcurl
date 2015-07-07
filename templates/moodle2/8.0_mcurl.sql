-- this series of queries ends up creating a table "mcurl" that will stay 
-- on your system for future queries
-- if you need to rerun this,   drop the mcurl table
-- at the end, it runs a few interesting queries based on that table
-- there is a nice sencha based graphing grid tool that can be used to display the data


-- first lets create a table with courses and number of students
CREATE TEMPORARY TABLE  mcurl_course_users  AS
SELECT DB_PREFIX_course.id, COUNT(DB_PREFIX_role_assignments.id) usercount
        FROM
        DB_PREFIX_role_assignments
     INNER JOIN DB_PREFIX_context ON ( DB_PREFIX_role_assignments.contextid = DB_PREFIX_context.id)
     INNER JOIN DB_PREFIX_course ON ( DB_PREFIX_context.instanceid = DB_PREFIX_course.id)
     INNER JOIN DB_PREFIX_role ON ( DB_PREFIX_role_assignments.roleid = DB_PREFIX_role.id)
WHERE
DB_PREFIX_course.shortname LIKE 'TERM_EXPRESSION' AND
DB_PREFIX_role.shortname = 'student'
GROUP BY DB_PREFIX_course.id ;


-- first lets create a table with courses and number of modules
create temporary table mcurl_course_modules as
SELECT course ncourseid, count(module) nummodules
FROM DB_PREFIX_course_modules, DB_PREFIX_course
WHERE DB_PREFIX_course.id = DB_PREFIX_course_modules.course AND
DB_PREFIX_course.shortname LIKE 'TERM_EXPRESSION'
GROUP BY ncourseid;


-- now create a joined table where there is content and student activity
CREATE temporary table mcurl_core  as
SELECT   c.id, c.visible, c.shortname, COUNT(ml.id) MoodleLogCount FROM DB_PREFIX_course c
left join DB_PREFIX_log ml on ml.course = c.id
WHERE c.shortname LIKE 'TERM_EXPRESSION'
GROUP BY c.id;

-- resources r 
create temporary table r as 
select  cm.course,count(cm.id) Resources 
from DB_PREFIX_course_modules cm
left join DB_PREFIX_course c on c.id = cm.course
left join DB_PREFIX_modules m on m.id = cm.module
WHERE c.shortname LIKE 'TERM_EXPRESSION' AND
m.name in ('resource','label','folder','page','url')
group by cm.course order by Resources asc;


-- activities ma
create temporary table ma as 
select  cm.course,count(cm.id) Activities 
from DB_PREFIX_course_modules cm
left join DB_PREFIX_course c on c.id = cm.course
left join DB_PREFIX_modules m on m.id = cm.module
WHERE c.shortname LIKE 'TERM_EXPRESSION' AND
m.name not in ('resource','label','folder','page','url')
group by cm.course order by Activities asc;



-- learning activities  la 
create temporary table la as 
select  cm.course,count(cm.id) LearningActivities 
from DB_PREFIX_course_modules cm
left join DB_PREFIX_course c on c.id = cm.course
left join DB_PREFIX_modules m on m.id = cm.module
WHERE c.shortname LIKE 'TERM_EXPRESSION' AND
m.name in ('assignment','lesson','quiz','assign')
group by cm.course order by LearningActivities asc;


-- gradeitems gi
create temporary table gi as select  g.courseid,count(g.courseid) gradeitems from DB_PREFIX_grade_items g, DB_PREFIX_course c 
where c.id = g.courseid and
c.shortname LIKE 'TERM_EXPRESSION'
group by g.courseid order by gradeitems asc;


-- posts from the news forum,  want to include quickmail too eventually ni
create temporary table ni as 
SELECT c.id as NEWID, count(p.id) as newsposts  FROM DB_PREFIX_forum_posts p INNER JOIN DB_PREFIX_forum_discussions d ON ( p.discussion = d.id) INNER JOIN DB_PREFIX_forum f ON ( d.forum = f.id) INNER JOIN DB_PREFIX_course c ON ( f.course = c.id) WHERE f.type = 'News' AND c.shortname LIKE 'TERM_EXPRESSION' group by NEWID;





-- mcurl all info curl
-- if you created mcurl before, you'll need to drop first.
drop table if exists mcurl;
create table mcurl as select M.*, mcu.usercount as CourseUserCount, ma.activities, r.Resources,  la.LearningActivities, gi.gradeitems,ni.newsposts from
mcurl_core  M 
left join ma on ma.course = M.id
left join mcurl_course_users mcu  on mcu.id = M.id
left join r on r.course = M.id
left join la on la.course = M.id
left join gi on gi.courseid = M.id
left join ni on ni.NEWID = M.id;

select count(*) as 'News Forum Use'  from mcurl where newsposts  >  0;
select count(*) as 'Gradebook use Use'  from mcurl where gradeitems  >  1;
select count(*) as 'Resource'  from mcurl where Resources  >  0;
select count(*) as 'Activities'  from mcurl where activities  >  1;
select count(*) as 'Learning Activities'  from mcurl where LearningActivities  >  0;
select count(*) as 'Course Sites not being used' from mcurl where Resources is NULL  and activities = 1 and newsposts is NULL and gradeitems is NULL ;
