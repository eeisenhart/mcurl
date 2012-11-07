SET @TOTAL = NUM_COURSES;

select count(distinct(ue.userid)) as 'Faculty using LMS',
  @TOTAL AS 'Total faculty',
  CAST( count(distinct(ue.userid)) / @TOTAL AS DECIMAL(2,2)) AS 'Percent using LMS'
from DB_PREFIXuser_enrolments ue
  join DB_PREFIXenrol e on (ue.enrolid=e.id)
  join DB_PREFIXcourse c on (c.id=e.courseid)
  join (select * from DB_PREFIXcontext where contextlevel=50) ct on (ct.instanceid=c.id)
  join (select * from DB_PREFIXrole_assignments) ra on (ra.contextid=ct.id and ue.userid=ra.userid)
  join DB_PREFIXrole r on (ra.roleid = r.id)
where c.TERM_FIELD like 'TERM_EXPRESSION'
  and c.visible=1
  and ue.status=0
  and r.shortname = 'FACULTY_ROLE'
order by c.idnumber
