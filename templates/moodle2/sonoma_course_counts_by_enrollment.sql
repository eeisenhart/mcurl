-- $Id: sonoma_course_counts_by_enrollment.sql,v 1.2 2013/04/16 22:54:50 eric Exp $
SELECT   Category,   
         count(*) AS 'Total Courses,
         sum(VIS) as Available,
         ROUND((sum(VIS)/count(*))*100,1) as Percent
FROM
(SELECT c.TERM_FIELD,        
       c.visible VIS,
       COUNT(a.id) CC,
       CASE 
          WHEN COUNT(a.id) <    6                       THEN '  1 to   5 students '
          WHEN COUNT(a.id) >=   6 and COUNT(a.id) <  16 THEN '  6 to  15 students '
          WHEN COUNT(a.id) >=  16 and COUNT(a.id) <  27 THEN ' 16 to  26 students '
          WHEN COUNT(a.id) >=  27 and COUNT(a.id) < 101 THEN ' 27 to 100 students '
          WHEN COUNT(a.id) >= 101 and COUNT(a.id) < 301 THEN '101 to 300 students '
          WHEN COUNT(a.id) >= 301                       THEN '301+       students '
          ELSE                                               'Undetermined students '
       END  as CATEGORY
FROM
   DB_PREFIX_role_assignments a,
   DB_PREFIX_context t,
   DB_PREFIX_course c
where  t.id = a.contextid
  and  c.id = t.instanceid           
  and  a.roleid = '9'          /*student */
  and  c.TERM_FIELD LIKE 'TERM_EXPRESSION'
GROUP BY c.TERM_FIELD, c.visible) SUB
GROUP BY CATEGORY;
